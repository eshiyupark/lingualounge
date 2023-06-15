import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friendship-button"
export default class extends Controller {
  connect() {
    console.log('friendship-button controller connected :D:D')
  }
}
// joinCall() {
//   this.containerTarget.classList.remove('d-flex')
//   this.containerTarget.classList.add('hidden')
//   this.containerTwoTarget.classList.add('hidden')
//   this.headerTarget.classList.add('hidden')
//   this.joinCallButtonTarget.classList.add('hidden')
//   this.endCallButtonTarget.classList.add('hidden')
//   this.finishButtonTarget.classList.remove('d-none')
//   this.videoContainerTarget.classList.remove('d-none')
// }
