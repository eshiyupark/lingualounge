import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session-language"
export default class extends Controller {
  connect() {
    console.log('controller is connected :D:D')
  }
}
