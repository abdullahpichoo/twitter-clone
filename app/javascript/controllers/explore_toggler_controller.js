import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="explore-toggler"
export default class extends Controller {
  connect() {
    const tweetsBtn = document.getElementById("tweetsBtn");
    const peopleBtn = document.getElementById("peopleBtn");

    const exploreTweets = document.getElementById("explore-tweets");
    const peoplePage = document.getElementById("people");

    tweetsBtn.addEventListener("click", function () {
      tweetsBtn.classList.add("selected");
      peopleBtn.classList.remove("selected");

      exploreTweets.classList.add("active");
      peoplePage.classList.remove("active");
    });

    peopleBtn.addEventListener("click", function () {
      peopleBtn.classList.add("selected");
      tweetsBtn.classList.remove("selected");

      peoplePage.classList.add("active");
      exploreTweets.classList.remove("active");
    });
  }
}
