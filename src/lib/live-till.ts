/** Public URL for the Track A Flutter till (Serverpod Cloud / local web). */
export function getLiveTillUrl(): string | undefined {
  const value = import.meta.env.VITE_TALLY_FLUTTER_WEB_URL;
  if (typeof value === "string" && value.trim().length > 0) return value.trim();
  return undefined;
}

export function openLiveTill(): void {
  const url = getLiveTillUrl();
  if (url) {
    window.location.assign(url);
    return;
  }
  window.alert(
    "Live till URL is not configured yet. Set VITE_TALLY_FLUTTER_WEB_URL to your Serverpod Cloud Flutter web URL (see tally/DEPLOY.md).",
  );
}
