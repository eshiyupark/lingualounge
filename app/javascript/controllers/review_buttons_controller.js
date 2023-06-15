import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-buttons"
export default class extends Controller {

  connect(){
    console.log("connected to review buttons controller")
  }
  changeTextRate(event) {
    event.preventDefault();
    // console.log("works");
    const button = event.currentTarget;
    button.textContent = "Rating submitted";
    button.classList.add("btn-light-orange");
  }
  changeTextRequest(event) {
    // event.preventDefault();
    const button2 = event.target;
    console.log(button2);
    button2.value = "Request Sent";
    button2.classList.add("btn-light-orange");
  }
}
