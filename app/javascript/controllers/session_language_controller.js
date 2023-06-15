import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session-language"
export default class extends Controller {
  static targets = ["button", "checkbox"]
  connect() {
    console.log('checkbox updated')
  }

  disable() {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.addEventListener("change", () => {
        if (this.isChecked()) {
          this.buttonTarget.removeAttribute("disabled");
        } else {
          this.buttonTarget.setAttribute("disabled", "disabled");
        }
      });
    });
  }

  isChecked() {
    return this.checkboxTargets.some((checkbox) => checkbox.checked);
  }
}
