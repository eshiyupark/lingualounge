import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
// Connects to data-controller="last-message"
export default class extends Controller {
  static values = { friendshipId: Number }
  connect() {
    // console.log(this.element)
    // console.log(this.itemsTarget)
    this.channel = createConsumer().subscriptions.create(
      { channel: "LastmessageChannel", id: this.friendshipIdValue},
      { received: (data) => {
        console.log(data)
        this.#insertMessage(data)
      }}
    )

    console.log("The last-message controller is connected")
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
  #insertMessage(data){
    this.element.outerHTML = data.message
  }
}
