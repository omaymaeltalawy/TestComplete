//USEUNIT Private_Utils
/** @ignore @description Control binding */
var __binding = {};

var WorkflowEditor, WorkflowToolBarItem, WorkflowState, WorkflowTransition, WorkflowComment;

/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new WorkflowEditor(control);
    __wrapper.__initWorkflowEditor();
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}

/* Object Model ***********************************************************************************/

/** @class "WorkflowEditor" object model

@description Represents a WorkflowEditor.

@param {Object} control TestComplete's object containing a WorkflowEditor.
*/
WorkflowEditor = function (control) {
  /** @field

  @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);

  /** @function

  @name WorkflowEditor.findToolBarItem

  @description Find a WorkflowEditor toolbar item by its path (Text or ToolTip).

  @param {String} path The path of the WorkflowEditor toolbar item (Text or ToolTip).

  @returns {Object} WorkflowEditor toolbar item found.
  */
  this.findToolBarItem = function (path) {
    var f = function (cc, pp) {
      var a = cc.__getToolBarItems(),
        p = pp.shift(),
        e = null,
        i;
      for (i = 0; i < a.length; i++) {
        Log.Message(a[i].__getName());
        if (aqString.Compare(a[i].__getName(), p, false) === 0) {
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
    return f(this, path.split("|"));
  };

  /** @function

  @name WorkflowEditor.findStateByName

  @description Find a workflow state by its name.

  @param {String} name The name of the workflow state.

  @returns {Object} Workflow state found.
  */
  this.findStateByName = function (name) {
    var states, i, result;

    states = this.__getStates();
    for (i = 0; i < states.length; i++) {
      if (Private_Utils.StringMatches(states[i].__getName(), name)) {
        result = states[i];
        break;
      }
    }

    return result;
  };

  /** @function

  @name WorkflowEditor.findTransitionByName

  @description Find a workflow transition by its name.

  @param {String} name The name of the workflow transition.

  @returns {Object} Workflow transition found.
  */
  this.findTransitionByName = function (name) {
    var transitions, i, result;

    transitions = this.__getTransitions();
    for (i = 0; i < transitions.length; i++) {
      if (Private_Utils.StringMatches(transitions[i].__getName(), name)) {
        result = transitions[i];
        break;
      }
    }

    return result;
  };

  /** @function

  @name WorkflowEditor.findCommentByText

  @description Find a workflow comment by its text.

  @param {String} text The workflow comment text.

  @returns {Object} Workflow comment found.
  */
  this.findCommentByText = function (text) {
    var comments, i, result;

    comments = this.__getComments();
    for (i = 0; i < comments.length; i++) {
      if (Private_Utils.StringMatches(comments[i].__getText(), text)) {
        result = comments[i];
        break;
      }
    }

    return result;
  };
};

/** @class "WorkflowToolBarItem" object model

@description Represents a workflow toolbar item.

@param {Object} control TestComplete's object containing a WorkflowEditor.

@param {Integer} index The index of the item in the toolbar
*/
WorkflowToolBarItem = function (control, index) {
  /** @field

     @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);

  /** @field

     @description Stores toolbar's index (as appears on screen).
  */
  this.index = index || 0;
};

/** @class "WorkflowState" object model

@description Represents a workflow state item.

@param {Object} control TestComplete's object containing a WorkflowEditor.

@param {Integer} index The index of the item
*/
WorkflowState = function (control, index) {
  /** @field

     @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);

  /** @field

     @description Stores toolbar's index (as appears on screen).
  */
  this.index = index || 0;
};

/** @class "WorkflowTransition" object model

@description Represents a workflow transition item.

@param {Object} control TestComplete's object containing a WorkflowEditor.

@param {Integer} index The index of the item
*/
WorkflowTransition = function (control, index) {
  /** @field

     @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);

  /** @field

     @description Stores toolbar's index (as appears on screen).
  */
  this.index = index || 0;
};

/** @class "WorkflowComment" object model

@description Represents a workflow comment item.

@param {Object} control TestComplete's object containing a WorkflowEditor.

@param {Integer} index The index of the item
*/
WorkflowComment = function (control, index) {
  /** @field

     @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);

  /** @field

     @description Stores toolbar's index (as appears on screen).
  */
  this.index = index || 0;
};

/* Object Bindings ********************************************************************************/

/** @function

    @name WorkflowEditor.__initialize

    @description Initialize control passed to "WorkflowEditor" object.

    @param {Object} control TestComplete's object containing a WorkflowEditor.

    @returns {Object} Same control if it passes initialization.

    @throws Runtime Object initialization failed.
*/
WorkflowEditor.prototype.__initialize = function (control) {
  var b = [],
    i;

  b.push(__binding.workfloweditor_default);

  if (aqObject.IsSupported(control, "ObjectType") && control.ObjectType === "Object" &&
      aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "clsUpload" &&
      aqObject.IsSupported(control, "WndClass") && control.WndClass === "ThunderRT6UserControlDC" &&
      aqObject.IsSupported(control, "ownerDocument") && control.ownerDocument) {
    b.push(__binding.workfloweditor_tenrox);
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

    @name WorkflowToolBarItem.__initialize

    @description Initialize control passed to "WorkflowToolBarItem" object.

    @param {Object} control TestComplete's object containing a WorkflowToolBarItem.

    @returns {Object} Same control if it passes initialization.

    @throws Runtime Object initialization failed.
*/
WorkflowToolBarItem.prototype.__initialize = function (control) {
  return control;
};

/** @function

    @name WorkflowState.__initialize

    @description Initialize control passed to "WorkflowState" object.

    @param {Object} control TestComplete's object containing a WorkflowState.

    @returns {Object} Same control if it passes initialization.

    @throws Runtime Object initialization failed.
*/
WorkflowState.prototype.__initialize = function (control) {
  return control;
};

/** @function

    @name WorkflowTransition.__initialize

    @description Initialize control passed to "WorkflowTransition" object.

    @param {Object} control TestComplete's object containing a WorkflowTransition.

    @returns {Object} Same control if it passes initialization.

    @throws Runtime Object initialization failed.
*/
WorkflowTransition.prototype.__initialize = function (control) {
  return control;
};

/** @function

    @name WorkflowComment.__initialize

    @description Initialize control passed to "WorkflowComment" object.

    @param {Object} control TestComplete's object containing a WorkflowComment.

    @returns {Object} Same control if it passes initialization.

    @throws Runtime Object initialization failed.
*/
WorkflowComment.prototype.__initialize = function (control) {
  return control;
};

/** @description "WorkflowEditor" default object bindings. */
__binding.workfloweditor_default = function (control) {
  /** @function

  @name WorkflowEditor.__initWorkflowEditor

  @description Initialize the WorkflowEditor
  */
  WorkflowEditor.prototype.__initWorkflowEditor = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };

  /** @function

  @name WorkflowEditor.__getToolBarItems

  @description Get all WorkflowEditor toolbar items.

  @returns {Array} WorkflowEditor toolbar items.
  */
  WorkflowEditor.prototype.__getToolBarItems = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };

  /** @function

  @name WorkflowEditor.__getStates

  @description Get all workflow states.

  @returns {Array} Workflow states.
  */
  WorkflowEditor.prototype.__getStates = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };

  /** @function

  @name WorkflowEditor.__getTransitions

  @description Get all workflow transitions.

  @returns {Array} Workflow transitions.
  */
  WorkflowEditor.prototype.__getTransitions = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };

  /** @function

  @name WorkflowEditor.__getComments

  @description Get all workflow comments.

  @returns {Array} Workflow comments.
  */
  WorkflowEditor.prototype.__getComments = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };

  /** @function

  @name WorkflowToolBarItem.__getToolBarItems

  @description Get all toolbar items for the given parent toolbar item.

  @returns {Array} WorkflowEditor toolbar items.
  */
  WorkflowToolBarItem.prototype.__getToolBarItems = function () {
    throw Private_Utils.COMMON_REPOSITORY.Exceptions.NotImplementedException();
  };
};

