//USEUNIT Private_WorkflowEditor
var item, transition;

/** @function
    @name Common_WorkflowEditor.WorkflowToolBarItemExists
    @description Check if the given toolbar item of the workflow exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
    @returns {Boolean} True if the item exists, otherwise False.
*/
function WorkflowToolBarItemExists(control, path) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowToolBarItemExists");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    return !!item;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowToolBarItemExists
    @description Verify if the given toolbar item of the workflow exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
*/
function VerifyWorkflowToolBarItemExists(control, path) {
  if (WorkflowToolBarItemExists(control, path)) {
    Log.Checkpoint("ToolBar item '" + path + "' of the workflow editor EXISTS.");
  } else {
    Log.Error("ToolBar item '" + path + "' of the workflow editor DOES NOT exist.");
  }
}

/** @function
    @name Common_WorkflowEditor.WorkflowToolBarItemEnabled
    @description Check if the given toolbar item of the workflow is enabled.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
    @returns {Boolean} True if the item is enabled, otherwise False.
*/
function WorkflowToolBarItemEnabled(control, path) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowToolBarItemEnabled");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    if (!item) {
      Log.Error("ToolBar item '" + path + "' of workflow editor DOES NOT exist.");
    }
    return item.__enabled();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowToolBarItemEnabled
    @description Verify if the given toolbar item of the workflow is enabled.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
*/
function VerifyWorkflowToolBarItemEnabled(control, path) {
  if (WorkflowToolBarItemEnabled(control, path)) {
    Log.Checkpoint("ToolBar item '" + path + "' of the workflow editor is ENABLED.");
  } else {
    Log.Error("ToolBar item '" + path + "' of the workflow editor IS NOT enabled.");
  }
}

/** @function
    @name Common_WorkflowEditor.WorkflowToolBarItemVisible
    @description Check if the given toolbar item of the workflow is visible.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
    @returns {Boolean} True if the item is visible, otherwise False.
*/
function WorkflowToolBarItemVisible(control, path) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowToolBarItemVisible");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    if (!item) {
      Log.Error("ToolBar item '" + path + "' of workflow editor DOES NOT exist.");
    }
    return item.__visible();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowToolBarItemVisible
    @description Verify if the given toolbar item of the workflow is visible.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
*/
function VerifyWorkflowToolBarItemVisible(control, path) {
  if (WorkflowToolBarItemVisible(control, path)) {
    Log.Checkpoint("ToolBar item '" + path + "' of the workflow editor is VISIBLE.");
  } else {
    Log.Error("ToolBar item '" + path + "' of the workflow editor IS NOT visible.");
  }
}

/** @function
    @name Common_WorkflowEditor.HoverMouseWorkflowToolBarItem
    @description Hover over a toolbar item of the workflow
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
*/
function HoverMouseWorkflowToolBarItem(control, path) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.HoverMouseWorkflowToolBarItem");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    if (!item) {
      Log.Error("ToolBar item '" + path + "' of workflow editor DOES NOT exist.");
    }
    item.__hover();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.ClickWorkflowToolBarItem
    @description Click over a toolbar item of the workflow
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
*/
function ClickWorkflowToolBarItem(control, path) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.ClickWorkflowToolBarItem");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    if (!item) {
      Log.Error("ToolBar item '" + path + "' of workflow editor DOES NOT exist.");
    }
    item.__click();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DragWorkflowToolBarItemToCanvas
    @description Drag a toolbar item to the canvas of the WorkflowEditor at specific point (x, y)
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} path The full path to the toolbat item e.g. "Zoom|100%"
    @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)
    @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
