var Menu = function(id, size, labels, colors) {
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
  console.group("Menu subclass should override navigateFunction.");
  console.log(this);
  console.log(navItem);
  console.groupEnd();
};

Menu.prototype.showMenu = function() {
  console.group("Menu subclass should override showMenu.");
  console.log(this);
  console.groupEnd();
};

Menu.prototype.setTriggers = function(selector) {
  var that = this;
  var elements = document.querySelectorAll(selector);
  elements.forEach(function(element) {
    element.addEventListener("click", that.showMenu.bind(that));
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
