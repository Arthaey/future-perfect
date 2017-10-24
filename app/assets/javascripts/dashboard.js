function togglePomodoro(e) {
  var pomodoro = this;
  var wasStopped = pomodoro.classList.contains("stopped");
  var wasStarted = pomodoro.classList.contains("started");

  // unstarted -> started -> stopped -> ...
  if (wasStopped) {
    pomodoro.classList.replace("stopped", "unstarted");
  }
  else if (wasStarted) {
    pomodoro.classList.replace("started", "stopped");
  }
  else {
    pomodoro.classList.replace("unstarted", "started");
  }
}

function init() {
  var pomodoros = document.querySelectorAll(".pomodoro:not(.stopped)");
  pomodoros.forEach(function(pomodoro) {
    pomodoro.addEventListener("click", togglePomodoro);
  });
}

document.addEventListener("DOMContentLoaded", init);