*/
function DragWorkflowToolBarItemToCanvas(control, path, x, y) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DragWorkflowToolBarItemToCanvas");
    var item = Private_WorkflowEditor.initWrapper(control).findToolBarItem(path);
    if (!item) {
      Log.Error("ToolBar item '" + path + "' of workflow editor DOES NOT exist.");
    }
    item.__dragToCanvas(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.WorkflowStateExists
    @description Check if the given workflow state exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state exists, otherwise False.
*/
function WorkflowStateExists(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowStateExists");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    return !!item;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateExists
    @description Verify if the given workflow state exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateExists(control, name) {
  if (WorkflowStateExists(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' EXISTS.");
  } else {
    Log.Error("The workflow state '" + name + "' DOES NOT exist.");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowStateFillColor
    @description Get the fill color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowStateFillColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowStateFillColor");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__getFillColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateFillColor
    @description Check the fill color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowStateFillColor(control, name, color) {
  return GetWorkflowStateFillColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateFillColor
    @description Verify the fill color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowStateFillColor(control, name, color) {
  if (IsWorkflowStateFillColor(control, name, color)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' HAS fill color '" + color + "'");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' HAS NOT fill color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowStateDrawColor
    @description Get the draw color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowStateDrawColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowStateDrawColor");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__getDrawColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateDrawColor
    @description Check the draw color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowStateDrawColor(control, name, color) {
  return GetWorkflowStateDrawColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateDrawColor
    @description Verify the draw color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowStateDrawColor(control, name, color) {
  if (IsWorkflowStateDrawColor(control, name, color)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' HAS draw color '" + color + "'");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' HAS NOT draw color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowStateForeColor
    @description Get the fore color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowStateForeColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowStateForeColor");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__getForeColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateForeColor
    @description Check the fore color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowStateForeColor(control, name, color) {
  return GetWorkflowStateForeColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateForeColor
    @description Verify the fore color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowStateForeColor(control, name, color) {
  if (IsWorkflowStateForeColor(control, name, color)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' HAS fore color '" + color + "'");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' HAS NOT fore color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowStateGradientColor
    @description Get the gradient color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowStateGradientColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowStateGradientColor");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__getGradientColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateGradientColor
    @description Check the gradient color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowStateGradientColor(control, name, color) {
  return GetWorkflowStateGradientColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateGradientColor
    @description Verify the gradient color of the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowStateGradientColor(control, name, color) {
  if (IsWorkflowStateGradientColor(control, name, color)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' HAS gradient color '" + color + "'");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' HAS NOT gradient color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateInitial
    @description Check if the given workflow state is initial.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is initial, otherwise False.
*/
function IsWorkflowStateInitial(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowStateFillColor");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isInitial();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateInitial
    @description Verify if the given workflow state is initial.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateInitial(control, name) {
  if (IsWorkflowStateInitial(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS initial");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT initial");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateShadow
    @description Check if the given workflow state is shadow.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is shadow, otherwise False.
*/
function IsWorkflowStateShadow(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateShadow");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isShadow();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateShadow
    @description Verify if the given workflow state is shadow.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateShadow(control, name) {
  if (IsWorkflowStateShadow(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS shadow");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT shadow");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateSink
    @description Check if the given workflow state is sink.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is sink, otherwise False.
*/
function IsWorkflowStateSink(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateSink");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isSink();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateSink
    @description Verify if the given workflow state is sink.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateSink(control, name) {
  if (IsWorkflowStateSink(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS sink");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT sink");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateFinal
    @description Check if the given workflow state is final.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is final, otherwise False.
*/
function IsWorkflowStateFinal(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateFinal");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isFinal();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateFinal
    @description Verify if the given workflow state is final.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateFinal(control, name) {
  if (IsWorkflowStateFinal(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS final");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT final");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateRejection
    @description Check if the given workflow state is rejection.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is rejection, otherwise False.
*/
function IsWorkflowStateRejection(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateRejection");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isRejection();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateRejection
    @description Verify if the given workflow state is rejection.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateRejection(control, name) {
  if (IsWorkflowStateRejection(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS rejection");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT rejection");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateApproval
    @description Check if the given workflow state is approval.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is approval, otherwise False.
*/
function IsWorkflowStateApproval(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateApproval");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isApproval();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateApproval
    @description Verify if the given workflow state is approval.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateApproval(control, name) {
  if (IsWorkflowStateApproval(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS approval");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT approval");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateCompletion
    @description Check if the given workflow state is completion.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is completion, otherwise False.
*/
function IsWorkflowStateCompletion(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateCompletion");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isCompletion();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateCompletion
    @description Verify if the given workflow state is completion.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateCompletion(control, name) {
  if (IsWorkflowStateCompletion(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS completion");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT completion");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateReadOnly
    @description Check if the given workflow state is read only.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is read only, otherwise False.
*/
function IsWorkflowStateReadOnly(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateReadOnly");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isReadOnly();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateReadOnly
    @description Verify if the given workflow state is read only.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateReadOnly(control, name) {
  if (IsWorkflowStateReadOnly(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS read only");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT read only");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateSelected
    @description Check if the given workflow state is selected.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is selected, otherwise False.
*/
function IsWorkflowStateSelected(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateSelected");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isSelected();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateSelected
    @description Verify if the given workflow state is selected.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateSelected(control, name) {
  if (IsWorkflowStateSelected(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS selected");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT selected");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowStateHidden
    @description Check if the given workflow state is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow state.
    @returns {Boolean} True if the state is hidden, otherwise False.
*/
function IsWorkflowStateHidden(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowStateHidden");
    item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    return item.__isHidden();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowStateHidden
    @description Verify if the given workflow state is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function VerifyWorkflowStateHidden(control, name) {
  if (IsWorkflowStateHidden(control, name)) {
    Log.Checkpoint("The workflow state '" + item.__getName() + "' IS hidden");
  } else {
    Log.Error("The workflow state '" + item.__getName() + "' IS NOT hidden");
  }
}

/** @function
    @name Common_WorkflowEditor.HoverMouseWorkflowState
    @description Hover over the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function HoverMouseWorkflowState(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.HoverMouseWorkflowState");
    var item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    item.__hover();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.ClickWorkflowState
    @description Click the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function ClickWorkflowState(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.ClickWorkflowState");
    var item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    item.__click();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DblClickWorkflowState
    @description Double click the given workflow state.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
*/
function DblClickWorkflowState(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DblClickWorkflowState");
    var item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    item.__dblClick();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DragWorkflowStateToPoint
    @description Drag the workflow state to the WorkflowEditor canvas at specific point (x, y)
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the state
    @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)
    @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
*/
function DragWorkflowStateToPoint(control, name, x, y) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DragWorkflowStateToPoint");
    var item = Private_WorkflowEditor.initWrapper(control).findStateByName(name);
    if (!item) {
      Log.Error("The workflow state '" + name + "' DOES NOT exist.");
    }
    item.__dragToPoint(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DragWorkflowStateToAnother
    @description Drag the workflow state to another workflow state (useful for transitions creation)
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} sourceName The name of the source state
    @param {Object} destinationName The name of the destination state
*/
function DragWorkflowStateToAnother(control, sourceName, destinationName) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DragWorkflowStateToPoint");
    var sourceItem, destinationItem;
    sourceItem = Private_WorkflowEditor.initWrapper(control).findStateByName(sourceName);
    if (!sourceItem) {
      Log.Error("The workflow source state '" + sourceName + "' DOES NOT exist.");
    }
    destinationItem = Private_WorkflowEditor.initWrapper(control).findStateByName(destinationName);
    if (!destinationItem) {
      Log.Error("The workflow source state '" + destinationName + "' DOES NOT exist.");
    }
    sourceItem.__dragToState(destinationItem);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.WorkflowTransitionExists
    @description Check if the given workflow transition exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow transition.
    @returns {Boolean} True if the transition exists, otherwise False.
*/
function WorkflowTransitionExists(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowTransitionExists");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    return !!item;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionExists
    @description Verify if the given workflow transition exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function VerifyWorkflowTransitionExists(control, name) {
  if (WorkflowTransitionExists(control, name)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' EXISTS.");
  } else {
    Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowTransitionConnectingStates
    @description Get the workflow transition that connects the given workflow states
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name1 The name of the first state.
    @param {String} name2 The name of the second state.
    @returns {Object} The transition that connects the given workflow states
*/
function GetWorkflowTransitionConnectingStates(control, name1, name2) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowTransitionConnectingStates");
    var transitions, i, current, next;
    transitions = Private_WorkflowEditor.initWrapper(control).__getTransitions();
    for (i = 0; i < transitions.length; i++) {
      current = transitions[i].__getCurrentState();
      next = transitions[i].__getNextState();

      if ((current.__getName() === name1 && next.__getName() === name2) ||
        (current.__getName() === name2 && next.__getName() === name1)) {
        return transitions[i];
      }
    }
    return null;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionConnectingStates
    @description Check if the workflow transition connects the given workflow states
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} transitionName The name of the transition
    @param {String} stateName1 The name of the first state.
    @param {String} stateName2 The name of the second state.
    @returns {Boolean} True if the transition connects the given workflow states
*/
function IsWorkflowTransitionConnectingStates(control, transitionName, stateName1, stateName2) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowTransitionConnectingStates");
    transition = GetWorkflowTransitionConnectingStates(control, stateName1, stateName2);
    return !!(transition && Private_Utils.StringMatches(transition.__getName(), transitionName));
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionConnectingStates
    @description Verify if the workflow transition connects the given workflow states
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} transitionName The name of the transition
    @param {String} stateName1 The name of the first state.
    @param {String} stateName2 The name of the second state.
*/
function VerifyWorkflowTransitionConnectingStates(control, transitionName, stateName1, stateName2) {
  if (IsWorkflowTransitionConnectingStates(control, transitionName, stateName1, stateName2)) {
    Log.Checkpoint("The workflow transition '" + transition.__getName() + "' CONNECTS workflow states '" + stateName1 + "' and '" + stateName2 + "'.");
  } else {
    Log.Error("The workflow transition '" + transitionName + "' DOES NOT connect workflow states '" + stateName1 + "' and '" + stateName2 + "'.");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowTransitionFillColor
    @description Get the fill color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowTransitionFillColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowTransitionFillColor");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__getFillColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionFillColor
    @description Check the fill color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowTransitionFillColor(control, name, color) {
  return GetWorkflowTransitionFillColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionFillColor
    @description Verify the fill color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowTransitionFillColor(control, name, color) {
  if (IsWorkflowTransitionFillColor(control, name, color)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' HAS fill color '" + color + "'");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' HAS NOT fill color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowTransitionDrawColor
    @description Get the draw color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowTransitionDrawColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowTransitionDrawColor");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__getDrawColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionDrawColor
    @description Check the draw color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowTransitionDrawColor(control, name, color) {
  return GetWorkflowTransitionDrawColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionDrawColor
    @description Verify the draw color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowTransitionDrawColor(control, name, color) {
  if (IsWorkflowTransitionDrawColor(control, name, color)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' HAS draw color '" + color + "'");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' HAS NOT draw color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowTransitionForeColor
    @description Get the fore color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowTransitionForeColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowTransitionForeColor");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__getForeColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionForeColor
    @description Check the fore color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowTransitionForeColor(control, name, color) {
  return GetWorkflowTransitionForeColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionForeColor
    @description Verify the fore color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowTransitionForeColor(control, name, color) {
  if (IsWorkflowTransitionForeColor(control, name, color)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' HAS fore color '" + color + "'");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' HAS NOT fore color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowTransitionGradientColor
    @description Get the gradient color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowTransitionGradientColor(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowTransitionGradientColor");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__getGradientColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionGradientColor
    @description Check the gradient color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowTransitionGradientColor(control, name, color) {
  return GetWorkflowTransitionGradientColor(control, name) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionGradientColor
    @description Verify the gradient color of the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowTransitionGradientColor(control, name, color) {
  if (IsWorkflowTransitionGradientColor(control, name, color)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' HAS gradient color '" + color + "'");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' HAS NOT gradient color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionRejection
    @description Check if the given workflow transition is rejection.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow transition.
    @returns {Boolean} True if the transition is rejection, otherwise False.
*/
function IsWorkflowTransitionRejection(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowTransitionRejection");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__isRejection();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionRejection
    @description Verify if the given workflow transition is rejection.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function VerifyWorkflowTransitionRejection(control, name) {
  if (IsWorkflowTransitionRejection(control, name)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' IS rejection");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' IS NOT rejection");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionApproval
    @description Check if the given workflow transition is approval.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow transition.
    @returns {Boolean} True if the transition is approval, otherwise False.
*/
function IsWorkflowTransitionApproval(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowTransitionApproval");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__isApproval();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionApproval
    @description Verify if the given workflow transition is approval.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function VerifyWorkflowTransitionApproval(control, name) {
  if (IsWorkflowTransitionApproval(control, name)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' IS approval");
  } else {
    Log.Error("The workflow transition '" + item.__getName()+ "' IS NOT approval");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowTransitionHidden
    @description Check if the given workflow transition is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the workflow transition.
    @returns {Boolean} True if the transition is hidden, otherwise False.
*/
function IsWorkflowTransitionHidden(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowTransitionHidden");
    item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    return item.__isHidden();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowTransitionHidden
    @description Verify if the given workflow transition is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function VerifyWorkflowTransitionHidden(control, name) {
  if (IsWorkflowTransitionHidden(control, name)) {
    Log.Checkpoint("The workflow transition '" + item.__getName() + "' IS hidden");
  } else {
    Log.Error("The workflow transition '" + item.__getName() + "' IS NOT hidden");
  }
}

/** @function
    @name Common_WorkflowEditor.HoverMouseWorkflowTransition
    @description Hover over the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function HoverMouseWorkflowTransition(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.HoverMouseWorkflowTransition");
    var item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    item.__hover();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.ClickWorkflowTransition
    @description Click the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function ClickWorkflowTransition(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.ClickWorkflowTransition");
    var item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    item.__click();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DblClickWorkflowTransition
    @description Double click the given workflow transition.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
*/
function DblClickWorkflowTransition(control, name) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DblClickWorkflowTransition");
    var item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    item.__dblClick();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DragWorkflowTransitionToPoint
    @description Drag the workflow transition to the WorkflowEditor canvas at specific point (x, y)
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} name The name of the transition
    @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)
    @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
*/
function DragWorkflowTransitionToPoint(control, name, x, y) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DragWorkflowTransitionToPoint");
    var item = Private_WorkflowEditor.initWrapper(control).findTransitionByName(name);
    if (!item) {
      Log.Error("The workflow transition '" + name + "' DOES NOT exist.");
    }
    item.__dragToPoint(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.WorkflowCommentExists
    @description Check if the given workflow comment exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the workflow comment.
    @returns {Boolean} True if the comment exists, otherwise False.
*/
function WorkflowCommentExists(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.WorkflowCommentExists");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    return !!item;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentExists
    @description Verify if the given workflow comment exists.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
*/
function VerifyWorkflowCommentExists(control, text) {
  if (WorkflowCommentExists(control, text)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' EXISTS.");
  } else {
    Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowCommentFillColor
    @description Get the fill color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowCommentFillColor(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowCommentFillColor");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    return item.__getFillColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowCommentFillColor
    @description Check the fill color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowCommentFillColor(control, text, color) {
  return GetWorkflowCommentFillColor(control, text) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentFillColor
    @description Verify the fill color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowCommentFillColor(control, text, color) {
  if (IsWorkflowCommentFillColor(control, text, color)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' HAS fill color '" + color + "'");
  } else {
    Log.Error("The workflow comment '" + item.__getText() + "' HAS NOT fill color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowCommentDrawColor
    @description Get the draw color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowCommentDrawColor(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowCommentDrawColor");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    return item.__getDrawColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowCommentDrawColor
    @description Check the draw color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowCommentDrawColor(control, text, color) {
  return GetWorkflowCommentDrawColor(control, text) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentDrawColor
    @description Verify the draw color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowCommentDrawColor(control, text, color) {
  if (IsWorkflowCommentDrawColor(control, text, color)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' HAS draw color '" + color + "'");
  } else {
    Log.Error("The workflow comment '" + item.__getText() + "' HAS NOT draw color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowCommentForeColor
    @description Get the fore color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowCommentForeColor(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowCommentForeColor");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    return item.__getForeColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowCommentForeColor
    @description Check the fore color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowCommentForeColor(control, text, color) {
  return GetWorkflowCommentForeColor(control, text) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentForeColor
    @description Verify the fore color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowCommentForeColor(control, text, color) {
  if (IsWorkflowCommentForeColor(control, text, color)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' HAS fore color '" + color + "'");
  } else {
    Log.Error("The workflow comment '" + item.__getText() + "' HAS NOT fore color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.GetWorkflowCommentGradientColor
    @description Get the gradient color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @returns {String} The color in RGB hex format (e.g. "0xRRGGBB")
*/
function GetWorkflowCommentGradientColor(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.GetWorkflowCommentGradientColor");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    return item.__getGradientColor();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowCommentGradientColor
    @description Check the gradient color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
    @returns {Boolean} True if colors match, otherwise False
*/
function IsWorkflowCommentGradientColor(control, text, color) {
  return GetWorkflowCommentGradientColor(control, text) === color;
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentGradientColor
    @description Verify the gradient color of the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {String} color The color in RGB hex format (e.g. "0xRRGGBB")
*/
function VerifyWorkflowCommentGradientColor(control, text, color) {
  if (IsWorkflowCommentGradientColor(control, text, color)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' HAS gradient color '" + color + "'");
  } else {
    Log.Error("The workflow comment '" + item.__getText() + "' HAS NOT gradient color '" + color + "'");
  }
}

/** @function
    @name Common_WorkflowEditor.IsWorkflowCommentHidden
    @description Check if the given workflow comment is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the workflow comment.
    @returns {Boolean} True if the comment is hidden, otherwise False.
*/
function IsWorkflowCommentHidden(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.IsWorkflowCommentHidden");
    item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    return item.__isHidden();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.VerifyWorkflowCommentHidden
    @description Verify if the given workflow comment is hidden.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
*/
function VerifyWorkflowCommentHidden(control, text) {
  if (IsWorkflowCommentHidden(control, text)) {
    Log.Checkpoint("The workflow comment '" + item.__getText() + "' IS hidden");
  } else {
    Log.Error("The workflow comment '" + item.__getText() + "' IS NOT hidden");
  }
}

/** @function
    @name Common_WorkflowEditor.HoverMouseWorkflowComment
    @description Hover over the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
*/
function HoverMouseWorkflowComment(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.HoverMouseWorkflowComment");
    var item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    item.__hover();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.ClickWorkflowComment
    @description Click the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
*/
function ClickWorkflowComment(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.ClickWorkflowComment");
    var item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    item.__click();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DblClickWorkflowComment
    @description Double click the given workflow comment.
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
*/
function DblClickWorkflowComment(control, text) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DblClickWorkflowComment");
    var item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    item.__dblClick();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    @name Common_WorkflowEditor.DragWorkflowCommentToPoint
    @description Drag the workflow comment to the WorkflowEditor canvas at specific point (x, y)
    @param {Object} control The native TestComplete object of the workflow editor
    @param {String} text The text of the comment
    @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)
    @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
*/
function DragWorkflowCommentToPoint(control, text, x, y) {
  try {
    Log.AppendFolder("Common_WorkflowEditor.DragWorkflowCommentToPoint");
    var item = Private_WorkflowEditor.initWrapper(control).findCommentByText(text);
    if (!item) {
      Log.Error("The workflow comment '" + text + "' DOES NOT exist.");
    }
    item.__dragToPoint(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + (e.message || e));
    return;
  } finally {
    Log.PopLogFolder();
  }
}