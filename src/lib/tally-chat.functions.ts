import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";

const ChatInput = z.object({
  messages: z.array(z.object({ role: z.enum(["user", "assistant"]), content: z.string().min(1).max(4000) })).min(1).max(30),
  context: z.string().min(1).max(8000),
});

export type ChatResult = { text: string } | { error: string };

export const askTallyAssistant = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => ChatInput.parse(input))
  .handler(async ({ data }): Promise<ChatResult> => {
    const key = process.env["LOVABLE_API_KEY"];
    if (!key) return { error: "AI is not configured for this workspace yet." };

    const response = await fetch("https://ai.gateway.lovable.dev/v1/responses", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Lovable-API-Key": key, "X-Lovable-AIG-SDK": "fetch" },
      body: JSON.stringify({
        model: "openai/gpt-6-astra",
        stream: true,
        store: false,
        reasoning: { effort: "low", summary: "auto" },
        include: ["reasoning.encrypted_content"],
        instructions:
          "You are the desk assistant for TALLY, a guest-house till and night ledger in Accra, Ghana. Answer from the supplied shift data whenever the question touches deposits, rooms, payment methods, shift close or merch orders; say plainly when the data does not contain the answer. Amounts are Ghana Cedis (GH₵). Keep replies under 90 words, conversational, with concrete numbers. No markdown headings.",
        input: [
          { role: "user", content: [{ type: "input_text", text: `Current desk data:\n${data.context}` }] },
          ...data.messages.map((message) => ({
            role: message.role,
            content: [{ type: message.role === "assistant" ? "output_text" : "input_text", text: message.content }],
          })),
        ],
      }),
    });

    if (!response.ok || !response.body) {
      if (response.status === 429) return { error: "The AI service is busy right now. Try again in a moment." };
      if (response.status === 402) return { error: "AI credits are exhausted. Add credits in workspace settings to continue." };
      if (response.status === 403) return { error: "This workspace is not allowed to run this AI request." };
      return { error: `The AI service could not answer (status ${response.status}).` };
    }

    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let buffer = "";
    let text = "";
    let reasoning = "";

    while (true) {
      const chunk = await reader.read();
      if (chunk.done) break;
      buffer += decoder.decode(chunk.value, { stream: true });
      const lines = buffer.split("\n");
      buffer = lines.pop() ?? "";
      for (const line of lines) {
        if (!line.startsWith("data:")) continue;
        const payload = line.slice(5).trim();
        if (!payload || payload === "[DONE]") continue;
        try {
          const event = JSON.parse(payload) as { type?: string; delta?: string };
          if (event.type === "response.output_text.delta" && typeof event.delta === "string") text += event.delta;
          if (event.type === "response.reasoning_summary_text.delta" && typeof event.delta === "string") reasoning += event.delta;
        } catch {
          // ignore keep-alive and partial frames
        }
      }
    }

    const answer = text.trim() || reasoning.trim();
    if (!answer) return { error: "The assistant returned an empty answer. Try rephrasing." };
    return { text: answer };
  });
