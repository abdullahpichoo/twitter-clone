import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tweet-card"
export default class extends Controller {
  connect() {
    this.element.addEventListener("click", (e) => {
      if (
        [
          e.target.parentElement.dataset.allowUserProfileVisit,
          e.target.parentElement.parentElement.dataset.allowUserProfileVisit,
        ].includes("true")
      ) {
        Turbo.visit(this.element.dataset.userPath);
      } else if (
        ![
          e.target.parentElement.parentElement.dataset.ignoreClick,
          e.target.parentElement.dataset.ignoreClick,
        ].includes("true")
      ) {
        Turbo.visit(this.element.dataset.tweetPath);
      }
    });
  }
}
