// app/javascript/controllers/onglet_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    // Show initial tab based on URL hash or default to activity
    const hash = window.location.hash || '#activity'
    this.showSection(hash.replace('#', ''))
  }

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget
    const section = tab.getAttribute('href').replace('#', '')

    // Update active tab
    this.tabTargets.forEach(t => t.classList.remove("active"))
    tab.classList.add("active")

    // Show corresponding content
    this.showSection(section)

    // Update URL hash without scrolling
    history.replaceState(null, null, `#${section}`)
  }

  showSection(section) {
    const contents = document.querySelectorAll('.tab-content')
    contents.forEach(content => {
      if (content.id === section) {
        content.classList.remove("hidden")
        content.classList.add("fade-in")
      } else {
        content.classList.add("hidden")
        content.classList.remove("fade-in")
      }
    })
  }
}
