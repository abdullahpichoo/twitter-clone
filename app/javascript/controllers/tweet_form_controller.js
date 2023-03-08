import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tweet-form"
export default class extends Controller {
  connect() {
    this.element.addEventListener("submit", () => {
      console.log("Cdasdasd");
      if (document.getElementById("modal-close-btn")) {
        console.log("mobile modal");
        document.getElementById("modal-close-btn").click();
      } else if (document.getElementById("regularCloseButton")) {
        console.log("desktop modal");
        document.getElementById("modal-close-btn-regular").click();
      }
    });
  }
}
