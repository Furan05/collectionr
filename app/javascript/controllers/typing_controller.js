import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { words: Array }

  connect() {
    this.wordIndex = 0
    this.charIndex = 0
    this.isDeleting = false
    this.type()
  }

  type() {
    const currentWord = this.wordsValue[this.wordIndex]
    const timeoutSpeed = this.isDeleting ? 100 : 200

    if (this.isDeleting) {
      this.element.textContent = currentWord.substring(0, this.charIndex - 1)
      this.charIndex--
    } else {
      this.element.textContent = currentWord.substring(0, this.charIndex + 1)
      this.charIndex++
    }

    if (!this.isDeleting && this.charIndex === currentWord.length) {
      this.isDeleting = true
      setTimeout(() => this.type(), 1000)
    } else if (this.isDeleting && this.charIndex === 0) {
      this.isDeleting = false
      this.wordIndex = (this.wordIndex + 1) % this.wordsValue.length
      setTimeout(() => this.type(), 500)
    } else {
      setTimeout(() => this.type(), timeoutSpeed)
    }
  }
}
