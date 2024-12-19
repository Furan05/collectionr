// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabContent"]

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget
    const tcg = tab.dataset.tab

    // Mise à jour du champ caché TCG dans le formulaire de recherche
    const tcgInput = document.querySelector('input[name="tcg"]')
    if (tcgInput) {
      tcgInput.value = tcg
    }

    // Update active state of tabs
    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('active'))
    tab.classList.add('active')

    // Update the URL
    const url = new URL(window.location)
    url.searchParams.set('tcg', tcg)
    window.history.pushState({}, '', url)

    // Make the fetch request with both tcg and query parameters
    const query = document.querySelector('input[name="query"]').value
    fetch(`${window.location.pathname}?tcg=${tcg}&query=${query}`, {
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
