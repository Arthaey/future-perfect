var MetaMenu = function(menus) {
  var selectors = menus.map(function(m) { return m.triggerSelector });
  var labels = menus.map(function(m) { return m.metaLabel || m.element.id });

  Menu.call(
    this,
    "meta-menu",
    150,
    labels,
    Menu.alternatingColors(labels.length),
    selectors.join(", ")
  );

  this.enableTriggers();
  this.menus = menus;
};

MetaMenu.prototype = Object.create(Menu.prototype);
MetaMenu.prototype.constructor = MetaMenu;

MetaMenu.prototype.navigateFunction = function(navItem) {
  var menu = this.menus[navItem.wheelItemIndex];
  var item = document.getElementById(this.element.dataset.itemId);

  menu.showMenu({ target: item });

  this.element.classList.add("hidden");
}
