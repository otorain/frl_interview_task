import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {

  connect() {
    this.show()
  }

  hide() {
    this.element.classList.add("hidden")
  }

  show() {
    this.element.classList.remove("hidden")
  }
}
