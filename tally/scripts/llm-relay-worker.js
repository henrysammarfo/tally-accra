/**
 * Cloudflare Worker relay for AgentRouter (Path C — no Tor in serverless).
 * Deploy: wrangler deploy
 * Env secrets: AGENTROUTER_API_KEY
 * Then set TALLY_LLM_RELAY_URL=https://YOUR_WORKER.workers.dev/v1 on Serverpod Cloud / Vercel.
 */
export interface Env {
  AGENTROUTER_API_KEY: string;
  RELAY_SHARED_SECRET?: string;
}

const UPSTREAM = "https://agentrouter.org/v1/chat/completions";

const stainless = {
  Accept: "application/json",
  "User-Agent": "QwenCode/0.2.0 (linux; x64)",
  "x-stainless-lang": "js",
  "x-stainless-package-version": "6.34.0",
  "x-stainless-os": "Linux",
  "x-stainless-arch": "x64",
  "x-stainless-runtime": "node",
  "x-stainless-runtime-version": "node/20.0.0",
  "x-stainless-retry-count": "0",
};

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (request.method === "GET" && url.pathname === "/health") {
      return new Response("ok", { status: 200 });
    }
    if (request.method !== "POST" || !url.pathname.endsWith("/chat/completions")) {
      return new Response("Not found", { status: 404 });
    }
    if (env.RELAY_SHARED_SECRET) {
      const auth = request.headers.get("Authorization") ?? "";
      if (auth !== `Bearer ${env.RELAY_SHARED_SECRET}`) {
        return new Response("Unauthorized", { status: 401 });
      }
    }
    const body = await request.text();
    const upstream = await fetch(UPSTREAM, {
      method: "POST",
      headers: {
        ...stainless,
        "Content-Type": "application/json",
        Authorization: `Bearer ${env.AGENTROUTER_API_KEY}`,
      },
      body,
    });
    const text = await upstream.text();
    return new Response(text, {
      status: upstream.status,
      headers: { "Content-Type": "application/json" },
    });
  },
};
