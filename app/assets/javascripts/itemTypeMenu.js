var ItemTypeMenu = function() {
  Menu.call(
    this,
    "item-type-menu",
    150,
    ItemTypeMenu.types.map(function(type) { return type.abbrev }),
    ItemTypeMenu.types.map(function(type) { return type.color })
  );

  this.setTriggers(".item [class*='type-']");
  this.setNavItemFont("normal normal normal 14px/1 FontAwesome");
};

ItemTypeMenu.prototype = Object.create(Menu.prototype);
ItemTypeMenu.prototype.constructor = ItemTypeMenu;

ItemTypeMenu.prototype.navigateFunction = function(navItem) {
  var type = ItemTypeMenu.types[navItem.wheelItemIndex];
  var item = document.getElementById(this.element.dataset.itemId);
  var icon = item.querySelector("[class*='type-']");

  var classes = icon.classList;
  classes.forEach(function(className) {
    if (className.startsWith("type-")) {
      icon.classList.remove(className);
    }
  });
  icon.classList.add("type-" + type.name);

  this.element.classList.add("hidden");
}

ItemTypeMenu.prototype.showMenu = function(ev) {
  var icon = ev.target;
  var item = icon.closest(".item");

  var halfMenuWidth = this.size / 2;
  var magicOffset = 7; // :(
  var left = item.offsetLeft - halfMenuWidth + magicOffset;
  var top = item.offsetTop - halfMenuWidth + magicOffset;

  this.element.dataset.itemId = item.id;
  this.element.style.left = left + "px";
  this.element.style.top = top + "px";
  this.element.classList.remove("hidden");

  this.wheelNav.refreshWheel();
}

ItemTypeMenu.color1 = "#cccccc";
ItemTypeMenu.color2 = "#fafafa";

ItemTypeMenu.types = [
  { name: "Appointment",  abbrev: "",  color: ItemTypeMenu.color1 },
  { name: "Book",         abbrev: "",  color: ItemTypeMenu.color2 },
  { name: "Fun",          abbrev: "",  color: ItemTypeMenu.color1 },
  { name: "Item",         abbrev: "",  color: ItemTypeMenu.color2 },
  { name: "OCR",          abbrev: "",  color: ItemTypeMenu.color1 },
  { name: "Task",         abbrev: "",  color: ItemTypeMenu.color2 },
  { name: "Tweet",        abbrev: "",  color: ItemTypeMenu.color1 },
];
