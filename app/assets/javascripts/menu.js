var Menu = function(id, size, labels, colors, triggerSelector) {
  this.wheelNav = new wheelnav(id, null, size, size);
  this.element = document.getElementById(id);
  this.size = size;
  this.triggerSelector = triggerSelector;

  this.wheelNav.slicePathFunction = slicePath().DonutSlice;
  this.wheelNav.clickModeRotate = false;
  this.wheelNav.navAngle = -90;
  this.wheelNav.clockwise = false;
  this.wheelNav.colors = colors;
  this.wheelNav.titleFont = "bold 16px sans-serif";
  this.wheelNav.initWheel(labels);

  var that = this;
  this.wheelNav.navItems.forEach(function(navItem) {
    navItem.navigateFunction = that.navigateFunction.bind(that, navItem);
  });

  this.wheelNav.createWheel();
};

Menu.prototype.navigateFunction = function(navItem) {
  console.log("Menu subclass should override navigateFunction.");
};

Menu.prototype.showMenu = function(ev) {
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
};

Menu.prototype.enableTriggers = function() {
  var that = this;
  var elements = document.querySelectorAll(that.triggerSelector);
  elements.forEach(function(element) {
    element.addEventListener("dblclick", that.showMenu.bind(that));
  });
};

Menu.prototype.setNavItemColor = function(color, index) {
  this.setNavItemAttr("fill", color, index);
};

Menu.prototype.setNavItemFont = function(font, index) {
  this.setNavItemAttr("font", font, index);
};

Menu.prototype.setNavItemAttr = function(attr, value, index) {
  var navItems;
  if (index) {
    navItems = [ this.wheelNav.navItems[index] ];
  } else {
    navItems = this.wheelNav.navItems;
  }

  navItems.forEach(function(navItem) {
    var updatedAttr = navItem.titleAttr;
    updatedAttr[attr] = value;
    navItem.titleAttr = updatedAttr;
    navItem.titleHoverAttr = updatedAttr;
    navItem.titleSelectedAttr = updatedAttr;
  });

  this.wheelNav.refreshWheel();
};

Menu.alternatingColors = function(length, color1, color2) {
  if (!color1) color1 = "#cccccc";
  if (!color2) color2 = "#fafafa";

  var colors = [];
  for (var i = 0; i < length; i++) {
    colors[i] = (i % 2 == 0) ? color1 : color2;
  }

  return colors;
};