/** @description "WorkflowEditor" Tenrox object bindings. */
__binding.workfloweditor_tenrox = function (control) {
  var TWIPS_PER_PIXEL_X = Private_Utils.COMMON_REPOSITORY.WinAPI.TwipsPerPixelX(),
    TWIPS_PER_PIXEL_Y = Private_Utils.COMMON_REPOSITORY.WinAPI.TwipsPerPixelY(),
    TOOLBAR_ITEM_STYLE_DROPDOWN = 5,
    TOOLBAR_ITEM_DROPDOWN_ARROW_WIDTH = 14,
    VERTICAL_SCROLLBAR_WIDTH = 16,
    HORIZONTAL_SCROLLBAR_HEIGHT = 16;

  /** @field

  @description Stores toolbars of  the workflow editor cotrol.
  */
  WorkflowEditor.prototype.mToolBars = null;

  /** @field

  @description Stores the canvas area of the workflow editor cotrol.
  */
  WorkflowEditor.prototype.mCanvas = null;

  /** @function @ignore

  @name showDropDown

  @description Show the dropdown menu of the given toolbar item (if supported)

  @returns {Object} The TestComplete native object for the popup
  */
  function showDropDown() {
    if (!this.control.Parent && this.control.ToolBar.Buttons.Item(this.index).Style === TOOLBAR_ITEM_STYLE_DROPDOWN) {
      this.control.ToolBar.Click(this.control.Left + this.control.Width - TOOLBAR_ITEM_DROPDOWN_ARROW_WIDTH / 2,
        this.control.Top + this.control.Height / 2);

      return Private_Utils.GetProcess(this.control.WorkflowEditor.control).FindChild(["WndClass", "Visible"],
        ["#32768", true], 0, true);
    }

    return null;
  }

  /** @function @ignore

  @name getToolBarItemContainer

  @description Get the container for a toolbar item (used for mouse actions e.g Click())

  @returns {Object} The container for the toolbar item.
  */
  function getToolBarItemContainer() {
    return this.ToolBar;
  }

  /** @function @ignore

  @name getToolBarSubItemContainer

  @description Get the container for a toolbar subitem (used for mouse actions e.g Click())

  @returns {Object} The container for the toolbar subitem.
  */
  function getToolBarSubItemContainer() {
    return showDropDown.call(this);
  }

  /** @function

  @name WorkflowEditor.__initWorkflowEditor

  @description Initialize the WorkflowEditor
  */
  WorkflowEditor.prototype.__initWorkflowEditor = function () {
    var toolbars, toolbar, buttons, button, i, j, k, item, subItem, popup, popupWidth, popupHeight, buttonMenus, buttonMenu;

    // Initialize toolbars and their items
    this.mToolBars = [];
    toolbars = this.control.FindAllChildren(["WndClass"], ["msvb_lib_toolbar"], 4, true);
    toolbars = new VBArray(toolbars).toArray().reverse();

    for (i = 0; i < toolbars.length; i++) {
      toolbar = toolbars[i].Parent;
      buttons = toolbar.Buttons;
      this.mToolBars.push([]);
      for (j = 0; j < buttons.Count; j++) {
        // This array is 1-based
        button = buttons.Item(j + 1);
        if (button.Visible) {
          item = new WorkflowToolBarItem({
            WorkflowEditor: this,
            ToolBar: toolbar,
            Name: button.Caption || button.ToolTipText,
            Item: button,
            GetContainer: getToolBarItemContainer,
            Left: button.Left / TWIPS_PER_PIXEL_X,
            Top: button.Top / TWIPS_PER_PIXEL_Y,
            Width: button.Width / TWIPS_PER_PIXEL_X,
            Height: button.Height / TWIPS_PER_PIXEL_Y,
            Parent: null,
            SubItems: []
          }, button.Index);

          // If this is a dropdown button, handle its sub items
          if (button.Style === TOOLBAR_ITEM_STYLE_DROPDOWN) {
            // Calculate popup width and height
            popup = showDropDown.call(item);
            popupWidth = popup.Width;
            popupHeight = popup.Height;
            item.control.ToolBar.Keys("[Esc]");

            buttonMenus = button.ButtonMenus;
            for (k = 0; k < buttonMenus.Count; k++) {
              buttonMenu = buttonMenus.Item(k + 1);
              if (buttonMenu.Visible) {
                subItem = new WorkflowToolBarItem({
                  WorkflowEditor: item.control.WorkflowEditor,
                  ToolBar: item.control.ToolBar,
                  Name: buttonMenu.Text,
                  Item: buttonMenu,
                  GetContainer: getToolBarSubItemContainer,
                  Left: 0,
                  Top: 0,
                  Width: popupWidth,
                  Height: 0,
                  Parent: item,
                  SubItems: []
                }, buttonMenu.Index);

                item.control.SubItems.push(subItem);
              }
            }
            // Calculate top and height of subitems heuristically
            for (k = 0; k < item.control.SubItems.length; k++) {
              item.control.SubItems[k].control.Top = k * popupHeight / item.control.SubItems.length;
              item.control.SubItems[k].control.Height = popupHeight / item.control.SubItems.length;
            }
          }

          this.mToolBars[this.mToolBars.length - 1].push(item);
        }
      }
    }

    // Initialize the canvas area of the workflow editor
    this.mCanvas = this.control.FindChild(["WndClass", "Name"], ["AfxOleControl42u", "*ctrlTenroxWorkflow*"], 0, true);
  };

  /** @function

  @name WorkflowEditor.__getToolBarItems

  @description Get all WorkflowEditor toolbar items.

  @returns {Array} WorkflowEditor toolbar items.
  */
  WorkflowEditor.prototype.__getToolBarItems = function () {
    var items, i, j;

    items = [];
    for (i = 0; i < this.mToolBars.length; i++) {
      for (j = 0; j < this.mToolBars[i].length; j++) {
        items.push(this.mToolBars[i][j]);
      }
    }

    return items;
  };

  /** @function @ignore

  @name getXmlDocFromString

  @description Convert an xml string to an xml document

  @returns {Object} The xml document
  */
  function getXmlDocFromString(xml) {
    var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async = false;
    xmlDoc.loadXML(xml);
    xmlDoc.setProperty("SelectionLanguage", "XPath"); // Enable advanced xpath expressions
    return xmlDoc;
  }

  /** @function @ignore

  @name getWorkflowMap

  @description Convert WorkflowMapXMLString to an xml document

  @returns {Object} The xml document
  */
  function getWorkflowMap() {
    return getXmlDocFromString(this.control.WorkflowMapXMLString);
  }

  /** @function @ignore

  @name getXMLString

  @description Convert XMLString to an xml document

  @returns {Object} The xml document
  */
  function getXMLString() {
    return getXmlDocFromString(this.control.XMLString);
  }

  /** @function @ignore

  @name getSimpleObjectFromXmlNode

  @description Convert an xml node to an object using its attributes

  @returns {Object} The result object, or null if the xml node does not have any attributes
  */
  function getSimpleObjectFromXmlNode(node) {
    var result, attributes, i;

    attributes = node.selectNodes("@*");
    result = attributes.length ? {} : null;
    for (i = 0; i < attributes.length; i++) {
      result[attributes[i].name] = attributes[i].text;
    }

    return result;
  }

  /** @function @ignore

  @name getValidPropertyName

  @description Resolve collisions of an object property and return a safe name

  @param {Object} obj The object to resolve the property name against

  2param {String} property The property name to resolve

  @returns {String} The safe name of the property
  */
  function getValidPropertyName(obj, property) {
    var propertyName, suffix;

    suffix = 1;
    propertyName = property;
    while (obj[propertyName]) {
      propertyName += "_" + (++suffix);
    }
    if (obj[property]) {
      obj[property + "_1"] = obj[property];
      delete obj[property];
    }

    return propertyName;
  }

  /** @function @ignore

  @name getComplexObjectFromXmlNode

  @description Convert an xml node to an object using its attributes and sub nodes

  @returns {Object} The result object
  */
  function getComplexObjectFromXmlNode(node) {
    var result, nodes, j, simpleObject;

    result = {};

    simpleObject = getSimpleObjectFromXmlNode(node);
    if (simpleObject) {
      result[getValidPropertyName(result, node.nodeName)] = simpleObject;
    }

    nodes = node.selectNodes("*");
    for (j = 0; j < nodes.length; j++) {
      simpleObject = getSimpleObjectFromXmlNode(nodes[j]);

      if (simpleObject) {
        result[getValidPropertyName(result, nodes[j].nodeName)] = simpleObject;
      } else if (nodes[j].firstChild && nodes[j].firstChild.nodeTypeString !== "text" && nodes[j].firstChild.nodeTypeString !== "cdatasection") {
        result[getValidPropertyName(result, nodes[j].nodeName)] = getComplexObjectFromXmlNode(nodes[j]);
      } else {
        result[getValidPropertyName(result, nodes[j].nodeName)] = nodes[j].text;
      }
    }

    return result;
  }

  /** @function @ignore

  @name overrideDefaults

  @description Override default values stored as properties of an object with new values from another object
  */
  function overrideDefaults(defaults, values) {
    var key;

    for (key in values) {
      if (values.hasOwnProperty(key)) {
        if (Object.prototype.toString.call(values[key]) === "[object Object]" && defaults[key]) {
          overrideDefaults(defaults[key], values[key]);
        } else {
          defaults[key] = values[key];
        }
      }
    }
  }

  /** @function @ignore

  @name getWorkflowStateObject

  @description Construct a representation for a workflow state from its xml nodes

  @param {Object} workflowMapState The xml node for the state in WorkflowEditor.WorkflowMapXMLString.

  @param {Object} xmlStringDefault The xml node for default settings of the workflow state node in WorkflowEditor.XMLString

  @param {Object} xmlStringNode The xml node for the workflow state node in WorkflowEditor.XMLString

  @returns {Object} The workflow state representation object.
  */
  function getWorkflowStateObject(workflowMapState, xmlStringDefault, xmlStringNode) {
    var result;

    result = {};

    result.WorkflowEditor = this;

    result.WorkflowMapXMLString = getSimpleObjectFromXmlNode(workflowMapState);

    result.XMLString = getComplexObjectFromXmlNode(xmlStringDefault);
    xmlStringNode = getComplexObjectFromXmlNode(xmlStringNode);
    overrideDefaults(result.XMLString, xmlStringNode);

    return result;
  }

  /** @function

  @name WorkflowEditor.__getStates

  @description Get all workflow states.

  @returns {Array} Workflow states.
  */
  WorkflowEditor.prototype.__getStates = function () {
    var states, workflowMap, xmlString, workflowMapStates, xmlStringDefault, i, key, xmlStringNode, workflowStateObject;

    states = [];
    workflowMap = getWorkflowMap.call(this);
    xmlString = getXMLString.call(this);

    workflowMapStates = workflowMap.selectNodes("workflowmap/states/state");
    xmlStringDefault = xmlString.selectSingleNode("TWFLOW/DEFAULT");

    for (i = 0; i < workflowMapStates.length; i++) {
      key = workflowMapStates[i].getAttribute("tagvariant");
      xmlStringNode = xmlString.selectSingleNode("TWFLOW/NODE[Key='" + key + "']");
      workflowStateObject = getWorkflowStateObject.call(this, workflowMapStates[i], xmlStringDefault, xmlStringNode);
      states.push(new WorkflowState(workflowStateObject, key));
    }

    return states;
  };

  /** @function @ignore

  @name getWorkflowTransitionObject

  @description Construct a representation for a workflow transition from its xml nodes

  @param {Object} workflowMapTransition The xml node for the transition in WorkflowEditor.WorkflowMapXMLString.

  @param {Object} xmlStringDefault The xml node for default settings of the workflow transition node in WorkflowEditor.XMLString

  @param {Object} xmlStringLink The xml node for the workflow transition link in WorkflowEditor.XMLString

  @param {Array} states The states of the workflow editor, used here to populate the current and next states of the transition

  @returns {Object} The workflow transition representation object.
  */
  function getWorkflowTransitionObject(workflowMapTransition, xmlStringDefault, xmlStringLink, states) {
    var result, i, current, next;

    result = {};

    result.WorkflowEditor = this;

    result.WorkflowMapXMLString = getSimpleObjectFromXmlNode(workflowMapTransition);

    result.XMLString = getComplexObjectFromXmlNode(xmlStringDefault);
    xmlStringLink = getComplexObjectFromXmlNode(xmlStringLink);
    overrideDefaults(result.XMLString, xmlStringLink);

    // Populate the current and the next states of the transition
    for (i = 0; i < states.length && !(current && next); i++) {
      if (result.WorkflowMapXMLString.currentstatetagvariant === states[i].index) {
        current = result.WorkflowMapXMLString.currentstatetagvariant = states[i];
      }
      if (result.WorkflowMapXMLString.nextstatetagvariant === states[i].index) {
        next = result.WorkflowMapXMLString.nextstatetagvariant = states[i];
      }
    }

    return result;
  }

  /** @function

  @name WorkflowEditor.__getTransitions

  @description Get all workflow transitions.

  @returns {Array} Workflow transitions.
  */
  WorkflowEditor.prototype.__getTransitions = function () {
    var transitions, states, workflowMap, xmlString, workflowMapTransitions, xmlStringDefault, i, key, xmlStringLink, workflowTransitionObject;

    transitions = [];
    workflowMap = getWorkflowMap.call(this);
    xmlString = getXMLString.call(this);

    workflowMapTransitions = workflowMap.selectNodes("workflowmap/transitions/transition");
    xmlStringDefault = xmlString.selectSingleNode("TWFLOW/DEFAULT");

    states = this.__getStates();
    for (i = 0; i < workflowMapTransitions.length; i++) {
      key = workflowMapTransitions[i].getAttribute("tagvariant");
      xmlStringLink = xmlString.selectSingleNode("TWFLOW/LINK[Key='" + key + "']");
      workflowTransitionObject = getWorkflowTransitionObject.call(this, workflowMapTransitions[i], xmlStringDefault, xmlStringLink, states);
      transitions.push(new WorkflowTransition(workflowTransitionObject, key));
    }

    return transitions;
  };

  /** @function @ignore

  @name getWorkflowCommentObject

  @description Construct a representation for a workflow comment from its xml nodes

  @param {Object} xmlStringNode The xml node for the workflow comment node in WorkflowEditor.XMLString

  @param {Object} xmlStringDefault The xml node for default settings of the workflow comment node in WorkflowEditor.XMLString

  @returns {Object} The workflow comment representation object.
  */
  function getWorkflowCommentObject(xmlStringNode, xmlStringDefault) {
    var result;

    result = {};

    result.WorkflowEditor = this;

    result.XMLString = getComplexObjectFromXmlNode(xmlStringDefault);
    xmlStringNode = getComplexObjectFromXmlNode(xmlStringNode);
    overrideDefaults(result.XMLString, xmlStringNode);

    return result;
  }

  /** @function

  @name WorkflowEditor.__getComments

  @description Get all workflow comments.

  @returns {Array} Workflow comments.
  */
  WorkflowEditor.prototype.__getComments = function () {
    var comments, workflowMap, xmlString, xmlStringNodes, xmlStringDefault, i, key, workflowMapState, workflowCommentObject;

    comments = [];
    workflowMap = getWorkflowMap.call(this);
    xmlString = getXMLString.call(this);

    xmlStringNodes = xmlString.selectNodes("TWFLOW/NODE");
    xmlStringDefault = xmlString.selectSingleNode("TWFLOW/DEFAULT");

    for (i = 0; i < xmlStringNodes.length; i++) {
      key = xmlStringNodes[i].selectSingleNode("Key").text;
      workflowMapState = workflowMap.selectSingleNode("workflowmap/states/state[@tagvariant='" + key + "']");
      if (!workflowMapState) {
        workflowCommentObject = getWorkflowCommentObject.call(this, xmlStringNodes[i], xmlStringDefault);
        comments.push(new WorkflowComment(workflowCommentObject, key));
      }
    }

    return comments;
  };

  /** @function

  @name WorkflowToolBarItem.__getToolBarItems

  @description Get all toolbar items for the given parent toolbar item.

  @returns {Array} WorkflowEditor toolbar items.
  */
  WorkflowToolBarItem.prototype.__getToolBarItems = function () {
    var items, i;

    items = [];
    for (i = 0; i < this.control.SubItems.length; i++) {
      items.push(this.control.SubItems[i]);
    }

    return items;
  };

  /** @function

  @name WorkflowToolBarItem.__getName

  @description Get the name of the given toolbar item.

  @returns {String} The name of the toolbar item.
  */
  WorkflowToolBarItem.prototype.__getName = function () {
    return this.control.Name;
  };

  /** @function

  @name WorkflowToolBarItem.__enabled

  @description Determine if the toolbar item is enabled

  @returns {Boolean} True if the toolbar item is enabled, otherwise false
  */
  WorkflowToolBarItem.prototype.__enabled = function () {
    return this.control.Item.Enabled;
  };

  /** @function

  @name WorkflowToolBarItem.__visible

  @description Determine if the toolbar item is visible

  @returns {Boolean} True if the toolbar item is visible, otherwise false
  */
  WorkflowToolBarItem.prototype.__visible = function () {
    return this.control.Item.Visible;
  };

  /** @function

  @name WorkflowToolBarItem.__hover

  @description Hover the toolbar item.
  */
  WorkflowToolBarItem.prototype.__hover = function () {
    if (!this.__visible()) {
      Log.Error("Cannot perform a mouse action on an invisible toolbar item of the workflow.");
    }
    this.control.GetContainer().HoverMouse(this.control.Left + this.control.Width / 2, this.control.Top + this.control.Height / 2);
  };

  /** @function

  @name WorkflowToolBarItem.__click

  @description Click the toolbar item.
  */
  WorkflowToolBarItem.prototype.__click = function () {
    if (!this.__visible()) {
      Log.Error("Cannot perform a mouse action on an invisible toolbar item of the workflow.");
    }
    this.control.GetContainer().Click(this.control.Left + this.control.Width / 2, this.control.Top + this.control.Height / 2);
  };

  /** @function @ignore

  @name ensureCanvasPointVisible

  @description Ensure that the point (x, y) is visible on screen (relative to the whole area of workflow editor canvas)

  @param {Integer} x The X-coordinate of the point in pixels (relative to the whole area of the workflow editor canvas)

  @param {Integer} y The Y-coordinate of the point in pixels (relative to the whole area of the workflow editor canvas)

  @returns {Object} The effective coordinates for the same point (can be used directly to perform mouse actions e.g. Click()) e.g. {x: 10, y: 20}
  */
  function ensureCanvasPointVisible(x, y) {
    var effectiveX, effectiveY, effectiveWidth, effectiveHeight, tolerance;

    tolerance = 2;

    effectiveX = x - this.mCanvas.HScroll.Pos;
    effectiveY = y - this.mCanvas.VScroll.Pos;
    effectiveWidth = this.mCanvas.Width - VERTICAL_SCROLLBAR_WIDTH - tolerance;
    effectiveHeight = this.mCanvas.Height - HORIZONTAL_SCROLLBAR_HEIGHT - tolerance;

    if (effectiveX < 0) {
      this.mCanvas.HScroll.Pos = x;
    } else if (effectiveX > effectiveWidth) {
      this.mCanvas.HScroll.Pos = x - effectiveWidth;
    }

    if (effectiveY < 0) {
      this.mCanvas.VScroll.Pos = y;
    } else if (effectiveY > effectiveHeight) {
      this.mCanvas.VScroll.Pos = y - effectiveHeight;
    }

    // return fixed coordinates
    return {
      x: x - this.mCanvas.HScroll.Pos,
      y: y - this.mCanvas.VScroll.Pos
    };
  }

  /** @function

  @name WorkflowToolBarItem.__dragToCanvas

  @description Drag the toolbar item to the WorkflowEditor canvas at specific point (x, y)

  @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)

  @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
  */
  WorkflowToolBarItem.prototype.__dragToCanvas = function (x, y) {
    if (!this.__visible()) {
      Log.Error("Cannot perform a mouse action on an invisible toolbar item of the workflow.");
    }

    var sourceX, sourceY, distanceX, distanceY, effectiveCoordinates;

    // Ensure the point is visible on the screen (not scrolled away)
    effectiveCoordinates = ensureCanvasPointVisible.call(this.control.WorkflowEditor, x, y);
    x = effectiveCoordinates.x;
    y = effectiveCoordinates.y;

    sourceX = this.control.Left + this.control.Width / 2;
    sourceY = this.control.Top + this.control.Height / 2;
    distanceX = this.control.WorkflowEditor.mCanvas.Left + x - sourceX;
    distanceY = this.control.WorkflowEditor.mCanvas.Top + y - sourceY;

    this.control.GetContainer().Drag(sourceX, sourceY, distanceX, distanceY);
  };

  /** @function

  @name WorkflowState.__getName

  @description Get the name of the workflow state

  @returns  {String} The name of the workflow state
  */
  WorkflowState.prototype.__getName = function () {
    return this.control.WorkflowMapXMLString.name || this.control.XMLString.Text;
  };

  /** @function @ignore

  @name colorToHex

  @description Convert the color value to hex format

  @param {Integer} color The value of the color to be converted

  @returns  {String} The color in hex format
  */
  function colorToHex(color) {
    var red, green, blue;

    blue = (color >> 16) & 0xFF;
    green = (color >> 8) & 0xFF;
    red = color & 0xFF;
    color = (red << 16) + (green << 8) + blue; // Reorder color components to RGB

    return "0x" + ((1 << 24) + color).toString(16).substr(1).toUpperCase();
  }

  /** @function

  @name WorkflowState.__getFillColor

  @description Get the name of the workflow state

  @returns  {String} The color in hex format
  */
  WorkflowState.prototype.__getFillColor = function () {
    return colorToHex(Number(this.control.XMLString.FillColor));
  };

  /** @function

  @name WorkflowState.__getDrawColor

  @description Get the name of the workflow state

  @returns  {String} The color in hex format
  */
  WorkflowState.prototype.__getDrawColor = function () {
    return colorToHex(Number(this.control.XMLString.DrawColor));
  };

  /** @function

  @name WorkflowState.__getForeColor

  @description Get the name of the workflow state

  @returns  {String} The color in hex format
  */
  WorkflowState.prototype.__getForeColor = function () {
    return colorToHex(Number(this.control.XMLString.ForeColor));
  };

  /** @function

  @name WorkflowState.__getGradientColor

  @description Get the name of the workflow state

  @returns  {String} The color in hex format
  */
  WorkflowState.prototype.__getGradientColor = function () {
    return colorToHex(Number(this.control.XMLString.GradientColor));
  };

  /** @function

  @name WorkflowState.__isInitial

  @description Determine if the the workflow state is an initial state

  @returns {Boolean} True if the state is an initial state
  */
  WorkflowState.prototype.__isInitial = function () {
    return Number(this.control.WorkflowMapXMLString.isinitial) === 1;
  };

  /** @function

  @name WorkflowState.__isShadow

  @description Determine if the the workflow state is a shadow state

  @returns {Boolean} True if the state is a shadow state
  */
  WorkflowState.prototype.__isShadow = function () {
    return Number(this.control.WorkflowMapXMLString.isshadow) === 1;
  };

  /** @function

  @name WorkflowState.__isSink

  @description Determine if the the workflow state is a sink state

  @returns {Boolean} True if the state is a sink state
  */
  WorkflowState.prototype.__isSink = function () {
    return Number(this.control.WorkflowMapXMLString.issink) === 1;
  };

  /** @function

  @name WorkflowState.__isFinal

  @description Determine if the the workflow state is a final state

  @returns {Boolean} True if the state is a final state
  */
  WorkflowState.prototype.__isFinal = function () {
    return Number(this.control.WorkflowMapXMLString.isfinal) === 1;
  };

  /** @function

  @name WorkflowState.__isRejection

  @description Determine if the the workflow state is a rejection state

  @returns {Boolean} True if the state is a rejection state
  */
  WorkflowState.prototype.__isRejection = function () {
    return Number(this.control.WorkflowMapXMLString.isrejection) === 1;
  };

  /** @function

  @name WorkflowState.__isApproval

  @description Determine if the the workflow state is an approval state

  @returns {Boolean} True if the state is an approval state
  */
  WorkflowState.prototype.__isApproval = function () {
    return Number(this.control.WorkflowMapXMLString.isapproval) === 1;
  };

  /** @function

  @name WorkflowState.__isCompletion

  @description Determine if the the workflow state is a completion state

  @returns {Boolean} True if the state is a completion state
  */
  WorkflowState.prototype.__isCompletion = function () {
    return Number(this.control.WorkflowMapXMLString.iscompletion) === 1;
  };

  /** @function

  @name WorkflowState.__isReadOnly

  @description Determine if the the workflow state is a read-only state

  @returns {Boolean} True if the state is a read-only state
  */
  WorkflowState.prototype.__isReadOnly = function () {
    return Number(this.control.WorkflowMapXMLString.isreadonly) === 1;
  };

  /** @function

  @name WorkflowState.__isSelected

  @description Determine if the the workflow state is selected

  @returns {Boolean} True if the state is selected
  */
  WorkflowState.prototype.__isSelected = function () {
    return Number(this.control.WorkflowMapXMLString.IsSelected) === 1;
  };

  /** @function

  @name WorkflowState.__isHidden

  @description Determine if the the workflow state is hidden

  @returns {Boolean} True if the state is hidden
  */
  WorkflowState.prototype.__isHidden = function () {
    return aqString.ToLower(this.control.XMLString.Hidden) === aqString.ToLower("True");
  };

  /** @function @ignore

  @name getMousePointOfWorkflowState

  @description Get the appropriate point to be used to perform mouse actions on a workflow state

  @returns {Object} The point ( e.g. { x:10, y:10 } ) to be used directly by mouse actions e.g. Click
  */
  function getMousePointOfWorkflowState() {
    if (this.__isHidden()) {
      Log.Error("Cannot perform a mouse action on a hidden workflow state.");
    }

    var left, top, width, height;

    left = Number(this.control.XMLString.NODE.Left) / TWIPS_PER_PIXEL_X;
    top = Number(this.control.XMLString.NODE.Top) / TWIPS_PER_PIXEL_Y;
    width = Number(this.control.XMLString.NODE.Width) / TWIPS_PER_PIXEL_X;
    height = Number(this.control.XMLString.NODE.Height) / TWIPS_PER_PIXEL_Y;

    return ensureCanvasPointVisible.call(this.control.WorkflowEditor, left + width / 2, top + height / 2);
  }

  /** @function

  @name WorkflowState.__hover

  @description Hover on the workflow state
  */
  WorkflowState.prototype.__hover = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.HoverMouse(point.x, point.y);
  };

  /** @function

  @name WorkflowState.__click

  @description Click the workflow state
  */
  WorkflowState.prototype.__click = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.Click(point.x, point.y);
  };

  /** @function

  @name WorkflowState.__dblClick

  @description Double click the workflow state
  */
  WorkflowState.prototype.__dblClick = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.DblClick(point.x, point.y);
  };

  /** @function

  @name WorkflowState.__dragToPoint

  @description Drag the workflow state to the WorkflowEditor canvas at specific point (x, y)

  @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)

  @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
  */
  WorkflowState.prototype.__dragToPoint = function (x, y) {
    var sourcePoint, destinationPoint;
    sourcePoint = getMousePointOfWorkflowState.call(this);

    /** Using LLPlayer is important here, because we need to scroll to the destination point after we start the drag from the source workflow state.
    * If we used the standard Drag() method here instead and the destination point was scrolled away, the source workflow state will lose the selection
    * and even the destination point will be out of canvas bounds */

    sourcePoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    sourcePoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    this.control.WorkflowEditor.mCanvas.SetFocus();
    LLPlayer.MouseDown(MK_LBUTTON, sourcePoint.x, sourcePoint.y, 500);

    destinationPoint = ensureCanvasPointVisible.call(this.control.WorkflowEditor, x, y);
    destinationPoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    destinationPoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    LLPlayer.MouseMove(destinationPoint.x, destinationPoint.y, 500);
    LLPlayer.MouseUp(MK_LBUTTON, destinationPoint.x, destinationPoint.y, 500);
  };

  /** @function

  @name WorkflowState.__dragToState

  @description Drag the workflow state to another workflow state (useful for transitions creation)

  @param {Object} destination The destination workflow state
  */
  WorkflowState.prototype.__dragToState = function (destination) {
    var left, top, width, height;

    left = Number(destination.control.XMLString.NODE.Left) / TWIPS_PER_PIXEL_X;
    top = Number(destination.control.XMLString.NODE.Top) / TWIPS_PER_PIXEL_Y;
    width = Number(destination.control.XMLString.NODE.Width) / TWIPS_PER_PIXEL_X;
    height = Number(destination.control.XMLString.NODE.Height) / TWIPS_PER_PIXEL_Y;

    this.__dragToPoint(left + width / 2, top + height / 2);
  };

  /** @function

  @name WorkflowTransition.__getName

  @description Get the name of the workflow transition

  @returns  {String} The name of the workflow transition
  */
  WorkflowTransition.prototype.__getName = function () {
    return this.control.WorkflowMapXMLString.name || this.control.XMLString.Text;
  };

  /** @function

  @name WorkflowTransition.__getCurrentState

  @description Get the current workflow state of the workflow transition

  @returns {Object} The current state of the workflow transition
  */
  WorkflowTransition.prototype.__getCurrentState = function () {
    return this.control.WorkflowMapXMLString.currentstatetagvariant;
  };

  /** @function

  @name WorkflowTransition.__getNextState

  @description Get the next workflow state of the workflow transition

  @returns {Object} The next state of the workflow transition
  */
  WorkflowTransition.prototype.__getNextState = function () {
    return this.control.WorkflowMapXMLString.nextstatetagvariant;
  };

  /** @function

  @name WorkflowTransition.__getFillColor

  @description Get the name of the workflow transition

  @returns  {String} The color in hex format
  */
  WorkflowTransition.prototype.__getFillColor = function () {
    return colorToHex(Number(this.control.XMLString.FillColor));
  };

  /** @function

  @name WorkflowTransition.__getDrawColor

  @description Get the name of the workflow transition

  @returns  {String} The color in hex format
  */
  WorkflowTransition.prototype.__getDrawColor = function () {
    return colorToHex(Number(this.control.XMLString.DrawColor));
  };

  /** @function

  @name WorkflowTransition.__getForeColor

  @description Get the name of the workflow transition

  @returns  {String} The color in hex format
  */
  WorkflowTransition.prototype.__getForeColor = function () {
    return colorToHex(Number(this.control.XMLString.ForeColor));
  };

  /** @function

  @name WorkflowTransition.__getGradientColor

  @description Get the name of the workflow transition

  @returns  {String} The color in hex format
  */
  WorkflowTransition.prototype.__getGradientColor = function () {
    return colorToHex(Number(this.control.XMLString.GradientColor));
  };

  /** @function

  @name WorkflowTransition.__isRejection

  @description Determine if the the workflow transition is a rejection transition

  @returns {Boolean} True if the transition is a rejection transition
  */
  WorkflowTransition.prototype.__isRejection = function () {
    return Number(this.control.WorkflowMapXMLString.isrejection) === 1;
  };

  /** @function

  @name WorkflowTransition.__isApproval

  @description Determine if the the workflow transition is an approval transition

  @returns {Boolean} True if the transition is an approval transition
  */
  WorkflowTransition.prototype.__isApproval = function () {
    return Number(this.control.WorkflowMapXMLString.isapproval) === 1;
  };

  /** @function

  @name WorkflowTransition.__isHidden

  @description Determine if the the workflow transition is hidden

  @returns {Boolean} True if the transition is hidden
  */
  WorkflowTransition.prototype.__isHidden = function () {
    return aqString.ToLower(this.control.XMLString.Hidden) === aqString.ToLower("True");
  };

  /** @function @ignore

  @name getMousePointOfWorkflowTransition

  @description Get the appropriate point to be used to perform mouse actions on a workflow transition

  @returns {Object} The point ( e.g. { x:10, y:10 } ) to be used directly by mouse actions e.g. Click
  */
  function getMousePointOfWorkflowTransition() {
    if (this.__isHidden()) {
      Log.Error("Cannot perform a mouse action on a hidden workflow transition.");
    }

    var x, y, x1, y1, x2, y2;

    if (this.control.XMLString.ExtraPoints.Point_3) {
      x = this.control.XMLString.ExtraPoints.Point_2.x / TWIPS_PER_PIXEL_X;
      y = this.control.XMLString.ExtraPoints.Point_2.y / TWIPS_PER_PIXEL_Y;
    } else {
      x1 = Number(this.control.XMLString.ExtraPoints.Point_1.x);
      x2 = Number(this.control.XMLString.ExtraPoints.Point_2.x);
      y1 = Number(this.control.XMLString.ExtraPoints.Point_1.y);
      y2 = Number(this.control.XMLString.ExtraPoints.Point_2.y);

      x = (x1 + x2) / (2 * TWIPS_PER_PIXEL_X);
      y = (y1 + y2) / (2 * TWIPS_PER_PIXEL_Y);
    }

    return ensureCanvasPointVisible.call(this.control.WorkflowEditor, x, y);
  }

  /** @function

  @name WorkflowTransition.__hover

  @description Hover on the workflow transition
  */
  WorkflowTransition.prototype.__hover = function () {
    var point = getMousePointOfWorkflowTransition.call(this);
    this.control.WorkflowEditor.mCanvas.HoverMouse(point.x, point.y);
  };

  /** @function

  @name WorkflowTransition.__click

  @description Click the workflow transition
  */
  WorkflowTransition.prototype.__click = function () {
    var point = getMousePointOfWorkflowTransition.call(this);
    this.control.WorkflowEditor.mCanvas.Click(point.x, point.y);
  };

  /** @function

  @name WorkflowTransition.__dblClick

  @description Double click the workflow transition
  */
  WorkflowTransition.prototype.__dblClick = function () {
    var point = getMousePointOfWorkflowTransition.call(this);
    this.control.WorkflowEditor.mCanvas.DblClick(point.x, point.y);
  };

  /** @function

  @name WorkflowTransition.__dragToPoint

  @description Drag the workflow transition to the WorkflowEditor canvas at specific point (x, y)

  @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)

  @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
  */
  WorkflowTransition.prototype.__dragToPoint = function (x, y) {
    var sourcePoint, destinationPoint;
    sourcePoint = getMousePointOfWorkflowTransition.call(this);

    /** Using LLPlayer is important here, because we need to scroll to the destination point after we start the drag from the source workflow state.
    * If we used the standard Drag() method here instead and the destination point was scrolled away, the source workflow state will lose the selection
    * and even the destination point will be out of canvas bounds */

    sourcePoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    sourcePoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    this.control.WorkflowEditor.mCanvas.SetFocus();
    LLPlayer.MouseDown(MK_LBUTTON, sourcePoint.x, sourcePoint.y, 500);

    destinationPoint = ensureCanvasPointVisible.call(this.control.WorkflowEditor, x, y);
    destinationPoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    destinationPoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    LLPlayer.MouseMove(destinationPoint.x, destinationPoint.y, 500);
    LLPlayer.MouseUp(MK_LBUTTON, destinationPoint.x, destinationPoint.y, 500);
  };

  /** @function

  @name WorkflowComment.__getText

  @description Get the name of the workflow comment

  @returns  {String} The name of the workflow comment
  */
  WorkflowComment.prototype.__getText = function () {
    return this.control.XMLString.Text;
  };

  /** @function

  @name WorkflowComment.__getFillColor

  @description Get the name of the workflow comment

  @returns  {String} The color in hex format
  */
  WorkflowComment.prototype.__getFillColor = function () {
    return colorToHex(Number(this.control.XMLString.FillColor));
  };

  /** @function

  @name WorkflowComment.__getDrawColor

  @description Get the name of the workflow comment

  @returns  {String} The color in hex format
  */
  WorkflowComment.prototype.__getDrawColor = function () {
    return colorToHex(Number(this.control.XMLString.DrawColor));
  };

  /** @function

  @name WorkflowComment.__getForeColor

  @description Get the name of the workflow comment

  @returns  {String} The color in hex format
  */
  WorkflowComment.prototype.__getForeColor = function () {
    return colorToHex(Number(this.control.XMLString.ForeColor));
  };

  /** @function

  @name WorkflowComment.__getGradientColor

  @description Get the name of the workflow comment

  @returns  {String} The color in hex format
  */
  WorkflowComment.prototype.__getGradientColor = function () {
    return colorToHex(Number(this.control.XMLString.GradientColor));
  };

  /** @function

  @name WorkflowComment.__isHidden

  @description Determine if the the workflow comment is hidden

  @returns {Boolean} True if the comment is hidden
  */
  WorkflowComment.prototype.__isHidden = function () {
    return aqString.ToLower(this.control.XMLString.Hidden) === aqString.ToLower("True");
  };

  /** @function

  @name WorkflowComment.__hover

  @description Hover on the workflow comment
  */
  WorkflowComment.prototype.__hover = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.HoverMouse(point.x, point.y);
  };

  /** @function

  @name WorkflowComment.__click

  @description Click the workflow comment
  */
  WorkflowComment.prototype.__click = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.Click(point.x, point.y);
  };

  /** @function

  @name WorkflowComment.__dblClick

  @description Double click the workflow comment
  */
  WorkflowComment.prototype.__dblClick = function () {
    var point = getMousePointOfWorkflowState.call(this);
    this.control.WorkflowEditor.mCanvas.DblClick(point.x, point.y);
  };

  /** @function

  @name WorkflowComment.__dragToPoint

  @description Drag the workflow comment to the WorkflowEditor canvas at specific point (x, y)

  @param {Integer} x The x-coordinate for destination point relative to the canvas whole area (including scrolled away points)

  @param {Integer} y The y-coordinate for destination point relative to the canvas whole area (including scrolled away points)
  */
  WorkflowComment.prototype.__dragToPoint = function (x, y) {
    var sourcePoint, destinationPoint;
    sourcePoint = getMousePointOfWorkflowState.call(this);

    /** Using LLPlayer is important here, because we need to scroll to the destination point after we start the drag from the source workflow state.
    * If we used the standard Drag() method here instead and the destination point was scrolled away, the source workflow state will lose the selection
    * and even the destination point will be out of canvas bounds */

    sourcePoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    sourcePoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    this.control.WorkflowEditor.mCanvas.SetFocus();
    LLPlayer.MouseDown(MK_LBUTTON, sourcePoint.x, sourcePoint.y, 500);

    destinationPoint = ensureCanvasPointVisible.call(this.control.WorkflowEditor, x, y);
    destinationPoint.x += this.control.WorkflowEditor.mCanvas.ScreenLeft; // We are use screen-coordinates here for LLPlayer
    destinationPoint.y += this.control.WorkflowEditor.mCanvas.ScreenTop; // We are use screen-coordinates here for LLPlayer

    LLPlayer.MouseMove(destinationPoint.x, destinationPoint.y, 500);
    LLPlayer.MouseUp(MK_LBUTTON, destinationPoint.x, destinationPoint.y, 500);
  };
};