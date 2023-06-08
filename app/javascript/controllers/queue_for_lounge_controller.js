import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="queue-for-lounge"
export default class extends Controller {
  static values = {
    sessionsIds: Array
  }

  connect() {

    setInterval(() => {
      fetch(`/sessions/queue?sessions_ids=${JSON.stringify(this.sessionsIdsValue)}`, {
        headers: { "Accept": "text/plain" }
      })
        .then(response => response.text())
        .then((data) => {
          console.log(data)
          if (data) {
            window.location.assign(`/sessions/${data}`)
          }
        })
    }, 6_000);
  }
}
