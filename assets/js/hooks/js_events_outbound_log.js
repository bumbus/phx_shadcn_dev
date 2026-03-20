/**
 * JsEventsOutboundLog — listens to outbound CustomEvents on child
 * components and appends entries to a log div. Pure client-side JS.
 *
 * Mount on a wrapper div containing the components and a log target:
 *   <div id="..." phx-hook="JsEventsOutboundLog"
 *        data-sources="toggle-id,collapsible-id"
 *        data-log-target="log-div-id">
 */
const JsEventsOutboundLog = {
  mounted() {
    const sourceIds = (this.el.dataset.sources || "").split(",").filter(Boolean);
    const logId = this.el.dataset.logTarget;

    this._logEl = document.getElementById(logId);
    this._cleanups = [];

    sourceIds.forEach(id => {
      const el = document.getElementById(id);
      if (!el) return;

      const events = [
        "phx-shadcn:pressed", "phx-shadcn:unpressed",
        "phx-shadcn:opened", "phx-shadcn:closed",
        "phx-shadcn:selected", "phx-shadcn:deselected"
      ];

      events.forEach(eventName => {
        const handler = (e) => this._appendLog(id, eventName, e.detail);
        el.addEventListener(eventName, handler);
        this._cleanups.push(() => el.removeEventListener(eventName, handler));
      });
    });
  },

  destroyed() {
    this._cleanups.forEach(fn => fn());
  },

  _appendLog(sourceId, eventName, detail) {
    if (!this._logEl) return;

    const time = new Date().toLocaleTimeString("en-US", { hour12: false });
    const shortEvent = eventName.replace("phx-shadcn:", "");
    const detailStr = detail ? JSON.stringify(detail) : "";

    const entry = document.createElement("div");
    entry.className = "flex gap-2 text-xs font-mono py-0.5 border-b border-border/50 last:border-0";
    entry.innerHTML =
      `<span class="text-muted-foreground shrink-0">${time}</span>` +
      `<span class="text-primary font-semibold">${shortEvent}</span>` +
      `<span class="text-muted-foreground truncate">${sourceId} ${detailStr}</span>`;

    this._logEl.appendChild(entry);
    this._logEl.scrollTop = this._logEl.scrollHeight;
  }
};

export { JsEventsOutboundLog };
