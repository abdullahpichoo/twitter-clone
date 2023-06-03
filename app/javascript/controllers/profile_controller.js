import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile"
export default class extends Controller {
  connect() {}
  showFollowers() {
    fetch("/users/followings")
      .then((response) => response.json())
      .then((data) => {
        // Process the returned data and update the UI
        console.log(data);
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}
