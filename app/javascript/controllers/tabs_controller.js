// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabContent"]

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget
    const tcg = tab.dataset.tab

    const tcgInput = document.querySelector('input[name="tcg"]')
    if (tcgInput) {
      tcgInput.value = tcg
    }

    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('active'))
    tab.classList.add('active')

    const url = new URL(window.location)
    url.searchParams.set('tcg', tcg)
    window.history.pushState({}, '', url)


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
