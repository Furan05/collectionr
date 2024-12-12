import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]
  static values = {
    collectionId: String
  }

  add(event) {
    event.preventDefault()
    const cardId = event.currentTarget.dataset.cardId

    fetch(`/collections/${this.collectionIdValue}/collection_types`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'text/vnd.turbo-stream.html',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({
        card_id: cardId
      })
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
    })
  }
}
