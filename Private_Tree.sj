//USEUNIT Common_CheckBox
/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new Tree(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}
/* Object Model ***********************************************************************************/
/** @class "Tree" object model
    
    @description Represents a tree.
    
    @param {Object} control TestComplete's object containing a tree.
*/
Tree = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name Tree.findNode
      
      @description Retrieve a node by its name.
      
      @param {String} name Name of the node to search for.
  */
  this.findNode = function (path) {
    var f = function (cc, pp) {
      var a = cc.__getNodes(), p = pp.shift(), e = null, i;
      for (i = 0; i < a.length; i++) { if (a[i].__getName() === p) { e = a[i]; break; } }
      if (e === null) { return null; }
      if (pp.length === 0) { return e; }
      e.__expand();
      return f(e, pp);
    };
    return f(this, path.indexOf("|") >= 0 ? path.split("|") : [path]);
  };
  /** @function
      
      @name Tree.isEnabled
      
      @description Check whether a tree is enabled.
      
      @param {boolean} Tree is enabled.
  */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function
      
      @name Tree.isVisible
      
      @description Check whether a tree is visible.
      
      @param {boolean} Tree is visible.
  */
  this.isVisible = function () {
    return this.__isVisible();
  };
  /** @function
      
      @name TreeNode.getNodes
      
      @description Get nodes.
      
      @param {Array} Nodes.
  */
  this.getNodes = function () {
    return this.__getNodes();
  };
  return this;
};
/** @class "TreeNode" object model
    
    @description Represents a tree node.
    
    @param {Object} control TestComplete's object containing a tree node.
    
    @param {Integer} index Treenode index (as appears on screen).
*/
TreeNode = function (control, index, Parent) {


  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @field
      
      @description Stores control Parent for which this object model is created.
  */
  this.Parent = Parent;
  /** @field
      
      @description Stores control index for which this object model is created.
  */
  this.index = index;
  /** @function
      
      @name TreeNode.getName
      
      @description Get the name of a tree node
  */
  this.getName = function () {
    this.__getName();
  };
  /** @function
      
      @name TreeNode.click
      
      @description Click on a tree node item.
  */
  this.click = function () {
    this.__click();
  };

  /** @function
      
      @name TreeNode.clickR
      
      @description Right click on a tree node item.
  */
  this.clickR = function () {
    this.__clickR();
  };
  /** @function
      
      @name TreeNode.isEnabled
      
      @description Check whether a tree node is enabled.
      
      @param {boolean} Tree node is enabled.
  */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function
      
      @name TreeNode.isSelected
      
      @description Check whether a tree node is selected.
      
      @param {boolean} Tree node is selected.
  */
  this.isSelected = function () {
    return this.__isSelected();
  };
  /** @function
      
      @name TreeNode.isVisible
      
      @description Check whether a tree node item is visible.
      
      @param {boolean} Tree node is visible.
  */
  this.isVisible = function () {
    return this.__isVisible();
  };
  /** @function
      
      @name TreeNode.expand
      
      @description Expand a tree node.
      
  */
  this.expand = function () {
    return this.__expand();
  };
  /** @function
      
      @name TreeNode.collapse
      
      @description Collapse a tree node.
      
  */
  this.collapse = function () {
    return this.__collapse();
  };
  /** @function
      
      @name TreeNode.getNodes
      
      @description Get nodes.
      
      @param {Array} Nodes.
  */
  this.getNodes = function () {
    return this.__getNodes();
  };
};
/* Object Bindings ********************************************************************************/
/** @function
    
    @name Tree.__initialize
    
    @description Initialize control passed to "Tree" object.
    
    @param {Object} control TestComplete's object containing a tree.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
Tree.prototype.__initialize = function (control) {
  var bindings = [],
    i;
  if (aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "dvMenuTree") {
    bindings.push(__binding.tree_menu);
  } else if ((aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "divTreeMain")
    || (aqObject.IsSupported(control, "className") && (control.className === "ob_tree" || control.className === "ob_treeCASP"))){
    bindings.push(__binding.tree_main);
  } else if (aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "frmTimeTamplate") {
    bindings.push(__binding.tree_accordion);
  } else if ((aqObject.IsSupported(control, "WndClass") && control.WndClass === "WindowsForms10.SysTreeView32.app.0.1a8c1fa_r11_ad1")
    || (aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "Object_Explorer_Hierarchy")) {
    bindings.push(__binding.tree_desktop);
  } else if (aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "divBodyLeft0") {
    bindings.push(__binding.tree_users);
  } 
  if (bindings.length === 0) {
    throw "Runtime Object validation failed";
  }
  for (i = 0; i < bindings.length; i++) {
    bindings[i]();
  }
  return control;
};
/** @function
    
    @name TreeNode.__initialize
    
    @description Initialize control passed to "TreeNode" object.
    
    @param {Object} control TestComplete's object containing a tabs.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
TreeNode.prototype.__initialize = function (control) {
  return control;
};
/** @description "Tree" object bindings for Main tree. */
__binding.tree_menu = function () {
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  Tree.prototype.__getNodes = function () {
    var res = [],
      i;
    for (i = 0; i < this.control.ChildCount; i++) {
      res.push(new TreeNode(this.control.Child(i), i, this.control));
    }
    return res;
  };
  /** @function
      
      @name Tree.__isVisible
      
      @description Check whether a Tree is visible.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name Tree.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__getName
      
      @description Retreive TreeNode's name (caption), if any.
      
      @returns {String} TreeNode's name.
  */
  TreeNode.prototype.__getName = function () {
    if (this.control.ChildCount === 1 || this.control.ChildCount === 0) {
      return this.control.contentText;
    }
    return this.control.Child(1).contentText;
  };
  /** @function
      
      @name TreeNode.__isVisible
      
      @description Check whether a TreeNode is visible.
      
      @returns {boolean} TreeNode's is visible.
  */
  TreeNode.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name TreeNode.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @returns {boolean} TreeNode is enabled.
  */
  TreeNode.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__click
      
      @description Click on a TreeNode.
  */
  TreeNode.prototype.__click = function () {
    this.control.Click();
  };

  /** @function
      
      @name TreeNode.__clickR
      
      @description ClickR on a TreeNode.
  */
  TreeNode.prototype.__clickR = function () {
    this.control.ClickR();
  };
  /** @function
      
      @name TreeNode.__expand
      
      @description Expand a TreeNode.
  */
  TreeNode.prototype.__expand = function () {
    aqUtils.Delay(1000);
    if (this.control.ChildCount === 1 || this.control.Child(0).Visible) {
      return false;
    }
    this.control.click(10, 10);
    return true;
  };
  /** @function
      
      @name TreeNode.__collapse
      
      @description Collapse a TreeNode.
  */
  TreeNode.prototype.__collapse = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (this.control.ChildCount === 1 || !this.control.Child(0).Visible) {
      return false;
    }
    this.control.click(10, 10);
    return true;
  };
  /** @function
      
      @name TreeNode.__isSelected
      
      @description Check whether a TreeNode is selected
      
      @returns {boolean} TreeNode is selected.
  */
  TreeNode.prototype.__isSelected = function () {
    if (this.control.ChildCount === 1) {
      return this.control.Child(0).Child(0).Child(0).className === "TopMnuSelTd" || this.control.Child(0).Child(0).Child(0).className === "SubMnuSelText";
    }
    return this.control.Child(1).Child(0).Child(0).className === "TopMnuSelTd" || this.control.Child(1).Child(0).Child(0).className === "SubMnuSelText";
  };

    /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  TreeNode.prototype.__getNodes = function () {
    var res = [], i;
    for (i = 0; i < this.control.Child(0).ChildCount; i++) {
      res.push(new TreeNode(this.control.Child(0).Child(i), i, this.control));
    }
    return res;
  };
};
/** @description "Tree" object bindings for Main tree. */
__binding.tree_main = function () {
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  Tree.prototype.__getNodes = function () {
    var res = [], i, Nodes = [];
    Nodes = this.control.FindAllChildren("ObjectType", "Cell", 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 0; i < Nodes.length; i++) {
      if (Nodes[i].contentText.length > 0 && aqString.Find(Nodes[i].contentText, "...") === -1) {
        res.push(new TreeNode(Nodes[i], i, this.control));
      }
    }
    return res;
  };
  /** @function
      
      @name Tree.__isVisible
      
      @description Check whether a Tree is visible.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name Tree.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__getName
      
      @description Retreive TreeNode's name (caption), if any.
      
      @returns {String} TreeNode's name.
  */
  TreeNode.prototype.__getName = function () {
    return this.control.contentText;
  };
  /** @function
      
      @name TreeNode.__isVisible
      
      @description Check whether a TreeNode is visible.
      
      @returns {boolean} TreeNode's is visible.
  */
  TreeNode.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name TreeNode.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @returns {boolean} TreeNode is enabled.
  */
  TreeNode.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__click
      
      @description Click on a TreeNode.
  */
  TreeNode.prototype.__click = function () {
    this.control.Click();
  };

  /** @function
      
      @name TreeNode.__clickR
      
      @description ClickR on a TreeNode.
  */
  TreeNode.prototype.__clickR = function () {
    this.control.ClickR();
  };
  /** @function
      
      @name TreeNode.__expand
      
      @description Expand a TreeNode.
  */
  TreeNode.prototype.__expand = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (this.control.Parent.Parent.Child(0).Visible !== true) {
      this.control.Parent.Child(2).click();
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__collapse
      
      @description Collapse a TreeNode.
  */
  TreeNode.prototype.__collapse = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (this.control.Parent.Parent.Child(0).Visible === true) {
      this.control.Parent.Child(2).click();
      return true;
    }
    Log.Error("Cannot collapse this node");
    return false;
  };
  /** @function
      
      @name TreeNode.__getNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  TreeNode.prototype.__getNodes = function () {
    var res = [], i, Nodes = [];
    Delay(1500);
    this.Parent.Refresh();
    Nodes = this.control.Parent.Parent.FindAllChildren("ObjectType", "Cell", 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 0; i < Nodes.length; i++) {
      if (Nodes[i].contentText.length > 0) {
        res.push(new TreeNode(Nodes[i], i, this.control));
      }
    }
    return res;
  };
  /** @function
      
      @name TreeNode.__setState
      
      @description Set checkbox state.
      @param {Boolean} - Checkbox value true/false - checked/unchecked
  */
  TreeNode.prototype.__setState = function (value) {
    var checkbox;
    checkbox = this.control.FindChild("ObjectType", "Checkbox", 3);
    if (!checkbox.Exists) {
      throw "Checkbox not found";
    }
    Common_CheckBox.SetValue(checkbox, value);
  };
  
   /** @function
      
      @name TreeNode.__getState
      
      @description Get checkbox state.
      @returns {boolean} Checkbox value true/false - checked/unchecked.
  */
  TreeNode.prototype.__getState = function () {
    var checkbox;
    checkbox = this.control.FindChild("ObjectType", "Checkbox", 3);
    if (!checkbox.Exists) {
      throw "Checkbox not found";
    }
    return checkbox.status;
  };
};
/** @description "Tree" object bindings for Main tree. */
__binding.tree_accordion = function () {
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  Tree.prototype.__getNodes = function () {
    var res = [], i, Nodes = [];
    Nodes = this.control.FindAllChildren("className", "exp_cont expanded", 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 0; i < Nodes.length; i++) {
      res.push(new TreeNode(Nodes[i], i, this.control));
    }
    Nodes = this.control.FindAllChildren("className", "exp_cont", 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 0; i < Nodes.length; i++) {
      res.push(new TreeNode(Nodes[i], i, this.control));
    }
    return res;
  };
  /** @function
      
      @name Tree.__isVisible
      
      @description Check whether a Tree is visible.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name Tree.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__getName
      
      @description Retreive TreeNode's name (caption), if any.
      
      @returns {String} TreeNode's name.
  */
  TreeNode.prototype.__getName = function () {
    return aqString.Trim(aqString.SubString(this.control.contentText, 3, this.control.contentText.length - 2));
  };
  /** @function
      
      @name TreeNode.__isVisible
      
      @description Check whether a TreeNode is visible.
      
      @returns {boolean} TreeNode's is visible.
  */
  TreeNode.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name TreeNode.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @returns {boolean} TreeNode is enabled.
  */
  TreeNode.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__click
      
      @description Click on a TreeNode.
  */
  TreeNode.prototype.__click = function () {
    this.control.Click();
  };

  /** @function
      
      @name TreeNode.__clickR
      
      @description Right Click on a TreeNode.
  */
  TreeNode.prototype.__clickR = function () {
    this.control.ClickR();
  };

  /** @function
      
      @name TreeNode.__expand
      
      @description Expand a TreeNode.
  */
  TreeNode.prototype.__expand = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (this.control.className !== "exp_cont") {
      this.control.click(10, 10);
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__collapse
      
      @description Collapse a TreeNode.
  */
  TreeNode.prototype.__collapse = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (this.control.className === "exp_cont") {
      this.control.click(10, 10);
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__isSelected
      
      @description Check whether a TreeNode is selected
      
      @returns {boolean} TreeNode is selected.
  */
  TreeNode.prototype.__isSelected = function () {
    return this.control.className === "exp_cont";
  };
};
/** @description "Tree" object bindings for Main tree. */
__binding.tree_desktop = function () {
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  Tree.prototype.__getNodes = function () {
    var res = [],
      i;
    for (i = 0; i < this.control.wItems.Count; i++) {
      res.push(new TreeNode(this.control.wItems.Item(i), i, this.control));
    }
    return res;
  };
  /** @function
      
      @name Tree.__isVisible
      
      @description Check whether a Tree is visible.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name Tree.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__getName
      
      @description Retreive TreeNode's name (caption), if any.
      
      @returns {String} TreeNode's name.
  */
  TreeNode.prototype.__getName = function () {
    return this.control.Text;
  };
  /** @function
      
      @name TreeNode.__isVisible
      
      @description Check whether a TreeNode is visible.
      
      @returns {boolean} TreeNode's is visible.
  */
  TreeNode.prototype.__isVisible = function () {
    return this.Parent.Visible;
  };
  /** @function
      
      @name TreeNode.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @returns {boolean} TreeNode is enabled.
  */
  TreeNode.prototype.__isEnabled = function () {
    return this.Parent.Enabled;
  };
  /** @function
      
      @name TreeNode.__click
      
      @description Click on a TreeNode.
  */
  TreeNode.prototype.__click = function () {
    this.control.Click();
  };

  /** @function
      
      @name TreeNode.__clickR
      
      @description ClickR on a TreeNode.
  */
  TreeNode.prototype.__clickR = function () {
    this.control.ClickR();
  };
  /** @function
      
      @name TreeNode.__expand
      
      @description Expand a TreeNode.
  */
  TreeNode.prototype.__expand = function () {
    if (this.control.Expanded !== true) {
      this.control.Expand();
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__collapse
      
      @description Collapse a TreeNode.
  */
  TreeNode.prototype.__collapse = function () {
    if (this.control.Expanded === true) {
      this.control.Collapse();
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__isSelected
      
      @description Check whether a TreeNode is selected
      
      @returns {boolean} TreeNode is selected.
  */
  TreeNode.prototype.__isSelected = function () {
    return this.control.Selected;
  };
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  TreeNode.prototype.__getNodes = function () {
    var res = [],
      i;
    for (i = 0; i < this.control.Items.Count; i++) {
      res.push(new TreeNode(this.control.Items.Item(i), i, this.control));
    }
    return res;
  };
};

/** @description "Tree" object bindings for Main tree. */
__binding.tree_users = function () {
  /** @function
      
      @name Tree.__getTreeNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  Tree.prototype.__getNodes = function () {
    var res = [], i, Nodes = [];
    Nodes = this.control.FindAllChildren("ObjectType", "Cell", 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 1; i < Nodes.length; i++) {
      if (Nodes[i].contentText.length > 0 && Nodes[i].contentText === Nodes[i - 1].contentText) {
        res.push(new TreeNode(Nodes[i], i, this.control));
      }
    }
    return res;
  };
  /** @function
      
      @name Tree.__isVisible
      
      @description Check whether a Tree is visible.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name Tree.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @return {boolean} Tree is visible.
  */
  Tree.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__getName
      
      @description Retreive TreeNode's name (caption), if any.
      
      @returns {String} TreeNode's name.
  */
  TreeNode.prototype.__getName = function () {
    return this.control.contentText;
  };
  /** @function
      
      @name TreeNode.__isVisible
      
      @description Check whether a TreeNode is visible.
      
      @returns {boolean} TreeNode's is visible.
  */
  TreeNode.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name TreeNode.__isEnabled
      
      @description Check whether a TreeNode is enabled.
      
      @returns {boolean} TreeNode is enabled.
  */
  TreeNode.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name TreeNode.__click
      
      @description Click on a TreeNode.
  */
  TreeNode.prototype.__click = function () {
    this.control.Click();
  };

  /** @function
      
      @name TreeNode.__clickR
      
      @description ClickR on a TreeNode.
  */
  TreeNode.prototype.__clickR = function () {
    this.control.ClickR();
  };
  /** @function
      
      @name TreeNode.__expand
      
      @description Expand a TreeNode.
  */
  TreeNode.prototype.__expand = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (aqString.Find(this.control.Child(2).className, "expand") !== -1) {
      this.control.Child(2).Click();
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__collapse
      
      @description Collapse a TreeNode.
  */
  TreeNode.prototype.__collapse = function () {
    aqUtils.Delay(1000);
    this.control.Refresh();
    if (aqString.Find(this.control.Child(2).className, "collapse") !== -1) {
      this.control.Child(2).Click();
      return true;
    }
    return false;
  };
  /** @function
      
      @name TreeNode.__getNodes
      
      @description Retrieve TreeNodes contained in a Tree.
      
      @returns {Array} Array of TreeNodes.
  */
  TreeNode.prototype.__getNodes = function () {
    var res = [], i, Nodes = [];
    Nodes = this.control.Parent.FindAllChildren("columnIndex", 0, 10);
    Nodes = (new VBArray(Nodes)).toArray();
    for (i = 0; i < Nodes.length; i++) {
      if (Nodes[i].Top < 1000) {
        res.push(new TreeNode(Nodes[i]));
      }
    }
    return res;
  };
};