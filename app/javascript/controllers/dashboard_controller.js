import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
    // const mediaQuerySmallScreen = window.matchMedia("(max-width: 992px)");
    // const mediaQueryRegularScreen = window.matchMedia("(min-width: 992px)");
    // mediaQuerySmallScreen.addEventListener("change", () => {
    //   if (mediaQuerySmallScreen.matches) {
    //     console.log();
    //     const tweetsColumn = document.getElementById("tweetsColumn");
    //     tweetsColumn.classList.add("col-md-8");
    //   }
    // });
    // mediaQueryRegularScreen.addEventListener("change", () => {
    //   if (mediaQueryRegularScreen.matches) {
    //     console.log();
    //     const tweetsColumn = document.getElementById("tweetsColumn");
    //     tweetsColumn.classList.remove("col-md-8");
    //   }
    // });
  }
  addMargin(mediaQuery) {
    if (mediaQuery.matches) {
    }
  }
}
