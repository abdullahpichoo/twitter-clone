import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tweet-form"
export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:submit-end", () => {
      this.element.reset();

      document.getElementById("smallScreenModalCloseBtn").click();

      document.getElementById("regularScreenModalCloseBtn").click();

      document.getElementById("profileModalCloseBtn").click();
    });
  }
}
