import { Application } from 'stimulus'
import TwilioVideoController from 'stimulus-twilio-video'

const application = Application.start()
application.register('video-call', TwilioVideoController)

// Connects to data-controller="video-call"
export default class extends TwilioVideoController {
  static targets = ['header', 'container', 'containerTwo', 'videoContainer', 'mainContainer', 'buddyVideo', 'localVideo', 'joinCallButton', 'endCallButton', 'finishButton']
  connect(){
    console.log("controller connected")
  }

  callStarted() {
    console.log('Call started!')
  }

  callEnded() {
    console.log('Call ended!')
  }

  joinCall() {
    this.containerTarget.classList.remove('d-flex')
    this.containerTarget.classList.add('hidden')
    this.containerTwoTarget.classList.add('hidden')
    this.headerTarget.classList.add('hidden')
    this.joinCallButtonTarget.classList.add('hidden')
    this.endCallButtonTarget.classList.add('hidden')
    this.finishButtonTarget.classList.remove('d-none')
    this.videoContainerTarget.classList.remove('d-none')
  }

  endCall() {
    console.log("This is end call")
  }
}

// import TwilioVideoController from 'stimulus-twilio-video'

// // Connects to data-controller="video-call"
// export default class extends TwilioVideoController {
//   static targets = ['noCall', 'awaitingBuddy','connectedBuddy','joinCallButton', 'endCallButton']
//   connect(){
//     console.log("controller connected")

//   }

//   callStarted() {
//     console.log('Call started!')
//     this.awaitingBuddyTarget.classList.remove('d-none')
//     this.joinCallButtonTarget.classList.add('d-none')
//     this.endCallButtonTarget.classList.remove('d-none')
//   }

//   callEnded() {
//     console.log('Call ended!')
//     this.noCallTarget.classList.remove('d-none')
//     this.awaitingBuddyTarget.classList.add('d-none')
//     this.joinCallButtonTarget.classList.remove('d-none')
//     this.endCallButtonTarget.classList.add('d-none')
//     this.connectedBuddyTarget.classList.add('d-none')
//   }

//   buddyJoined() {
//     console.log('Buddy has joined the call')
//     this.awaitingBuddyTarget.classList.add('d-none')
//     this.connectedBuddyTarget.classList.remove('d-none')
//     this.noCallTarget.classList.add('d-none')
//   }

//   buddyLeft() {
//     console.log('Buddy has left the call')
//     this.noCallTarget.classList.remove('d-none')
//   }

//   joinCall() {
//     this.joinCallButtonTarget.classList.add('d-none')
//   }

//   endCall() {
//     console.log("This is end call")
//   }
// }
