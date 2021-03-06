//USEUNIT Private_Tree
/**
 * @function Void ClickTreeNode(TreeObj, TreeNode)
 * @name Common_Tree.TreeNodeSelected
 * @description Clicks a tree Node.
 * @param {TreeObj} - Object of a grid/tree.
 * @param {TreeNode} -  The Tree Node that the Tester want to Verify
 */
function ClickTreeNode(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.ClickTreeNode");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree Node \"" + Node + "\" not found.");
    }
    t.click();
    Log.Message("Node " + Node + " was clicked");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * @function Void ClickRTreeNode(TreeObj, TreeNode)
 * @name Common_Tree.ClickRTreeNode
 * @description Right clicks a tree Node.
 * @param {TreeObj} - Object of a grid/tree.
 * @param {TreeNode} -  The Tree Node that the Tester want to right click
 */
function ClickRTreeNode(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.ClickRTreeNode");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree Node \"" + Node + "\" not found.");
    }
    t.clickR();
    Log.Message("Node " + Node + " was clicked");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function Bool TreeNodeSelected(TreeObj, Node)
 * @name Common_Tree.TreeNodeSelected
 * @description Check is a Tree Node selected.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node -  Name of the Tree Node to check.
 * @returns {boolean} Tree Node is selected.
 */
function TreeNodeSelected(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.TreeNodeSelected");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree \"" + Node + "\" not found.");
    }
    return t.isSelected();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function Void ExpandTreeNode(TreeObj, Node)
 * @name Common_Tree.ExpandTreeNode
 * @description Expand a tree Node.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to expand.
 */
function ExpandTreeNode(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.ExpandTreeNode");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree \"" + Node + "\" not found.");
    }
    if (!t.expand()) {
      Log.Error("Tree Node \"" + Node + "\" is already expanded or it is not expandable");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function Void CollapseTreeNode(TreeObj, Node)
 * @name Common_Tree.CollapseTreeNode
 * @description Collapse a tree Node.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to collapse.
 */
function CollapseTreeNode(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.CollapseTreeNode");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree \"" + Node + "\" not found.");
    }
    if (!t.collapse()) {
      Log.Error("Tree Node \"" + Node + "\" is already collapsed or it is not collapsable");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** 
 * @function Void VerifyTreeNodeSelected(TreeObj, Node)
 * @name Common_Tree.VerifyTreeNodeSelected
 * @description Check is a Tree Node selected. Write a log message.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 */
function VerifyTreeNodeSelected(TreeObj, Node) {
  if (TreeNodeSelected(TreeObj, Node)) {
    Log.Checkpoint("The Tree Node with name '" + Node + "' is selected.");
  } else {
    Log.Error("The Tree Node with name '" + Node + "' is not selected.");
  }
}
/**
 * @function Boolean TreeNodeEnabled(TreeObj, Node)
 * @name Common_Tree.TreeNodeEnabled
 * @description Check is a Tree Node enabled.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 * @returns {boolean} Tree Node is enabled.
 */
function TreeNodeEnabled(TreeObj, Node) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.TreeNodeEnabled");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree \"" + Node + "\" not found.");
    }
    return t.isEnabled();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * @function Boolean TreeEnabled(TreeObj)
 * @name Common_Tree.TreeEnabled
 * @description Check is a Tree panel enabled.
 * @param {Object} TreeObj - TestComplete's object containing a Tree
 * @returns {boolean} Tree is Visible
 */
