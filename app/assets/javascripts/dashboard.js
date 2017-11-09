// https://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

function addIds(selectors) {
  selectors.forEach(function(selector) {
    var elements = document.querySelectorAll(selector);
    elements.forEach(function(element) {
      addId(element);
    });
  });
}

function addId(element) {
  if (element.id) {
    console.warn("Element already has an ID: " + element);
    return;
  }

  element.id = uuidv4();
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

function markAsDone(ev) {
  var item = ev.target.closest(".item");
  var itemContainer = item.closest("li");

  var description = item.querySelector(".description").innerText;
  var allItemsDescriptions = document.querySelectorAll(".item .description");
  allItemsDescriptions.forEach(function(thisDesc) {
    if (description == thisDesc.innerText) {
      thisDesc.closest("li").classList.add("item-done");
    }
  });

  var list = itemContainer.closest("ol");
  if (0 == list.querySelectorAll("li:not(.item-done):not(.hidden)").length) {
    var heading = list.previousElementSibling;
    heading.classList.add("item-done");
  }

  var section = itemContainer.closest(".routines");
  if (0 == section.querySelectorAll("li:not(.item-done):not(.hidden)").length) {
    section.querySelector(".no-items").classList.remove("hidden");
  }
}

function initSaveHandlers(root) {
  root.querySelectorAll("[aria-label='save']").forEach(function(save) {
    save.addEventListener("click", saveItem);
  });
}

function initAddHandlers(root) {
  var adds = root.querySelectorAll(".interactive-icon[aria-label='add']");
  adds.forEach(function(add) {
    add.addEventListener("click", addItem);
  });
}

function initDoneHandlers(root) {
  var icon = root.querySelectorAll(".item-icon");
  icon.forEach(function(icon) {
    icon.addEventListener("click", markAsDone);
  });
}

function resizeItems(root) {
  root.querySelectorAll("[data-lines]").forEach(function(element) {
    element.style.height = (element.dataset.lines * 2) + "rem";
  });
}

function init() {
  addIds([".item"]);
  initPomodoros();
  initSaveHandlers(document);
  initAddHandlers(document);
  initDoneHandlers(document);
  resizeItems(document);

  var metaMenu = new MetaMenu([
    new CategoryMenu(),
    new ItemTypeMenu()
  ]);
}

document.addEventListener("DOMContentLoaded", init);
