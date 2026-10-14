import { useEffect, useState } from "react";
import { getCookieConsent, type ConsentValue } from "./cookie-consent";

/**
 * Privacy-friendly analytics (Plausible). Loads only when:
 * - VITE_PLAUSIBLE_DOMAIN is set, and
 * - the visitor accepted analytics cookies.
 * Never put API secrets in VITE_* vars.
 */
export function Analytics() {
  const [consent, setConsent] = useState<ConsentValue | null>(null);
  const domain = import.meta.env.VITE_PLAUSIBLE_DOMAIN as string | undefined;

  useEffect(() => {
    setConsent(getCookieConsent());
    const onConsent = (event: Event) => {
      const detail = (event as CustomEvent<ConsentValue>).detail;
      setConsent(detail);
    };
    window.addEventListener("tally-consent", onConsent);
    return () => window.removeEventListener("tally-consent", onConsent);
  }, []);

  useEffect(() => {
    if (!domain || consent !== "accepted") return;
    if (document.querySelector('script[data-tally-analytics="plausible"]')) return;
    const script = document.createElement("script");
    script.defer = true;
    script.dataset.domain = domain;
    script.dataset.tallyAnalytics = "plausible";
    script.src = "https://plausible.io/js/script.js";
    document.head.appendChild(script);
  }, [consent, domain]);

  return null;
}
