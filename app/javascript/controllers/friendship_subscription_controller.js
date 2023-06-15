import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { friendshipId: Number,currentUserId: Number }
  static targets = ["messages", "form"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "FriendshipChannel", id: this.friendshipIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribe to the friendship with the id  ${this.friendshipIdValue}.`)
    this.messagesTarget.scrollTo({left: 0, top: this.messagesTarget.scrollHeight, behavior: "smooth"})

  }

  resetForm() {
    this.formTarget.reset()
  }
  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    console.log(this.messagesTarget.scrollHeight)
    this.messagesTarget.scrollTo({left: 0, top: this.messagesTarget.scrollHeight, behavior: "smooth"})
  }
  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }
  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
}
