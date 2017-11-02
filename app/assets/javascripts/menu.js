var Menu = function initMenu(id, size, labels, colors) {
  this.wheelNav = new wheelnav(id, null, size, size);
  this.element = document.getElementById(id);
  this.size = size;

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
  console.log(navItem);
};

Menu.prototype.setTriggers = function(selector, func) {
  var elements = document.querySelectorAll(selector);
  elements.forEach(function(element) {
    element.addEventListener("click", func);
  });
};

Menu.prototype.setNavItemColor = function(index, color) {
  var titleAttr = this.wheelNav.navItems[index].titleAttr;
  titleAttr["fill"] = color;
  this.wheelNav.navItems[index].titleAttr = titleAttr;
  this.wheelNav.refreshWheel();
};
