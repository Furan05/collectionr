import { Controller } from "@hotwired/stimulus"
import VanillaTilt from 'vanilla-tilt'

export default class extends Controller {
  connect() {
    this.initTilt()
  }

  initTilt() {
    VanillaTilt.init(this.element, {
      max: 80,
      speed: 800,
      glare: true,
      "max-glare": 0.8
    })
  }
}
