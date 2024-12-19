// app/javascript/controllers/multi_step_form_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "prevButton", "nextButton", "submitButton"]

  connect() {
    this.currentStep = 1
    this.totalSteps = this.stepTargets.length
    this.updateButtons()
  }

  next() {
    if (this.currentStep < this.totalSteps) {
      this.stepTargets[this.currentStep - 1].classList.remove('active')
      this.stepTargets[this.currentStep].classList.add('active')
      this.currentStep++
      this.updateButtons()
      this.updateStepIndicators()
    }
  }

  prev() {
    if (this.currentStep > 1) {
      this.stepTargets[this.currentStep - 1].classList.remove('active')
      this.stepTargets[this.currentStep - 2].classList.add('active')
      this.currentStep--
      this.updateButtons()
      this.updateStepIndicators()
    }
  }

  updateButtons() {
    if (this.currentStep === 1) {
      this.prevButtonTarget.style.display = 'none'
    } else {
      this.prevButtonTarget.style.display = 'block'
    }

    if (this.currentStep === this.totalSteps) {
      this.nextButtonTarget.style.display = 'none'
      this.submitButtonTarget.style.display = 'block'
    } else {
      this.nextButtonTarget.style.display = 'block'
      this.submitButtonTarget.style.display = 'none'
    }
  }

  updateStepIndicators() {
    document.querySelectorAll('.step').forEach((step, index) => {
      if (index + 1 === this.currentStep) {
        step.classList.add('active')
      } else {
        step.classList.remove('active')
      }
    })
  }
}
