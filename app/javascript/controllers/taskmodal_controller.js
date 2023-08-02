import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  initialize(){
    this.isOpen = false
  }

  connect() {
    console.log('hello')
  }

  openModal() {
    console.log('yo')

  }

}
