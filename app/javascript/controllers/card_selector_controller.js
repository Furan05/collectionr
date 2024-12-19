import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "input", "preview", "search", "grid"]

  connect() {
    // Ajouter gestionnaire pour fermer avec Escape
    this.handleKeyDown = this.handleKeyDown.bind(this)
    document.addEventListener('keydown', this.handleKeyDown)
  }

  disconnect() {
    document.removeEventListener('keydown', this.handleKeyDown)
  }

  handleKeyDown(e) {
    if (e.key === 'Escape') this.closeModal()
  }

  openModal() {
    this.modalTarget.classList.add('active')
    document.body.style.overflow = 'hidden'
  }

  closeModal() {
    this.modalTarget.classList.remove('active')
    document.body.style.overflow = ''
  }

  selectCard(e) {
    const card = e.currentTarget
    const cardId = card.dataset.cardId
    const cardName = card.dataset.cardName
    const cardImage = card.dataset.cardImage
    const cardSet = card.dataset.cardSet

    this.inputTarget.value = cardId
    this.previewTarget.innerHTML = `
      <div class="card-preview">
        <img src="${cardImage}" alt="${cardName}">
        <div class="card-info">
          <h4>${cardName}</h4>
          <p>${cardSet}</p>
        </div>
      </div>
    `
    this.previewTarget.classList.add('has-card')
    this.closeModal()
  }

  filterCards(e) {
    const searchTerm = e.target.value.toLowerCase()
    const cards = this.gridTarget.children

    Array.from(cards).forEach(card => {
      const name = card.dataset.cardName.toLowerCase()
      const set = card.dataset.cardSet.toLowerCase()
      const matches = name.includes(searchTerm) || set.includes(searchTerm)
      card.style.display = matches ? '' : 'none'
    })
  }
}
