// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabContent"]

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget
    const tcg = tab.dataset.tab

    // Remove active class from all tabs
    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('active'))

    // Add active class to clicked tab
    tab.classList.add('active')

    // Update the URL without triggering a full page reload
    const url = new URL(window.location)
    url.searchParams.set('tcg', tcg)
    window.history.pushState({}, '', url)

    // Make a fetch request to get the filtered cards
    fetch(`${window.location.pathname}?tcg=${tcg}`, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
    })
  }
}
