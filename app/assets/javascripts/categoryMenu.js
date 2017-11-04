var CategoryMenu = function() {
  Menu.call(
    this,
    "category-menu",
    150,
    CategoryMenu.categories.map(function(cat) { return cat.abbrev }),
    CategoryMenu.categories.map(function(cat) { return cat.color }),
    ".item [class*='cat-']"
  );

  this.setNavItemColor("#aaa", 9);
  this.metaLabel = "Category";
};

CategoryMenu.prototype = Object.create(Menu.prototype);
CategoryMenu.prototype.constructor = CategoryMenu;

CategoryMenu.prototype.navigateFunction = function(navItem) {
  var cat = CategoryMenu.categories[navItem.wheelItemIndex];
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

CategoryMenu.categories = [
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
