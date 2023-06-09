import TwilioVideoController from 'stimulus-twilio-video'

// Connects to data-controller="video-call"
export default class extends TwilioVideoController {
  static targets = ['noCall', 'awaitingBuddy','connectedBuddy','joinCallButton', 'endCallButton']
  connect(){
    console.log("controller connected")

  }

  callStarted() {
    console.log('Call started!')
    this.awaitingBuddyTarget.classList.remove('d-none')
    this.joinCallButtonTarget.classList.add('d-none')
    this.endCallButtonTarget.classList.remove('d-none')
  }

  callEnded() {
    console.log('Call ended!')
    this.noCallTarget.classList.remove('d-none')
    this.awaitingBuddyTarget.classList.add('d-none')
    this.joinCallButtonTarget.classList.remove('d-none')
    this.endCallButtonTarget.classList.add('d-none')
    this.connectedBuddyTarget.classList.add('d-none')
  }

  buddyJoined() {
    console.log('Buddy has joined the call')
    this.awaitingBuddyTarget.classList.add('d-none')
    this.connectedBuddyTarget.classList.remove('d-none')
    this.noCallTarget.classList.add('d-none')
  }

  buddyLeft() {
    console.log('Buddy has left the call')
    this.noCallTarget.classList.remove('d-none')
  }
}
