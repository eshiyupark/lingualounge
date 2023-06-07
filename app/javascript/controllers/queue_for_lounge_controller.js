import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="queue-for-lounge"
export default class extends Controller {
  static values = {
    sessionsIds: Array
  }

  connect() {
    setTimeout(() => {
      fetch(`url_for_the_route?sessions_ids=${this.sessionsIdsValue}`, {
        headers: { "Accept": "text/plain" }
      })
        .then(response => response.json())
        .then((data) => {
          console.log(data)
          // build out the updating of the page
        })
    }, 6_000);
  }
}
