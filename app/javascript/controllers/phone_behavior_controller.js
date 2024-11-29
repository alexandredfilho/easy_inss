import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["phoneType", "referenceField"]

  connect() {
    this.toggleReferenceField()
  }

  toggleReferenceField() {
    if (this.phoneTypeTarget.value === "reference") {
      this.referenceFieldTarget.style.display = "block"
    } else {
      this.referenceFieldTarget.style.display = "none"
    }
  }

  handleChange() {
    this.toggleReferenceField()
  }
}
