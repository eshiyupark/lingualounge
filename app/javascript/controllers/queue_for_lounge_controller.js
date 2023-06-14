import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="queue-for-lounge"
export default class extends Controller {
  static values = {
    sessionsIds: Array
  }

  connect() {

    this.intervalId = setInterval(() => {
      fetch(`/sessions/queue?sessions_ids=${JSON.stringify(this.sessionsIdsValue)}`, {
        headers: { "Accept": "text/plain" }
      })
        .then(response => response.text())
        .then((data) => {
          if (data) {
            console.log(data)
            fetch(`/sessions/destroy_sessions?ids=${data.split("%")[1].split("-")}`, {
              headers: {'content-type': 'application/json', 'accept': 'application/json', "X-CSRF-Token": document.querySelector("[name='csrf-token']").getAttribute("content"),},
              method: "delete",
            })
            window.location.assign(`/sessions/${data.split("%")[0]}`)
          }
        })
    }, 6_000);
  }

  disconnect () {
    clearInterval(this.intervalId);
  }
}
