import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";

const InsightInput = z.object({
  question: z.string().min(3).max(500),
  context: z.string().min(1).max(8000),
});

export type InsightResult = { text: string } | { error: string };

export const askTallyInsight = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => InsightInput.parse(input))
  .handler(async ({ data }): Promise<InsightResult> => {
    const key = process.env["LOVABLE_API_KEY"];
    if (!key) return { error: "AI is not configured for this workspace yet." };

    const response = await fetch("https://ai.gateway.lovable.dev/v1/responses", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Lovable-API-Key": key,
        "X-Lovable-AIG-SDK": "fetch",
      },
      body: JSON.stringify({
        model: "openai/gpt-6-astra",
        stream: true,
        reasoning: { effort: "low", summary: "auto" },
        include: ["reasoning.encrypted_content"],
        instructions:
          "You are the operations analyst for TALLY, a guest-house till and night ledger used in Accra, Ghana. Answer strictly from the supplied shift data. Amounts are Ghana Cedis (GH₵). Reply in at most 90 words: one direct answer sentence, then two or three short bullet lines with concrete numbers and one operational recommendation. No preamble, no markdown headings.",
        input: `Shift data:\n${data.context}\n\nManager question: ${data.question}`,
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
    if (!answer) return { error: "The AI service returned an empty answer. Try rephrasing the question." };
    return { text: answer };
  });
