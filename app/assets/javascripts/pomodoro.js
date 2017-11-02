function progressPomodoroState(pomodoro) {
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

function dragPomodoro(ev) {
  ev.dataTransfer.dropEffect = "move";
  ev.dataTransfer.setData("text/plain", ev.target.id);
}

function dropPomodoro(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("text");
  var pomodoro = document.getElementById(data);
  ev.target.classList.remove("drag-hover");
  ev.target.appendChild(pomodoro);
  progressPomodoroState(pomodoro);
}

function highlightDragDropZone(ev) {
  ev.preventDefault();
  ev.dataTransfer.dropEffect = "move";
  ev.target.classList.add("drag-hover");
}

function unhighlightDragDropZone(ev) {
  ev.preventDefault();
  ev.target.classList.remove("drag-hover");
}

function initPomodoros() {
  document.querySelectorAll(".pomodoro").forEach(function(pomodoro) {
    addId(pomodoro);
    pomodoro.addEventListener("dragstart", dragPomodoro);
  });

  document.querySelectorAll(".drag-drop-zone").forEach(function(zone) {
    zone.addEventListener("drop", dropPomodoro);
    zone.addEventListener("dragover", highlightDragDropZone);
    zone.addEventListener("dragexit", unhighlightDragDropZone);
    zone.addEventListener("dragleave", unhighlightDragDropZone);
  });

}
