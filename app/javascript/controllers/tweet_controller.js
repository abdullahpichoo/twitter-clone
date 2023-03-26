import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tweet"
export default class extends Controller {
  connect() {
    console.log("This is called from a tweet");

    this.element.addEventListener("click", (e) => {
      e.preventDefault();

      // if (
      //   ![
      //     e.target.parentElement.parentElement.dataset.ignoreClick,
      //     e.target.parentElement.dataset.ignoreClick,
      //   ].includes("true")
      // ) {
      //   Turbo.visit(this.element.dataset.tweetPath);
      // }
    });
  }
}
