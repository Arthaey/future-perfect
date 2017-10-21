function togglePomodoro(e) {
  var pomodoro = this;
  var wasCompleted = pomodoro.classList.contains("completed");
  var wasActive = pomodoro.classList.contains("active");

  // unstarted -> active -> completed -> ...
  if (wasCompleted) {
    pomodoro.classList.replace("completed", "unstarted");
  }
  else if (wasActive) {
    pomodoro.classList.replace("active", "completed");
  }
  else {
    pomodoro.classList.replace("unstarted", "active");
  }
}

function init() {
  var pomodoros = document.querySelectorAll(".pomodoro:not(.completed)");
  pomodoros.forEach(function(pomodoro) {
    pomodoro.addEventListener("click", togglePomodoro);
  });
}

document.addEventListener("DOMContentLoaded", init);
