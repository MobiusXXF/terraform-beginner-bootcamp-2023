// Define an array of audio file names
const audioFiles = ["assets/enyk.mp3", "assets/the-light.mp3", "assets/findaway.mp3", "assets/grease.mp3", "assets/left-right.mp3", "assets/stressed-out.mp3", "assets/tellme.mp3", "assets/tlol.mp3", "assets/umi-says.mp3", "assets/wtd.mp3", "assets/elec-relax.mp3"];

window.addEventListener("load", selectRandomAudio);

// Function to select and set the src attribute of the embed element
function selectRandomAudio() {
  const randomIndex = Math.floor(Math.random() * audioFiles.length);
  const selectedAudio = audioFiles[randomIndex];

  // Set the src attribute of the embed element
  const audioEmbed = document.getElementById("bgMusic");
  audioEmbed.setAttribute("src", selectedAudio);
}

// Function to set the volume based on the slider input
// Need to fix this!
function setVolume() {
  const volumeSlider = document.getElementById("volumeSlider");
  audioEmbed.volume = parseFloat(volumeSlider.value);
}