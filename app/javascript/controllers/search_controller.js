import { Controller } from "@hotwired/stimulus";
import _debounce from "debounce";
// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    console.log("Commected to Search!", this.element);
  }
  initialize() {
    this.submit = _debounce(this.submit.bind(this), 500);
  }
  submit() {
    this.element.requestSubmit();
  }
}
