import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="select-place"
export default class extends Controller {
  static values = { url: String, isStepFormExist: Boolean }
  static targets = ["floor", "cabinet", "step"]

  connect() {
  }

  change(event, idName) {
    const targetId = event.target.value
    if (!targetId) return

    let url = `${this.urlValue}?${idName}=${targetId}`
    if(idName!="floor_id") {
      url += `&floor_id=${this.floorTarget.value}`
    }
    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
      .then(response => response.text())
      .then(html => {
        Turbo.renderStreamMessage(html)
      })
  }

  changeFloor(event) {
    this.change(event, "floor_id")
  }

  changeCabinet(event) {
    this.change(event, "cabinet_id")
  }

  checkParams(event) {
    if(this.floorTarget.value.length===0 || 
       this.cabinetTarget.value.length===0 || 
       (this.isStepFormExistValue && this.stepTarget.value.length===0) ) {
      alert("選択してください")
      event.preventDefault()
      return
    }
  }
}
