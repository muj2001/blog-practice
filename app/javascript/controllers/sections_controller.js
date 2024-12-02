import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sections"
export default class extends Controller {
  static targets = ["template", "container"]

  add(event) {
    event.preventDefault();

    const newSection = this.templateTarget.innerHTML;
    this.containerTarget.insertAdjacentHTML("beforeend", newSection);
  }

  remove(event) {
    event.preventDefault;
    event.target.closest(".nested-fields").remove();
  }
}
