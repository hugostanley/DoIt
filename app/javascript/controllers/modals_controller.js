import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {
  }

  close(e){
    console.log('here')
    e.preventDefault()

    const modal = document.getElementById("modal")
    console.log(modal)

    modal.innerHTML=""

    modal.removeAttribute("src")
    modal.removeAttribute("complete")

  }
}
