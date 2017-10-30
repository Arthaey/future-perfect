// https://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

function addId(element) {
  if (element.id) {
    console.warn("Element already has an ID: " + element);
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
  var item = ev.target.closest(".item");
  var description = item.querySelector("[contenteditable]");
  description.contentEditable = false;
}

function initSaveHandlers(root) {
  root.querySelectorAll("[aria-label='save']").forEach(function(save) {
    save.addEventListener("click", saveItem);
  });
}

var g_categorySelectorWidth = 150;
var g_categorySelector;
var g_categories = [
  { name: "Marriage",   abbrev: "Ma",   color: "#f44336" },
  { name: "Career",     abbrev: "Ca",   color: "#ff9800" },
  { name: "Health",     abbrev: "He",   color: "#ffeb3b" },
  { name: "Adulting",   abbrev: "Adlt", color: "#afb42b" },
  { name: "Money",      abbrev: "Mo",   color: "#2e7d32" },
  { name: "Relaxing",   abbrev: "Re",   color: "#03a9f4" },
  { name: "Language",   abbrev: "La",   color: "#1565c0" },
  { name: "Creativity", abbrev: "Cr",   color: "#673ab7" },
  { name: "Friends",    abbrev: "Fr",   color: "#795548" },
  { name: "Adventure",  abbrev: "Adv",  color: "#212121" },
];

function initCategorySelector() {
  var names   = g_categories.map(function(cat) { return cat.name });
  var abbrevs = g_categories.map(function(cat) { return cat.abbrev });
  var colors  = g_categories.map(function(cat) { return cat.color });

  g_categorySelector = new wheelnav(
      "divWheelnav",
      null,
      g_categorySelectorWidth,
      g_categorySelectorWidth
  );

  g_categorySelector.slicePathFunction = slicePath().DonutSlice;
  g_categorySelector.clickModeRotate = false;
  g_categorySelector.navAngle = -90;
  g_categorySelector.clockwise = false;
  g_categorySelector.colors = colors;
  g_categorySelector.titleFont = "bold 16px sans-serif";
  g_categorySelector.setTooltips(names);
  g_categorySelector.initWheel(abbrevs);

  g_categorySelector.navItems.forEach(function(navItem) {
    navItem.navigateFunction = function() { setCategory(navItem) };
  });

  var titleAttr = g_categorySelector.navItems[9].titleAttr;
  titleAttr["fill"] = "#aaa";
  g_categorySelector.navItems[9].titleAttr = titleAttr;

  g_categorySelector.createWheel();
}

function setCategory(navItem) {
  var cat = g_categories[navItem.wheelItemIndex];
  var menu = document.getElementById("divWheelnav");
  var item = document.getElementById(menu.dataset.itemId);
  var icon = item.querySelector("[class*='cat-']");

  var classes = icon.classList;
  classes.forEach(function(className) {
    if (className.startsWith("cat-")) {
      icon.classList.remove(className);
    }
  });
  icon.classList.add("cat-" + cat.name);

  menu.classList.add("hidden");
}

function showCategorySelector(ev) {
  var icon = ev.target;
  var item = icon.closest(".item");
  var menu = document.getElementById("divWheelnav");

  var halfMenuWidth = g_categorySelectorWidth / 2;
  var magicOffset = 7; // :(
  var left = item.offsetLeft - halfMenuWidth + magicOffset;
  var top = item.offsetTop - halfMenuWidth + magicOffset;

  menu.dataset.itemId = item.id;
  menu.style.left = left + "px";
  menu.style.top = top + "px";
  menu.classList.remove("hidden");
  g_categorySelector.refreshWheel();
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
  initCategorySelector();

  var catIcons = document.querySelectorAll(".item [class*='cat-']");
  catIcons.forEach(function(catIcon) {
    addId(catIcon.closest(".item"));
    catIcon.addEventListener("click", showCategorySelector);
  });

  document.querySelectorAll("[data-lines]").forEach(function(element) {
    element.style.height = (element.dataset.lines * 2) + "rem";
  });
}

document.addEventListener("DOMContentLoaded", init);
