import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab"]

  connect() {
    const activeTab = this.element.querySelector('.active')
    if (activeTab) {
      this.updateCards(activeTab.dataset.tab)
    }
  }

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget

    // Remove active class from all tabs
    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('active'))

    // Add active class to clicked tab
    tab.classList.add('active')

    this.updateCards(tab.dataset.tab)
  }

  updateCards(tcg) {
    const url = new URL(window.location)
    url.searchParams.set('tcg', tcg)

    // Use Turbo to update the cards list
    Turbo.visit(url.toString(), { frame: "cards_list" })
  }
}
