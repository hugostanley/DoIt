import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];
  initialize(){
    this.clickCount = 0
  }

  greet() {
    console.log(this.clickCount)
    const classes = this.iconTarget.classList.value;

    if (classes.includes("habanimate")) {
      this.iconTarget.classList.remove("habanimate");
      this.iconTarget.classList.add("removeanimate");
    } else {
      this.iconTarget.classList.add("habanimate");
      this.iconTarget.classList.remove("removeanimate");
    }
    this.clickCount++
  }

  // ON HOVER METHODS
  //hover() {
  //  console.log(navigator.userAgent)
  //  this.iconTarget.classList.remove("removeanimate");
  //  this.iconTarget.classList.add("habanimate");
  //}

  //unhover() {
  //  console.log("heee");
  //  this.iconTarget.classList.remove("habanimate");
  //  this.iconTarget.classList.add("removeanimate");
  //}
}
