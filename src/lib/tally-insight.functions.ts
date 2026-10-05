import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";

const InsightInput = z.object({
  question: z.string().min(3).max(500),
  context: z.string().min(1).max(8000),
});

export type InsightResult = { text: string } | { error: string };

/**
 * Marketing site does not run desk AI. Insight lives on Track A Serverpod
 * (InsightEndpoint + AgentRouter). Fail closed — never invent answers.
 */
export const askTallyInsight = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => InsightInput.parse(input))
  .handler(async (): Promise<InsightResult> => {
    return {
      error:
        "Desk insight runs on the Flutter + Serverpod till (AgentRouter). This marketing site does not proxy AI.",
    };
  });
