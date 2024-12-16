import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = {
    counter: Number
  }

  connect() {
    this.count = 0
    this.startCounting()
  }

  startCounting() {
    const target = this.element.dataset.counterTarget
    const duration = 2000 // 2 secondes pour l'animation
    const step = target / (duration / 16) // 60 FPS

    const counter = setInterval(() => {
      this.count += step
      if (this.count >= target) {
        this.element.textContent = Math.round(target).toLocaleString()
        clearInterval(counter)
      } else {
        this.element.textContent = Math.round(this.count).toLocaleString()
      }
    }, 16)
  }
}
