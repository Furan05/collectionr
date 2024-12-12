# Pin npm packages by running ./bin/importmap

# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@popperjs/core", to: "popper.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"
pin "card-collection"
