// Audio Selector version 1.0
// // Define an array of file names
// const audioFiles = ["assets/umi-says.mp3", "assests/wtd.mp3"];

// window.addEventListener("load", selectRandomAudio);

// // Function to select and set the src attribute of the embed element
// function selectRandomAudio() {
//   const randomIndex = Math.floor(Math.random() * audioFiles.length);
//   const selectedAudio = audioFiles[randomIndex];

//   // Set the src attribute of the embed element
//   const audioEmbed = document.getElementById("bgMusic");
//   audioEmbed.setAttribute("src", selectedAudio);
// }

// Define an array of file names
const audioFiles = ["assets/umi-says.mp3", "assets/wtd.mp3"];

// Array to keep track of the last two played audio files
const lastPlayedAudio = [];

window.addEventListener("load", initializeAudio);

function initializeAudio() {
  // Get the audio element
  const audioElement = document.getElementById("bgMusic");

  // Add an event listener for the "ended" event
  audioElement.addEventListener("ended", function () {
    selectRandomAudio(audioElement);
  });

  // Initial selection of random audio
  selectRandomAudio(audioElement);
}

// Function to select and set the src attribute of the audio element
function selectRandomAudio(audioElement) {
  // Create an array of audio files that haven't been played recently
  const availableAudioFiles = audioFiles.filter(
    (file) => !lastPlayedAudio.includes(file)
  );

  // If there are no available files, reset the list of lastPlayedAudio
  if (availableAudioFiles.length === 0) {
    lastPlayedAudio.length = 0;
  }

  const randomIndex = Math.floor(Math.random() * availableAudioFiles.length);
  const selectedAudio = availableAudioFiles[randomIndex];

  // Add the selected audio to the list of lastPlayedAudio
  lastPlayedAudio.push(selectedAudio);

  // Keep only the last two played audio files in the list
  if (lastPlayedAudio.length > 2) {
    lastPlayedAudio.shift();
  }

  // Set the src attribute of the audio element
  audioElement.src = selectedAudio;

  // Load and play the new audio
  audioElement.load();
  audioElement.play();
}

// Function to Hide or Show Audio Controls

// Function to set the volume based on the slider input

function setVolume() {
  const volumeSlider = document.getElementById("volumeSlider");
  audioEmbed.volume = parseFloat(volumeSlider.value);
}