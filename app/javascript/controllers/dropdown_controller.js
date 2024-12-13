// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    // Ajoutez un écouteur pour les clics en dehors du dropdown
    document.addEventListener("click", this.closeDropdown.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.closeDropdown.bind(this))
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.contentTarget.classList.toggle("show")
  }

  closeDropdown(event) {
    if (!this.element.contains(event.target)) {
      this.contentTarget.classList.remove("show")
    }
  }
}
