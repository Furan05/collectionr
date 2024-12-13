import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('submit', () => {
      this.element.querySelector('button').disabled = true
    })
  }
}
