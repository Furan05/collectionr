// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
document.addEventListener("turbo:load", () => {
  // Re-initialize any JavaScript components
})
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "chart.js"
import "vanilla-tilt"

// Custom components
import "card-collection"
import "index"

window.VanillaTilt = VanillaTilt
