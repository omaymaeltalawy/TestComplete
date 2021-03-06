//USEUNIT Common_Application

/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new MenuBar(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
};
/* Object Model ***********************************************************************************/
/** @class "MenuBar" object model
    
    @description Represents a menu bar.
    
    @param {Object} control TestComplete's object containing a menu bar.
*/
MenuBar = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name MenuBar.findItem
      
      @description Find menu item by its path (name).
      
      @param {String} path Menu item path (name).
      
      @returns {Object} A set of menu items found.
  */
  this.findItem = function (path) {
    var f = function (cc, pp) {
      var a = cc.__getItems(), p = pp.shift(), e = null, i;
      for (i = 0; i < a.length; i++) {
        if (p === a[i].getName()) {
          e = a[i];
          break;
        }
      }
      if (e === null) {
        return null;
      }
      if (pp.length === 0) {
        return e;
      }
      return f(e, pp);
    };
    return f(this, path.indexOf("|") >= 0 ? path.split("|") : [path]);
  };
};
/** @class "MenuItem" object model
    
    @description Represents a menu item.
    
    @param {Object} control TestComplete's object containing a menu item.
    @param {String} itemCaption  Stores item's Caption (as appears on screen).
*/
MenuItem = function (control, itemCaption) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name MenuItem.click
      
      @description Click on a menu item.
  */
  this.click = function () {
    this.__click();
  };
  /** @function
      
      @name MenuItem.getName
      
      @description Retrieve menu item's name.
      
      @param {boolean} Menu item's name.
  */
  this.getName = function () {
    return this.__getName();
  };
  /** @field
      
      @description Stores menuItem's Caption (as appears on screen).
  */
  this.itemCaption = itemCaption;
  /** @function
      
      @name MenuItem.isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
};

/** @function
    
    @name MenuBar.__initialize
    
    @description Initialize control passed to "MenuBar" object.
    
    @param {Object} control TestComplete's object containing a MenuBar.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
MenuBar.prototype.__initialize = function (control) {
  var b = [];
  if (true) {
    b.push(__binding.MenuBar_Default);
  }
  if (aqObject.IsSupported(control, "ObjectIdentifier") && aqString.StrMatches("rightMenuUplandDiv", control.ObjectIdentifier)) {
    b.push(__binding.MenuBar_MenuUpland);
  }
  if (aqObject.IsSupported(control, "className") && aqString.StrMatches("tenrox_header", control.className)) {
    b.push(__binding.MenuBar_MenuHeader);
  }
  if (aqObject.IsSupported(control, "className") && (aqString.StrMatches("BtnListDiv", control.className) || aqString.StrMatches("BtnListTenroxDiv", control.className))) {
    b.push(__binding.MenuBar_MenuButtons);
  }
  if (aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "dvBtnList") {
    b.push(__binding.MenuBar_BtnList);
  }
  if (aqObject.IsSupported(control, "className") && aqString.StrMatches("TBar", control.className)) {
    b.push(__binding.MenuBar_TBar);
  }
  if (aqObject.IsSupported(control, "className") && (aqString.StrMatches("ontextMenu", control.className) || aqString.StrMatches("contextmenu", control.className) )) {
    b.push(__binding.MenuBar_MenuPopup);
  }
  for (var i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};
/** @function
    
    @name MenuItem.__initialize
    
    @description Initialize control passed to "MenuItem" object.
    
    @param {Object} control TestComplete's object containing a menu item.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
MenuItem.prototype.__initialize = function (control) {
  return control;
};
/** @description "MenuBar" Default object binding. */
__binding.MenuBar_Default = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    return null;
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {};
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    return null;
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return '';
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return '';
  };
};

/** @description "MenuBar" Menu Upland object binding. */
__binding.MenuBar_MenuUpland = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], itemObjects, i;
    //load ui objects
    itemObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["Image", true], 6, true).toArray();
    for (i = 0; i < itemObjects.length; i++) {
      //create wrapper to the ui objects
      items.push(new MenuItem({item:itemObjects[i], level:0}, itemObjects[i].title));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    var items = [], parent, menuPopup, menuItems = [], i, menuItem, timeout;

    parent = this.control.item.parent;
    switch (this.control.level) {
      case 0:
        this.__click();
        Common_Application.WaitForLoad(this.control.item, Options.Run.Timeout);
        while (!aqObject.IsSupported(parent, "ObjectType") || parent.ObjectType !== "Page") {
          parent = parent.Parent;
        }
        menuPopup = parent.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "dvMenuTree", true], 10, true);
        break;
      case 1:
        menuPopup = parent.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*Sub*"]);
        if (!menuPopup.Visible) {
          this.__click();
        }
        timeout = GetTickCount() + Options.Run.Timeout;
        while (!menuPopup.Visible) {
          if (GetTickCount() > timeout) {
            throw "Failed to expand";
          }
          delay(500);
        }
      break;
      case 2:
        return items;
        break;
      break;
    }

    menuItems = menuPopup.FindAllChildren(["ObjectType", "Visible"], ["Panel", true]).toArray();
    //create wrapper to the ui objects
    for (i = 0; i < menuItems.length; i++) {
      if (menuItems[i].ChildCount === 1) {
        items.push(new MenuItem({item:menuItems[i], level:this.control.level + 1}, menuItems[i].contentText));
      } else {
        menuItem = menuItems[i].FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "*ParentMnu*", true]);
        items.push(new MenuItem({item:menuItem, level:this.control.level + 1}, menuItem.contentText));
      }
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    this.control.item.Click();
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return this.itemCaption;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return this.control.item.Enabled;
  };
};