function TreeEnabled(TreeObj) {
  try {
    Log.AppendFolder("Common_Tree.TreeEnabled");
    return Private_Tree.initWrapper(TreeObj).isEnabled();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * @function VerifyTreeNodeEnabled(TreeObj, Node)
 * @name Common_Tree.VerifyTreeNodeEnabled
 * @description Check is a Tree Node enabled. Write a log message.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 */
function VerifyTreeNodeEnabled(TreeObj, Node) {
  if (TreeNodeEnabled(TreeObj, Node)) {
    Log.Checkpoint("The Tree Node with name '" + Node + "' is enabled.");
  } else {
    Log.Error("The Tree Node with name '" + Node + "' is not enabled.");
  }
}
/**
 * @function Void VerifyTreeEnabled(TreeObj)
 * @name Common_Tree.VerifyTreeEnabled
 * @description Check if a Tree panel enabled.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 */
function VerifyTreeEnabled(TreeObj) {
  if (TreeEnabled(TreeObj)) {
    Log.Checkpoint("The Tree is enabled.");
  } else {
    Log.Error("The Tree is not enabled.");
  }
}
/** 
 * @function Boolean TreeNodeVisible(TreeObj, Node)
 * @name Common_Tree.TreeNodeVisible
 * @description Check whether Tree Node is visible.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 * @return {boolean} Tree Node is visible.
 */
function TreeNodeVisible(TreeObj, Node) {
  try {
    Log.AppendFolder("Common_Tree.TreeNodeVisible");
    var t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree Node \"" + Node + "\" not found.");
    }
    return t.isVisible();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** 
 * @function Boolean TreeVisible(TreeObj)
 * @name Common_Tree.TreeVisible
 * @description Check whether Tree panel is visible.
 * @param {Object} TreeObj -  TestComplete's object containing a Tree.
 * @returns {boolean} Tree Panel is visible.
 */
function TreeVisible(TreeObj) {
  try {
    Log.AppendFolder("Common_Tree.TreeVisible");
    return Private_Tree.initWrapper(TreeObj).isVisible();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * @function Void VerifyTreeVisible(TreeObj, Node)
 * @name Common_Tree.VerifyTreeVisible
 * @description Check whether a Tree panel is visible. Write a log message.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 */
function VerifyTreeVisible(TreeObj) {
  if (TreeVisible(TreeObj)) {
    Log.Checkpoint("The Tree is visible.");
  } else {
    Log.Error("The Tree is not visible.");
  }
}
/** 
 * @function Void VerifyTreeNodeVisible(TreeObj, Node)
 * @name Common_Tree.VerifyTreeNodeVisible
 * @description Check whether a Tree Node is visible. Write a log message.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 */
function VerifyTreeNodeVisible(TreeObj, Node) {
  if (TreeNodeVisible(TreeObj, Node)) {
    Log.Checkpoint("The Tree Node with name '" + Node + "' is visible.");
  } else {
    Log.Error("The Tree Node with name '" + Node + "' is not visible.");
  }
}
/**
 * @function Boolean TreeNodeExists(TreeObj, Node)
 * @name Common_Tree.TreeNodeExists
 * @description Check is a Tree Node exists.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 * @returns {boolean} Tree Node is exist.
 */
function TreeNodeExists(TreeObj, Node) {
  try {
    Log.AppendFolder("Common_Tree.TreeNodeExists");
    return Private_Tree.initWrapper(TreeObj).findNode(Node) !== null;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** 
 * @function Void VerifyTreeNodeExists(TreeObj, Node)
 * @name Common_Tree.VerifyTreeNodeExists
 * @description Check is a Tree Node exists. Write a log message.
 * @param {Object} TreeObj - TestComplete's object containing a Tree.
 * @param {String} Node - Name of the Tree Node to check.
 */
function VerifyTreeNodeExists(TreeObj, Node) {
  if (TreeNodeExists(TreeObj, Node)) {
    Log.Checkpoint("The Tree Node with name '" + Node + "' exists under the Tree Object");
  } else {
    Log.Error("The Tree Node with name '" + Node + "' does not exist under the Tree Object");
  }
}

/**
 * @function Void SetTreeNodeCheckboxState(TreeObj, TreeNode, State)
 * @description Set tree node checkbox state .
 * @param {TreeObj} - Object of a grid/tree.
 * @param {TreeNode} -  The Tree Node that the Tester want to Verify.
 * @param {Boolean} - Checkbox value true/false - checked/unchecked.
 */
function SetTreeNodeCheckboxState(TreeObj, Node, State) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.SetTreeNodeCheckboxState");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree Node \"" + Node + "\" not found.");
    }
    t.__setState(State);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * @function Void TreeNodeCheckboxState(TreeObj, TreeNode, State)
 * @description Verify tree node checkbox state.
 * @param {TreeObj} - Object of a grid/tree.
 * @param {TreeNode} -  The Tree Node that the Tester want to Verify
 * @param {Boolean} - Checkbox value true/false - checked/unchecked
 * @returns {boolean} - Tree Node checkbox state equal provided state.
 */
function TreeNodeCheckboxState(TreeObj, Node, State) {
  var t;
  try {
    Log.AppendFolder("Common_Tree.SetTreeNodeCheckboxState");
    t = Private_Tree.initWrapper(TreeObj).findNode(Node);
    if (t === null) {
      Log.Error("Tree Node \"" + Node + "\" not found.");
    }
    return t.__getState() === State;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * @function Void VerifyTreeNodeCheckboxState(TreeObj, TreeNode, State)
 * @description Verify tree node checkbox state. Log message.
 * @param {TreeObj} - Object of a grid/tree.
 * @param {TreeNode} -  The Tree Node that the Tester want to Verify
 * @param {Boolean} - Checkbox value true/false - checked/unchecked
 */
 function VerifyTreeNodeCheckboxState(TreeObj, Node, State) {
  if (TreeNodeCheckboxState(TreeObj, Node, State)) {
    Log.Checkpoint("The Tree Node with name '" + Node + "' checkbox is '" + (State ? "checked" : "not checked") + "'");
  } else {
    Log.Error("The Tree Node with name '" + Node + "' checkbox is NOT '" + (State ? "checked" : "not checked") + "'");
  }
}