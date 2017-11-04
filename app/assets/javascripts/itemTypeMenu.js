var ItemTypeMenu = function() {
  var labels = ItemTypeMenu.types.map(function(type) { return type.abbrev });

  Menu.call(
    this,
    "item-type-menu",
    150,
    labels,
    Menu.alternatingColors(labels.length),
    ".item [class*='type-']"
  );

  this.setNavItemFont("normal normal normal 14px/1 FontAwesome");
  this.metaLabel = "Type";
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

ItemTypeMenu.types = [
  { name: "Appointment",  abbrev: "" },
  { name: "Book",         abbrev: "" },
  { name: "Fun",          abbrev: "" },
  { name: "Item",         abbrev: "" },
  { name: "Ocr",          abbrev: "" },
  { name: "Task",         abbrev: "" },
  { name: "Tweet",        abbrev: "" },
];
