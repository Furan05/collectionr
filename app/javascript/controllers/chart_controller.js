import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const priceData = JSON.parse(this.element.dataset.priceHistory)

    if (priceData && priceData.length > 0) {
      new Chart(this.element, {
        type: 'line',
        data: {
          labels: priceData.map(d => d.date),
          datasets: [{
            label: 'Prix de la carte (€)',
            data: priceData.map(d => d.price),
            borderColor: '#f8c471',
            backgroundColor: 'rgba(248, 196, 113, 0.1)',
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
      });
    } else {
      this.element.insertAdjacentHTML('afterend', '<p>Aucune donnée de prix disponible</p>');
    }
  }
}
