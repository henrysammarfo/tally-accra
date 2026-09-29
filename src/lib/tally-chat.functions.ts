import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";

const ChatInput = z.object({
  messages: z
    .array(z.object({ role: z.enum(["user", "assistant"]), content: z.string().min(1).max(4000) }))
    .min(1)
    .max(30),
  context: z.string().min(1).max(8000),
});

export type ChatResult = { text: string } | { error: string };

/** Fail closed — desk chat is Track A only. */
export const askTallyAssistant = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => ChatInput.parse(input))
  .handler(async (): Promise<ChatResult> => {
    return {
      error:
        "Desk assistant runs on the live Serverpod till with AgentRouter. Not available on the marketing site.",
    };
  });
