import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  prev() {
    this.element.querySelector('.slider-container').scrollBy({
      left: -320,
      behavior: 'smooth'
    })
  }

  next() {
    this.element.querySelector('.slider-container').scrollBy({
      left: 320,
      behavior: 'smooth'
    })
  }
}
