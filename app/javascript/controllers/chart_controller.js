import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { priceHistory: Array }

  connect() {
    if (typeof ApexCharts === 'undefined') {
      console.error('ApexCharts is not loaded')
      return
    }

    const priceData = this.priceHistoryValue

    if (priceData && priceData.length > 0) {
      const options = {
        series: [{
          name: 'Prix',
          data: priceData.map(item => ({
            x: new Date(item.date).getTime(),
            y: item.price
          }))
        }],
        chart: {
          type: 'area',
          height: 250,
          toolbar: {
            show: false
          },
          animations: {
            enabled: true,
            easing: 'easeinout',
            speed: 800
          }
        },
        colors: ['#f8c471'],
        fill: {
          type: 'gradient',
          gradient: {
            shadeIntensity: 1,
            opacityFrom: 0.7,
            opacityTo: 0.2,
            stops: [0, 100]
          }
        },
        dataLabels: {
          enabled: false
        },
        stroke: {
          curve: 'smooth',
          width: 2
        },
        grid: {
          borderColor: '#e0e0e0',
          strokeDashArray: 5,
          xaxis: {
            lines: {
              show: false
            }
          }
        },
        xaxis: {
          type: 'datetime',
          labels: {
            style: {
              colors: '#666',
              fontSize: '12px'
            }
          }
        },
        yaxis: {
          labels: {
            formatter: function(val) {
              return val.toFixed(2) + "€"
            },
            style: {
              colors: '#666',
              fontSize: '12px'
            }
          }
        },
        tooltip: {
          x: {
            format: 'dd MMM yyyy'
          },
          y: {
            formatter: function(val) {
              return val.toFixed(2) + "€"
            }
          }
        }
      }

      const chart = new ApexCharts(this.element, options)
      chart.render()
    } else {
      this.element.insertAdjacentHTML('afterend', '<p>Aucune donnée de prix disponible</p>')
    }
  }
}
