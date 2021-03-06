//USEUNIT Private_Toolbar

/** @function
    
    @name Common_ToolBar.ClickToolBarItem
    
    @description Clicks toolbar item.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item  Name of the toolbar item to click.
*/
function ClickToolBarItem(control, item) {

  try {
    Log.AppendFolder("Common_ToolBar.ClickToolBarItem");
    var t = Private_Toolbar.initWrapper(control).findItem(item);
    if (t == null) Log.Error("ToolBar \"" + item + "\" not found.");
    t.click();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_ToolBar.ToolBarItemSelected
    
    @description Check is a toolbar item selected.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
    
    @returns {boolean} ToolBar Item is selected.
*/
function ToolBarItemSelected(control, item) {
  try {
    Log.AppendFolder("Common_ToolBar.ToolBarItemSelected");
    var t = Private_Toolbar.initWrapper(control).findItem(item);
    if (t == null) Log.Error("ToolBar \"" + item + "\" not found.");
    return t.isSelected();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }    
}

/** @function
    
    @name Common_ToolBar.VerifyToolBarItemSelected
    
    @description Check is a toolbar item selected. Write a log message.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
*/
function VerifyToolBarItemSelected(control, item) {
  if (ToolBarItemSelected(control, item)) {
    Log.Checkpoint("The ToolBar Item with name '" + item + "' is selected.");
  } else {
    Log.Error("The ToolBar Item with name '" + item + "' is not selected.");
  }
}

/** @function
    
    @name Common_ToolBar.ToolBarItemEnabled
    
    @description Check is a toolbar item enabled.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
    
    @returns {boolean} ToolBar Item is enabled.
*/
function ToolBarItemEnabled(control, item) {
  try {
    Log.AppendFolder("Common_ToolBar.ToolBarItemEnabled");
    var t = Private_Toolbar.initWrapper(control).findItem(item);
    if (t == null) Log.Error("ToolBar \"" + item + "\" not found.");
    return t.isEnabled();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_ToolBar.VerifyToolBarItemEnabled
    
    @description Check is a toolbar item enabled. Write a log message.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
*/
function VerifyToolBarItemEnabled(control, item) {
  if (ToolBarItemEnabled(control, item)) {
    Log.Checkpoint("The ToolBar Item with name '" + item + "' is enabled.");
  } else {
    Log.Error("The ToolBar Item with name '" + item + "' is not enabled.");
  }
}

/** @function
    
    @name Common_ToolBar.ToolBarItemVisible
    
    @description Check whether toolbar item is visible.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
    
    @returns {boolean} ToolBar Item is visible.
*/
function ToolBarItemVisible(control, item) {
  try {
    Log.AppendFolder("Common_Toolbar.ToolBarItemVisible");
    var t = Private_Toolbar.initWrapper(control).findItem(item);
    if (t == null) Log.Error("ToolBar \"" + item + "\" not found.");
    return t.isVisible();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    
    @name Common_ToolBar.VerifyToolBarItemVisible
    
    @description Check whether a toolbar item is visible. Write a log message.
    
    @param {Object} control TestComplete's object containing a ToolBar.
    @param {String} item Name of the toolbar item to check.
*/
function VerifyToolBarItemVisible(control, item) {
  if (ToolBarItemVisible(control, item)) {
    Log.Checkpoint("The ToolBar Item with name '" + item + "' is visible.");
  } else {
    Log.Error("The ToolBar Item with name '" + item + "' is not visible.");
  }
}