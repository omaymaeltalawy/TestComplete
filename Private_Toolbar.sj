//USEUNIT Private_Utils
/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new ToolBar(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
};
/* Object Model ***********************************************************************************/
/** @class "ToolBar" object model
    
    @description Represents a toolbar.
    
    @param {Object} control TestComplete's object containing a toolbars.
*/
ToolBar = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name ToolBar.findItem
      
      @description Find toolbar item by its path (name).
      
      @param {String} path ToolBar item path (name).
      
      @returns {Object} ToolBar item found.
  */
  this.findItem = function (path) {
    var f = function (cc, pp) {
      var a = cc.__getItems();
      var p = pp.shift();
      var e = null;
      for (var i = 0; i < a.length; i++) {
       // Log.Message(a[i].__getName());
        if (aqString.Compare(a[i].__getName(), p, false) == 0) {
          e = a[i];
          break;
        }
      }
      if (e == null) return null;
      if (pp.length == 0) return e;
      e.__click();
      return f(e, pp);
    };
    return f(this, path.indexOf("|") >= 0 ? path.split("|") : [path]);
  };
};
/** @class "ToolItem" object model
    
    @description Represents a toolbar.
    
    @param {Object} control TestComplete's object containing a toolbar.
    
    @param {Integer} index ToolBar's index (as appears on screen).
*/
ToolItem = function (control, index) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @field
      
      @description Stores toolbar's index (as appears on screen).
  */
  this.index = index ? index : 0;
  /** @function
      
      @name ToolItem.click
      
      @description Click on a toolbar item.
  */
  this.click = function () {
    this.__click();
  };
  /** @function
      
      @name ToolItem.isEnabled
      
      @description Check whether a toolbar item is enabled.
      
      @param {boolean} ToolBar item is enabled.
  */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function
      
      @name ToolItem.isSelected
      
      @description Check whether a toolbar item is selected.
      
      @param {boolean} ToolBar item is selected.
  */
  this.isSelected = function () {
    return this.__isSelected();
  };
  /** @function
      
      @name ToolItem.isVisible
      
      @description Check whether a toolbar item is visible.
      
      @param {boolean} ToolBar item is visible.
  */
  this.isVisible = function () {
    return this.__isVisible();
  };
  /** @function
      
      @name ToolItem.isExists
      
      @description Check whether a toolbar item is exists.
      
      @param {boolean} ToolBar item is visible.
  */
  this.isExists = function () {
    return this.__isExists();
  };
};
/* Object Bindings ********************************************************************************/
/** @function
    
    @name ToolBar.__initialize
    
    @description Initialize control passed to "ToolBar" object.
    
    @param {Object} control TestComplete's object containing a toolbars.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
ToolBar.prototype.__initialize = function (control) {
  var b = [],
    i;
  if (true) {
    b.push(__binding.toolbar_default);
  }
  if (control.ObjectIdentifier === "rightMenuUplandDiv" && control.ObjectType === "Panel") {
    b.push(__binding.Toolbar_NavBar);
  }
  if ((control.ObjectIdentifier === "TenroxRightTpMenu_dvTopRightMenu" || control.className === "tenrox_header") && control.ObjectType === "Panel") {
    b.push(__binding.Toolbar_HeaderRight);
  }
  if (control.ObjectIdentifier === "topFilterPanel" && control.ObjectType === "Panel") {
    b.push(__binding.Toolbar_topFilterPanel);
  }
  if (b.length === 0) {
    throw "Runtime Object validation failed";
  }
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};
/** @function
    
    @name ToolItem.__initialize
    
    @description Initialize control passed to "ToolItem" object.
    
    @param {Object} control TestComplete's object containing a toolbars.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
ToolItem.prototype.__initialize = function (control) {
  return control;
};
/** @description "ToolBar" default object bindings. */
__binding.toolbar_default = function () {
  /** @function
      @name ToolBar.__getItems
      @description Retrieve ToolItems contained in a ToolBar.
      @returns {Array} Array of ToolItems.
  */
  ToolBar.prototype.__getItems = function () {};
  /** @function
      @name ToolItem.__getName
      @description Retreive ToolItem's name (caption), if any.
      @returns {String} ToolItem's name.
  */
  ToolItem.prototype.__getName = function () {};
  /** @function
      @name ToolItem.__isVisible
      @description Check whether a ToolItem is visible.
      @returns {boolean} ToolItem's is visible.
  */
  ToolItem.prototype.__isVisible = function () {};
  /** @function
      @name ToolItem.__isEnabled
      @description Check whether a ToolItem is enabled.
      @returns {boolean} ToolItem is enabled.
  */
  ToolItem.prototype.__isEnabled = function () {};
  /** @function
      @name ToolItem.__click
      @description Click on a ToolItem.
  */
  ToolItem.prototype.__click = function () {};
  /** @function
      @name ToolItem.__getItems
      @description Retrieve ToolItems contained in a ToolItem.
      @returns {Array} Array of ToolItems.
  */
  ToolItem.prototype.__getItems = function () {};
  /** @function
      @name ToolItem.__isSelected
      @description Check whether a ToolItem is selected
      @returns {boolean} ToolItem is selected.
  */
  ToolItem.prototype.__isSelected = function () {};
  /** @function
      @name ToolItem.__isExists
      @description Check whether a ToolItem is exists
      @returns {boolean} ToolItem is exist.
  */
  ToolItem.prototype.__isExists = function () {};
};
/** Binding Toolbar_NavBar **/
__binding.Toolbar_NavBar = function () {
  /**
   * @function
   * @description get the Toolbar Items from the given Object
   * @returns {Array}
   * @example ToolbarObject.__getItems()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolBar.prototype.__getItems = function () {
    var res = [], i, ToolBarObjects;
    ToolBarObjects = this.control.FindAllChildren(["ObjectType", "Visible"], ["Image", true], 5);
    ToolBarObjects = (new VBArray(ToolBarObjects)).toArray();
    for (i = 0; i < ToolBarObjects.length; i++) {
      res.push(new ToolItem(ToolBarObjects[i], i));
    }
    return res;
  };
  /**
   * @function
   * @description get the Toolbar Item name from the given Object
   * @returns {String}
   * @example ToolbarObject.__getName()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__getName = function () {
    return this.control.title;
  };
  /**
   * @function
   * @description check if the toolbar item is enabled
   * @returns {Boolean}
   * @example ToolbarObject.__isEnabled()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /**
   * @function
   * @description Checks if the object is visible or not
   * @returns {Boolean}
   * @example ToolbarObject.__isVisible()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isVisible = function () {
    return this.control.VisibleOnScreen;
  };
  /**
   * @function
   * @description Checks if the Item is selected or not.
   * @returns {Boolean}
   * @example ToolbarObject.__isSelected()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isSelected = function () {
    return aqObject.CompareProperty(this.control.namePropStr, cmpContains, 'HOVER.PNG', false, lmNone);
  };
  /**
   * @function
   * @description perform click on Toolbar Item
   * @returns {Void}
   * @example ToolbarObject.__click()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__click = function () {
    this.control.Click();
    return;
  };
};
/** @description "ToolBar" worktree object bindings. */
__binding.Toolbar_HeaderRight = function () {
  /**
   * @function
   * @description get the Toolbar Items from the given Object
   * @returns {Array}
   * @example ToolbarObject.__getItems()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolBar.prototype.__getItems = function () {
    var res = [], i, ToolBarObjects;
    ToolBarObjects = this.control.FindAllChildren(["ClassName", "Visible"], ["rrTopMenuImgColExp", true], 4);
    ToolBarObjects = (new VBArray(ToolBarObjects)).toArray();
    for (i = 0; i < ToolBarObjects.length; i++) {
      res.push(new ToolItem(ToolBarObjects[i], i));
    }
    ToolBarObjects = this.control.FindAllChildren(["ClassName", "Visible"], ["RTopMenuEl", true], 4);
    ToolBarObjects = (new VBArray(ToolBarObjects)).toArray();
    for (i = 0; i < ToolBarObjects.length; i++) {
      res.push(new ToolItem(ToolBarObjects[i], i));
    }
    return res;
  };
  /**
   * @function
   * @description get the ToolItem's Items from the given Object
   * @returns {Array}
   * @example ToolItemObject.__getItems()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__getItems = function () {
    var res = [], i, ToolItemObjects, parentObj;
    parentObj = this.control.Parent;
    while (parentObj.Parent && parentObj.ObjectType !== "Page") {
      parentObj = parentObj.Parent;
    }
    ToolItemObjects = parentObj.FindAllChildren(["ClassName", "VisibleOnScreen"], ["helpDivSubMenu", true], 7);
    ToolItemObjects = (new VBArray(ToolItemObjects)).toArray();
    for (i = 0; i < ToolItemObjects.length; i++) {
      res.push(new ToolItem(ToolItemObjects[i], i));
    }
    return res;
  };
  /**
   * @function
   * @description get the Toolbar Item name from the given Object
   * @returns {String}
   * @example ToolbarObject.__getName()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__getName = function () {
    var itemName;
    if (this.control.ClassName === 'helpDivSubMenu') {
      itemName = this.control.textContent;
    } else {
      itemName = this.control.title;
    }
    return itemName;
  };
  /**
   * @function
   * @description check if the toolbar item is enabled
   * @returns {Boolean}
   * @example ToolbarObject.__isEnabled()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /**
   * @function
   * @description Checks if the item is Visible or not.
   * @returns {Boolean}
   * @example ToolbarObject.__isVisible()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isVisible = function () {
    return this.control.VisibleOnScreen;
  };
  /**
   * @function
   * @description Checks if the item is selected or not
   * @returns {Boolean}
   * @example ToolbarObject.__isSelected()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isSelected = function () {
    return true;
  };
  /**
   * @function
   * @description perform click on Toolbar Item
   * @returns {Void}
   * @example ToolbarObject.__click()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__click = function () {
    //this.control.Click();
    this.control.Click(20, this.control.Height/2, 0);
    return;
  };
};
/** binding topFilterPanel **/
__binding.Toolbar_topFilterPanel = function () {
  /**
   * @function
   * @description get the Toolbar Items from the given Object
   * @returns {Array}
   * @example ToolbarObject.__getItems()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolBar.prototype.__getItems = function () {
    var res = [], i, ToolBarObjects;
    ToolBarObjects = this.control.FindAllChildren(["ClassName", "Visible"], ["divHeader *", true], 1);
    ToolBarObjects = (new VBArray(ToolBarObjects)).toArray();
    for (i = 0; i < ToolBarObjects.length; i++) {
      res.push(new ToolItem(ToolBarObjects[i], i));
    }
    return res;
  };
  /**
   * @function
   * @description get the Toolbar Item name from the given Object
   * @param {String} name ToolItem Name
   * @returns {String}
   * @example ToolbarObject.__getName()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__getName = function () {
    return this.control.title;
  };
  /**
   * @function
   * @description check if the toolbar item is enabled
   * @returns {Boolean}
   * @example ToolbarObject.__isEnabled()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /**
   * @function
   * @description Checks if the item is visible or not
   * @returns {Boolean}
   * @example ToolbarObject.__isVisible()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isVisible = function () {
    return this.control.VisibleOnScreen;
  };
  /**
   * @function
   * @description Checks if the item is selected or not
   * @returns {Boolean}
   * @example ToolbarObject.__isSelected()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__isSelected = function () {
    return true;
  };
  /**
   * @function
   * @description perform click on Toolbar Item
   * @returns {Void}
   * @example ToolbarObject.__click()
   * @author Iftikhar Ali
   * @date 01/25/2014
   */
  ToolItem.prototype.__click = function () {
    this.control.Click(2, this.control.Height / 2);
    return;
  };
};