// https://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

function addId(element) {
  if (element.id) {
    console.error("Element already has an ID: " + element);
    return;
  }

  element.id = uuidv4();
}

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

function addItem(ev) {
  var addIcon = ev.target;
  var elementWithAddToId = addIcon.closest("[data-add-to]");
  var addTo = document.getElementById(elementWithAddToId.dataset.addTo);
  var addedElement = addTo.querySelector(".hidden");

  var nextToAdd = addedElement.cloneNode(true);
  addedElement.parentNode.appendChild(nextToAdd);
  initSaveHandlers(nextToAdd);

  addedElement.classList.remove("hidden");
}

function saveItem(ev) {
  var item = ev.target.closest(".event");
  var description = item.querySelector("[contenteditable]");
  description.contentEditable = false;
}

function initSaveHandlers(root) {
  root.querySelectorAll("[aria-label='save']").forEach(function(save) {
    save.addEventListener("click", saveItem);
  });
}

function init() {
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

  var adds = document.querySelectorAll(".interactive-icon[aria-label='add']");
  adds.forEach(function(add) {
    add.addEventListener("click", addItem);
  });

  initSaveHandlers(document);
}

document.addEventListener("DOMContentLoaded", init);
