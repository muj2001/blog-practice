import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character-counter"
export default class extends Controller {
  static targets =  ["input", "counter"]

  connect() {
    this.updateCounter();
  }

  updateCounter() {
    const length = this.inputTarget.value.length;
    this.counterTarget.textContent = `${length}` / `${11500}`;
  }

  onInput() {
    this.updateCounter();
  }
}
