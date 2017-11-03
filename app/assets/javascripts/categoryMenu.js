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

var CategoryMenu = function initCategoryMenu() {
  Menu.call(
    this,
    "category-menu",
    150,
    g_categories.map(function(cat) { return cat.abbrev }),
    g_categories.map(function(cat) { return cat.color })
  );

  this.setNavItemColor(9, "#aaa");
  this.setTriggers(".item [class*='cat-']", this.showCategoryMenu.bind(this));
};

CategoryMenu.prototype = Object.create(Menu.prototype);
CategoryMenu.prototype.constructor = CategoryMenu;

CategoryMenu.prototype.navigateFunction = function(navItem) {
  var cat = g_categories[navItem.wheelItemIndex];
  var item = document.getElementById(this.element.dataset.itemId);
  var icon = item.querySelector("[class*='cat-']");

  var classes = icon.classList;
  classes.forEach(function(className) {
    if (className.startsWith("cat-")) {
      icon.classList.remove(className);
    }
  });
  icon.classList.add("cat-" + cat.name);

  this.element.classList.add("hidden");
}

CategoryMenu.prototype.showCategoryMenu = function(ev) {
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