/** @description "MenuBar" Menubar Header object binding. */
__binding.MenuBar_MenuHeader = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], itemObjects, i;
    //load ui objects
    itemObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["Panel", true], 10, true).toArray();
    for (i = 0; i < itemObjects.length; i++) {
      //create wrapper to the ui objects
      items.push(new MenuItem(itemObjects[i], itemObjects[i].title));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    var items = [], parent, menuPopup, menuItems, i, timeout, totalTimeout;
    timeout = Options.Run.Timeout;
    totalTimeout = 0;
    do {
      //open sub-menu
      this.__click();
      Sys.Refresh();
      Aliases.RefreshMappingInfo();
      parent = this.control.parent;
      while (!aqObject.IsSupported(parent, "ObjectType") || parent.ObjectType !== "Page") {
        parent = parent.Parent;
      }
      menuPopup = parent.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "divSubMenuTenrox*", true], 0, true);
      if (!menuPopup.Exists) {
        if (totalTimeout >= timeout) {
          Log.Error("The object does not exist.");
        }
        aqUtils.Delay(500);
        totalTimeout += 500;
      }
    } while (!menuPopup.Exists);
    menuItems = menuPopup.FindAllChildren(["ObjectType", "Visible"], ["Panel", true]).toArray();
    //create wrapper to the ui objects
    for (i = 0; i < menuItems.length; i++) {
      items.push(new MenuItem(menuItems[i], menuItems[i].contentText));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    this.control.Click(20, this.control.Height/2, 0);
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return this.itemCaption;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
};

/** @description "MenuBar" Menubar buttons object binding. */
__binding.MenuBar_MenuButtons = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], itemObjects, i;
    //load ui objects
    itemObjects = this.control.FindAllChildren(["ObjectType", "Visible", "idStr"], ["TextNode", true, "?*"], 4).toArray();
    for (i = 0; i < itemObjects.length; i++) {
      //create wrapper to the ui objects
      items.push(new MenuItem(itemObjects[i], itemObjects[i].contentText));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    return '';
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    this.control.Click();
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return this.itemCaption;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return aqString.Find(this.control.outerHTML, "gDisabledElement", 0, true) === -1;
  };
};

/** @description "MenuBar" TBar buttons object binding. */
__binding.MenuBar_TBar = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], itemObjects, i;
    //load ui objects
    itemObjects = this.control.FindAllChildren(["ObjectType", "className"], ["Cell", "*SystemBtn*"]).toArray();
    for (i = 0; i < itemObjects.length; i++) {
      //create wrapper to the ui objects
      items.push(new MenuItem(itemObjects[i], itemObjects[i].contentText));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    return [];
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    var link;
    link = this.control.FindChild("ObjectType", "Link");
    if (link.Exists) {
      link.Click();
    } else {
      this.control.Click();
    }
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    var link;
    link = this.control.FindChild("ObjectType", "Link");
    if (link.Exists) {
      return link.contentText;
    }
    return this.control.contentText;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return aqString.Find(this.control.className, "gDisabledElement") === -1;
  };
};
/** @description "MenuBar" dvBtnList buttons object binding. */
__binding.MenuBar_BtnList = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], cells, i, item;
    //load ui objects
    cells = this.control.FindAllChildren("ObjectType", "Cell", 2).toArray();
    for (i = 0; i < cells.length; i++) {
      item = cells[i].FindChild(["ObjectType", "className"], ["TextNode", "lnk"], 2);
      if (item.Exists) {
        items.push(new MenuItem(item, item.contentText));
      } else {
        item = cells[i].FindChild(["ObjectType", "className"], ["Panel", "*SystemBtn*"], 4);
        if (item.Exists) {
          items.push(new MenuItem(item, item.contentText));
        }
      }
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    return [];
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    this.control.Click();
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return this.control.contentText;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
};

/** @description "MenuBar" Menubar Popup object binding. */
__binding.MenuBar_MenuPopup = function () {
  /** @function
      
      @name MenuBar.__getItems
      
      @description Retrieve a set of menu items.
      
      @returns {Object} A set of menu items.
  */
  MenuBar.prototype.__getItems = function () {
    var items = [], itemObjects, i;
    //load ui objects
    itemObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["TextNode", true], 10, true).toArray();
    if (itemObjects.length === 0) {
      itemObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["Panel", true], 10, true).toArray();
    }
    if (itemObjects.length === 0) {
      itemObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["Cell", true], 10, true).toArray();
    }
    for (i = 0; i < itemObjects.length; i++) {
      //create wrapper to the ui objects
      items.push(new MenuItem(itemObjects[i], itemObjects[i].contentText));
    }
    return items;
  };
  /** @function
      
      @name MenuItem.__getItems
      
      @description Retrieve a set of submenu items.
      
      @returns {Object} A set of menu items.
  */
  MenuItem.prototype.__getItems = function () {
    return '';
  };
  /** @function
      
      @name MenuItem.__click
      
      @description Click on a menu item.
  */
  MenuItem.prototype.__click = function () {
    this.control.Click();
  };
  /** @function
      
      @name MenuItem.__getName
      
      @description Retrieve menu item's name.
      
      @returns {String} Menu item's name.
  */
  MenuItem.prototype.__getName = function () {
    return this.itemCaption;
  };
  /** @function
      
      @name MenuItem.__isEnabled
      
      @description Check whether a menu item is enabled.
      
      @param {boolean} Menu item is enabled.
  */
  MenuItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
};