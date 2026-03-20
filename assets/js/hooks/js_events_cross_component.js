/**
 * JsEventsCrossComponent — wires a Toggle and a Collapsible together
 * via outbound→inbound CustomEvents. Pure client-side, no server.
 *
 * Mount on a wrapper div containing both components:
 *   <div id="..." phx-hook="JsEventsCrossComponent"
 *        data-toggle-id="my-toggle" data-collapsible-id="my-collapsible">
 */
const JsEventsCrossComponent = {
  mounted() {
    const toggleId = this.el.dataset.toggleId;
    const collapsibleId = this.el.dataset.collapsibleId;

    this._toggle = document.getElementById(toggleId);
    this._collapsible = document.getElementById(collapsibleId);

    if (!this._toggle || !this._collapsible) return;

    // Toggle pressed → open Collapsible; unpressed → close Collapsible
    this._onPressed = () => {
      this._collapsible.dispatchEvent(
        new CustomEvent("phx-shadcn:open", { detail: { value: "_" } })
      );
    };
    this._onUnpressed = () => {
      this._collapsible.dispatchEvent(
        new CustomEvent("phx-shadcn:close", { detail: { value: "_" } })
      );
    };

    // Collapsible opened → press Toggle; closed → unpress Toggle
    this._onOpened = () => {
      this._toggle.dispatchEvent(new CustomEvent("phx-shadcn:press"));
    };
    this._onClosed = () => {
      this._toggle.dispatchEvent(new CustomEvent("phx-shadcn:unpress"));
    };

    this._toggle.addEventListener("phx-shadcn:pressed", this._onPressed);
    this._toggle.addEventListener("phx-shadcn:unpressed", this._onUnpressed);
    this._collapsible.addEventListener("phx-shadcn:opened", this._onOpened);
    this._collapsible.addEventListener("phx-shadcn:closed", this._onClosed);
  },

  destroyed() {
    if (this._toggle) {
      this._toggle.removeEventListener("phx-shadcn:pressed", this._onPressed);
      this._toggle.removeEventListener("phx-shadcn:unpressed", this._onUnpressed);
    }
    if (this._collapsible) {
      this._collapsible.removeEventListener("phx-shadcn:opened", this._onOpened);
      this._collapsible.removeEventListener("phx-shadcn:closed", this._onClosed);
    }
  }
};

export { JsEventsCrossComponent };
