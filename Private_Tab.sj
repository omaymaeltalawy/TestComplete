//USEUNIT Private_Utils
/** @ignore @description Control binding */
var __binding = {};

/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try { __wrapper = new TabPanel(control); } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message); return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
};

/* Object Model ***********************************************************************************/

/** @class "TabPanel" object model
    
    @description Represents a tab.
    
    @param {Object} control TestComplete's object containing a tabs.
*/
TabPanel = function(control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
 
  /** @function
      
      @name Tab.findTab
      
      @description Retrieve a column by its name.
      
      @param {String} name Name of the column to search for.
  */
  this.findTab = function(name) {
    var cc = this.__getTabItems();
    
    for (var i = 0; i < cc.length; i++) { if (cc[i].__getName() == name) return cc[i]; }
    
    return null;
  };
 
  return this;
};

/** @class "TabItem" object model
    
    @description Represents a tab.
    
    @param {Object} control TestComplete's object containing a tab.
    
    @param {Integer} index Tab's index (as appears on screen).
*/
TabItem = function(control, index) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
 
  /** @field
      
      @description Stores tab's index (as appears on screen).
  */
  this.index = index ? index : 0;
 
/** @function
      
      @name TabItem.click
      
      @description Click on a tabpanel item.
  */
  this.click = function() { this.__click(); };   
  
  /** @function
      
      @name TabItem.isEnabled
      
      @description Check whether a tabpanel item is enabled.
      
      @param {boolean} TabPanel item is enabled.
  */
  this.isEnabled = function() { return this.__isEnabled(); };
  
  /** @function
      
      @name TabItem.isSelected
      
      @description Check whether a tabpanel item is selected.
      
      @param {boolean} TabPanel item is selected.
  */
  this.isSelected = function() { return this.__isSelected(); };  

  /** @function
      
      @name TabItem.isVisible
      
      @description Check whether a tabpanel item is visible.
      
      @param {boolean} TabPanel item is visible.
  */
  this.isVisible = function() { return this.__isVisible(); };  
};

/* Object Bindings ********************************************************************************/

/** @function
    
    @name TabPanel.__initialize
    
    @description Initialize control passed to "TabPanel" object.
    
    @param {Object} control TestComplete's object containing a tabs.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
TabPanel.prototype.__initialize = function(control) {
  var bindings = [];  

  if (true) bindings.push(__binding.tabpanel_default);
  if ((aqObject.IsSupported(control, "className") && aqString.StrMatches("ui-tabs", control.className))
    || (aqObject.IsSupported(control, "ObjectIdentifier") && aqString.StrMatches("Main_tab_", control.ObjectIdentifier)) 
    || (aqObject.IsSupported(control, "ObjectType") && aqString.StrMatches("Table", control.ObjectType))) {
    bindings.push(__binding.tabpanel_uitabs);
  }

  if (bindings.length == 0) { throw "Runtime Object validation failed"; }
 
  for (var i = 0; i < bindings.length; i++) { bindings[i](); }
 
  return control;
};

/** @function
    
    @name TabItem.__initialize
    
    @description Initialize control passed to "TabItem" object.
    
    @param {Object} control TestComplete's object containing a tabs.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
TabItem.prototype.__initialize = function(control) { return control; };

/** @description "TabPanel" default object bindings. */
__binding.tabpanel_default = function() {
  /** @function
      
      @name TabPanel.__getTabItems
      
      @description Retrieve TabItems contained in a TabPanel.
      
      @returns {Array} Array of TabItems.
  */
  TabPanel.prototype.__getTabItems = function() {};  
 
  /** @function
      
      @name TabItem.__getName
      
      @description Retreive TabItem's name (caption), if any.
      
      @returns {String} TabItem's name.
  */
  TabItem.prototype.__getName = function() {};
  
  /** @function
      
      @name TabItem.__isVisible
      
      @description Check whether a TabItem is visible.
      
      @returns {boolean} TabItem's is visible.
  */
  TabItem.prototype.__isVisible = function() {};    
  
  /** @function
      
      @name TabItem.__isEnabled
      
      @description Check whether a TabItem is enabled.
      
      @returns {boolean} TabItem is enabled.
  */
  TabItem.prototype.__isEnabled = function() {};   
  
  /** @function
      
      @name TabItem.__click
      
      @description Click on a TabItem.
  */
  TabItem.prototype.__click = function() {};  

/** @function
      
      @name TabItem.__isSelected
      
      @description Check whether a TabItem is selected
      
      @returns {boolean} TabItem is selected.
  */
  TabItem.prototype.__isSelected = function() {};  
};
  
/** @description "TabPanel" object bindings for Main tabpanel. */
__binding.tabpanel_uitabs = function () {
  /** @function
      
      @name TabPanel.__getTabItems
      
      @description Retrieve TabItems contained in a TabPanel.
      
      @returns {Array} Array of TabItems.
  */
  TabPanel.prototype.__getTabItems = function () {
    var tabs = [], tabObjects, i;
    tabObjects = this.control.FindAllChildren("ObjectType", "Link", 10).toArray();
    for (i = 0; i < tabObjects.length; i++) {
      tabs.push(new TabItem(tabObjects[i], i));
    }
    return tabs;
  };

  /** @function
      
      @name TabItem.__getName
      
      @description Retreive TabItem's name (caption), if any.
      
      @returns {String} TabItem's name.
  */
  TabItem.prototype.__getName = function () {
    return this.control.contentText.split('\n')[0];
  };

  /** @function
      
      @name TabItem.__isVisible
      
      @description Check whether a TabItem is visible.
      
      @returns {boolean} TabItem's is visible.
  */
  TabItem.prototype.__isVisible = function () {
    return this.control.Visible;
  };

  /** @function
      
      @name TabItem.__isEnabled
      
      @description Check whether a TabItem is enabled.
      
      @returns {boolean} TabItem is enabled.
  */
  TabItem.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };

  /** @function
      
      @name TabItem.__click
      
      @description Click on a TabItem.
  */
  TabItem.prototype.__click = function () {
    this.control.Click();
  };
  
  /** @function
      
      @name TabItem.__click
      
      @description Click on a TabItem.
  */
  TabItem.prototype.__clickPopupIcon = function () {
    var icon;
    icon = this.control.FindChild(["ObjectType", "className"], ["TextNode", "dropdown-icon"], 2);
    if (!icon.Exists) {
      throw "Popup icon not found";
    }
    icon.Click();
  };

  /** @function
      
      @name TabItem.__isSelected
      
      @description Check whether a TabItem is selected
      
      @returns {boolean} TabItem is selected.
  */
  TabItem.prototype.__isSelected = function () {
    return (Private_Utils.GetBackgroundColor(this.control, 1, 1) === 0xFFFFFF);
  };
};
