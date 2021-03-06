//USEUNIT Private_Tab
//USEUNIT Private_Utils
//USEUNIT Common_MenuBar

/** @function
    
    @name Common_Tab.ClickTabItem
    
    @description Clicks tab item.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item  Name of the tab item to click.
*/
function ClickTabItem (Tab, Item) {
  var control = Tab;
  var item = Item;
  try {
    Log.AppendFolder("Common_Tab.ClickTabItem");
    var t = Private_Tab.initWrapper(control).findTab(item);
    
    if (t == null) Log.Error("Tab \"" + item + "\" not found.");
    t.click();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.TabItemSelected
    
    @description Check is a tab item selected.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
    
    @returns {boolean} Tab Item is selected.
*/
function TabItemSelected (Tab, Item) {
  var control = Tab;
  var item = Item;
  try {
    Log.AppendFolder("Common_Tab.TabItemSelected");
    var t = Private_Tab.initWrapper(control).findTab(item);
    if (t == null) Log.Error("Tab \"" + item + "\" not found.");
    return t.isSelected();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.VerifyTabItemSelected
    
    @description Check is a tab item selected. Write a log message.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
*/
function VerifyTabItemSelected (Tab, Item) {
  var control = Tab;
  var item = Item;
  if (TabItemSelected(control, item)) {
    Log.Checkpoint("The Tab Item with name '" + item + "' is selected.");
  } else {
    Log.Error("The Tab Item with name '" + item + "' is not selected.");
  }
}

/** @function
    
    @name Common_Tab.TabItemEnabled
    
    @description Check is a tab item enabled.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
    
    @returns {boolean} Tab Item is enabled.
*/
function TabItemEnabled(control, item) {
  try {
    Log.AppendFolder("Common_Tab.TabItemEnabled");
    var t = Private_Tab.initWrapper(control).findTab(item);
    if (t == null) Log.Error("Tab \"" + item + "\" not found.");
    return t.isEnabled();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.VerifyTabItemEnabled
    
    @description Check is a tab item enabled. Write a log message.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
*/
function VerifyTabItemEnabled(control, item) {
  if (TabItemEnabled(control, item)) {
    Log.Checkpoint("The Tab Item with name '" + item + "' is enabled.");
  } else {
    Log.Error("The Tab Item with name '" + item + "' is not enabled.");
  }
}

/** @function
    
    @name Common_Tab.TabItemVisible
    
    @description Check whether tab item is visible.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
    
    @returns {boolean} Tab Item is visible.
*/
function TabItemVisible(control, item) {
  try {
    Log.AppendFolder("Common_Tab.TabItemVisible");
    var t = Private_Tab.initWrapper(control).findTab(item);
    if (t == null) Log.Error("Tab \"" + item + "\" not found.");
    return t.isVisible();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.VerifyTabItemVisible
    
    @description Check whether a tab item is visible. Write a log message.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
*/
function VerifyTabItemVisible(control, item) {
  if (TabItemVisible(control, item)) {
    Log.Checkpoint("The Tab Item with name '" + item + "' is visible.");
  } else {
    Log.Error("The Tab Item with name '" + item + "' is not visible.");
  }
}

/** @function
    
    @name Common_Tab.TabItemExists
    
    @description Check is a tab item exists.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
    
    @returns {boolean} Tab Item is exist.
*/
function TabItemExists (Tab, Item) {
  var control = Tab;
  var item = Item;
  try {
    Log.AppendFolder("Common_Tab.TabItemExists");
    return Private_Tab.initWrapper(control).findTab(item) != null;
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.VerifyTabItemExists
    
    @description Check is a tab item exists. Write a log message.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item to check.
*/
function VerifyTabItemExists (Tab, Item)  {
  var control = Tab;
  var item = Item;
  if (TabItemExists(control, item)) {
    Log.Checkpoint("The Tab Item with name '" + item + "' exists under the Tab Object");
  } else {
    Log.Error("The Tab Item with name '" + item + "' does not exist under the Tab Object");
  }
}

/** @function
    
    @name Common_Tab.ClickTabItemPopupIcon
    
    @description Click on Tab V icon.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item.
*/
function ClickTabItemPopupIcon(control, item) {
  var t;
  try {
    Log.AppendFolder("Common_Tab.ClickTabItemPopupIcon");
    t = Private_Tab.initWrapper(control).findTab(item);
    if (t === null) {
      Log.Error("Tab \"" + item + "\" not found.");
    }
    t.__clickPopupIcon();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_Tab.ClickTabItemPopupItem
    
    @description Click on Tab V icon and item in it.
    
    @param {Object} control TestComplete's object containing a TabPanel.
    @param {String} item Name of the tab item.
    @param {String} item Name of the popup item to click.
*/
function ClickTabItemPopupItem(control, item, popupItem) {
  var form, popup;
  try {
    Log.AppendFolder("Common_Tab.ClickTabItemPopupItem");
    ClickTabItemPopupIcon(control, item);
    form = Private_Utils.GetParentByType(control, "Form");
    popup = form.FindChild(["className", "VisibleOnScreen"], ["*radmenu*", true]);
    Common_MenuBar.ClickMenubarItem(popup, popupItem);
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}
