// app/javascript/controllers/chart_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    priceHistory: Array
  }

  connect() {
    console.log("Chart controller connected")
    this.initChart()
  }

  initChart() {
    const ctx = this.element.getContext('2d')

    new Chart(ctx, {
      type: 'line',
      data: {
        labels: this.priceHistoryValue.map(item => item.date),
        datasets: [{
          label: 'Prix de la carte (€)',
          data: this.priceHistoryValue.map(item => item.price),
          borderColor: '#f8c471',
          backgroundColor: 'rgba(253, 218, 161, 0.1)',
          borderWidth: 2,
          tension: 0.4,
          fill: true,
          pointRadius: 0,
          pointHoverRadius: 6,
          pointHoverBackgroundColor: '#f8c471',
          pointHoverBorderColor: '#fff',
          pointHoverBorderWidth: 2
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: {
              display: false
            },
            ticks: {
              font: {
                size: 12
              }
            }
          },
          x: {
            grid: {
              display: false
            },
            ticks: {
              font: {
                size: 12
              },
              maxTicksLimit: 6,
              maxRotation: 0
            }
          }
        },
        interaction: {
          intersect: false,
          mode: 'index'
        }
      }
    })
  }
}
