# config/importmap.rb
# Core dependencies first
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"

# Bootstrap dependencies
pin "@popperjs/core", to: "popper.js"
pin "bootstrap", to: "bootstrap.min.js"

# Controllers and application
pin_all_from "app/javascript/controllers", under: "controllers"
pin "controllers", preload: true
pin "application"

# Custom components last
pin "vanilla-tilt"
pin "card-collection"
