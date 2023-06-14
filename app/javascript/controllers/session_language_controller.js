import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session-language"
export default class extends Controller {
  static targets = ["button", "checkboxes"]
  connect() {
    console.log('updated')
  }

  disable() {
    this.checkboxesTargets.forEach((checkbox) => {
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
    return this.checkboxesTargets.some((checkbox) => checkbox.checked);
  }
}

