import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="spinner"
export default class extends Controller {
  connect() {
    console.log("spinner controller!", this.element);
    document.addEventListener("direct-upload:complete", this.hide.bind(this));
  }
  hide() {
    console.log("picture uploaded!");
    document.getElementById("submit-btn").classList.remove("d-none");
    document.getElementById("spinner").classList.add("d-none");
  }
  show() {
    document.getElementById("submit-btn").classList.add("d-none");
    document.getElementById("spinner").classList.remove("d-none");
    document.getElementById("back-to-twitter").classList.add("d-none");
  }
}
