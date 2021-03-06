//USEUNIT Private_Utils

var ComboBox, ComboBoxItem;

/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new ComboBox(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}
/* Object Model ***********************************************************************************/

/* 
 * @class "ComboBox" object model
 * @description Represents a combobox.
 * @param {Object} control - TestComplete's object containing a combobox.
 */
ComboBox = function (control) {
  /** 
   * @field
   * @description Stores control for which this object model is created.
   */
  this.control = this.__initialize(control);
  /*
   * @function
   * @name ComboBox.findItem
   * @description Retrieve an item by its name.
   * @param {String} name Name of the column to search for.
   */
  this.FindItem = function (name) {
    return this.__findItem(name);
  };
  /*
   * @function
   * @name ComboBox.IsEnabled
   * @description Tells whether the ComboBox is enabled or not
   */
  this.IsEnabled = function () {
    return this.__isEnabled();
  };
  return this;
};

/*
 * @class "ComboBoxItem" object model
 * @description Represents a combobox item.
 * @param {Object} control TestComplete's object containing a combobox item.
 * @param {Integer} index Item's index (as appears on screen).
 */
ComboBoxItem = function (control, index) {
  /*
   * @field
   * @description Stores control for which this object model is created.
   */
  this.control = this.__initialize(control);
  /*
   * @field
   * @description Stores items's index (as appears on screen).
   */
  this.index = index || 0;
  /*
   * @function
   * @name ComboBoxItem.Click
   * @description Click an item in combobox
   */
  this.Click = function () {
    this.__click();
  };
  /*
   * @function
   * @name ComboBoxItem.GetValue
   * @description Get items value
   */
  this.GetValue = function () {
    return this.__getValue();
  };
  /*
   * @function
   * @name ComboBoxItem.GetColumn
   * @description Get the column
   */
  this.GetColumn = function () {
    return this.__getColumn();
  };
  /*
   * @function
   * @name ComboBoxItem.IsSelected
   * @description Return is item selecte in ComboBox
   */
  this.IsSelected = function () {
    return this.__isSelected();
  };
  return this;
};

/* Object Bindings ********************************************************************************/
/*
 * @function
 * @name ComboBox.__initialize
 * @description Initialize control passed to "ComboBox" object.
 * @param {Object} control TestComplete's object containing a combobox.
 * @returns {Object} Same control if it passes initialization.
 * @throws Runtime Object initialization failed.
 */
ComboBox.prototype.__initialize = function (Control) {
  var i, bindingsMap, bindingMap, b = [__binding.ComboBox_Default];

  if (aqObject.IsSupported(Control, "className") && Control.className === "sCmbWrapper") {
    Control = Control.Parent;
  }
  bindingsMap = [
    Private_Utils.COMMON_REPOSITORY.BindingHelpers.CreateBindingMap({
      "ObjectType": "ComboBox_Select"
    }, "ComboBox_Default"),
    Private_Utils.COMMON_REPOSITORY.BindingHelpers.CreateBindingMap({
      "ObjectType": "Panel",
      "className": "ComboBox_Tenrox"
    }, "ComboBox_Tenrox"),
    Private_Utils.COMMON_REPOSITORY.BindingHelpers.CreateBindingMap({
      "ObjectType": "Panel",
      "className": "sComboWrapper"
    }, "ComboBox_Dynamic"),
    Private_Utils.COMMON_REPOSITORY.BindingHelpers.CreateBindingMap({
      "className": "rrTopMenu.*"
    }, "ComboBox_TopMenu")
  ];

  for (i = 0; i < bindingsMap.length; i++) {
    bindingMap = bindingsMap[i];
    if (Private_Utils.COMMON_REPOSITORY.Control.IsIdentifiedBy(Control, bindingMap.identificationCriteria)) {
      b.push(__binding[bindingMap.binding]);
    }
  }

  for (i = 0; i < b.length; i++) {
    b[i]();
  }

  return Control;
};

/** @function
 * @name ComboBoxItem.__initialize
 * @description Initialize control passed to "ComboBoxItem" object.
 * @param {Object} control TestComplete's object containing a list ite,.
 * @returns {Object} Same control if it passes initialization.
 * @throws Runtime Object initialization failed.
 */
ComboBoxItem.prototype.__initialize = function (control) {
  return control;
};

/** @description "ComboBox" default object bindings. */
__binding.ComboBox_Default = function () {
  /** 
   * @function
   * @name ComboBox.__findItem
   * @description Searches for an item contained in a combobox.
   * @param {String} name Name of the column to search for.
   * @returns {Object} The found item.
   */
  ComboBox.prototype.__findItem = function (name) {
    // if it's a string -> try to evaluate to get either array or hash
    var isJson = false, params, col, colName, cc, items, i;
    if (typeof name === "string" && aqString.StrMatches("[{]", name)) {
      isJson = true;
      params = eval("(" + name + ")");
    }
    if (isJson) {
      for (col in params[0]) {
        if (aqObject.IsSupported(params[0], col)) {
          colName = col;
          name = params[0][col].replace(/^[\s\u00A0]+|[\s\u00A0]+$/, "");
        }
      }
      cc = this.__getItems(colName);
    } else {
      cc = this.__getItems();
    }

    items = [];
    for (i = 0; i < cc.length; i++) {
      if (Private_Utils.StringMatches(cc[i].GetValue().replace(/^[\s\u00A0]+|[\s\u00A0]+$/, ""), name)) {
        items.push(cc[i]);
      }
    }
    return items;
  };
  /** 
   * @function
   * @name ComboBox.__getItems
   * @description Retrieve Items contained in a combobox.
   * @returns {Array} Array of Items.
   */
  ComboBox.prototype.__getItems = function () {
    var res = [], i;
    for (i = 0; i < this.control.wItemCount; i++) {
      res[i] = new ComboBoxItem({
        ComboBox: this.control
      }, i);
    }
    return res;
  };

  /**
   * @function
   * @name ComboBoxItem.__getValue
   * @description Retreive Item's name (caption), if any.
   * @returns {String} Item's name.
   */
  ComboBoxItem.prototype.__getValue = function () {
    return this.control.ComboBox.wItem(this.index);
  };

  /** 
   * @function
   * @name ComboBoxItem.__isSelected
   * @description Check whether a Item is selected in combobox.
   * @returns {boolean} Item is selected.
   */
  ComboBoxItem.prototype.__isSelected = function () {
    return this.control.ComboBox.wSelectedItem === this.index;
  };
  /** 
   * @function
   * @name ComboBox.__isEnabled
   * @description Check whether the combobox is enabled or not.
   * @returns {boolean} ComboBox is enabled.
   */
  ComboBox.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /**
   * @function
   * @name ComboBoxItem.__click
   * @description Click on a Item in combobox.
   */
  ComboBoxItem.prototype.__click = function () {
    this.control.ComboBox.ClickItem(this.index);
  };
};

/** @description "ComboBox" Tenrox object bindings. */
__binding.ComboBox_Tenrox = function () {
  function OpenComboBox(Control) {
    var target = Control.Find(["ObjectType"], ["Image"]);
    if (!target.Exists) {
      target = Control;
    }
    target.Click(target.Width / 2, target.Height / 2);
  }
  function GetContainer(Control, Close) {
    var frame, controlId;
    controlId = Control.idStr;
    Log.LockEvents();
    OpenComboBox(Control);
    if (Close) {
      Control.Keys("[Esc]");
    }
    Log.UnlockEvents();

    frame = Private_Utils.COMMON_REPOSITORY.Control.FindParentByProperties(Control, {
      "ObjectType": "Frame"
    });
    if (frame !== null) {
      frame.Refresh();
      return frame.FindChild(["ObjectType", "idStr"], ["Panel", controlId + "_DropDownPlaceholder"]);
    }
    return {Exists : false};
  }
  /** 
   * @function
   * @name ComboBox.__getItems
   * @description Retrieve Items contained in a combobox.
   * @returns {Array} Array of Items.
   */
  ComboBox.prototype.__getItems = function () {
    var container, items, control, controlId;
    control = this.control;
    controlId = this.control.idStr;
    container = GetContainer(control, true);

    if (container.Exists) {
      items = VBArray(container.FindAllChildren(["ObjectType", "idStr"], ["Panel", controlId + "_c*"], 5)).toArray();
      return Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, index) {
        return new ComboBoxItem({
          ComboBox: control,
          Item: item
        }, index);
      });
    }
    return [];
  };

  /**
   * @function
   * @name ComboBoxItem.__getValue
   * @description Retreive Item's name (caption), if any.
   * @returns {String} Item's name.
   */
  ComboBoxItem.prototype.__getValue = function () {
    return this.control.Item.contentText;
  };

  /** 
   * @function
   * @name ComboBoxItem.__isSelected
   * @description Check whether a Item is selected in combobox.
   * @returns {boolean} Item is selected.
   */
  ComboBoxItem.prototype.__isSelected = function () {
    var underlyingControl = this.control.ComboBox.Find(['ObjectType'], ['TextBox'], 5);
    if (underlyingControl.Exists) {
      return underlyingControl.value === this.__getValue();
    }
    underlyingControl = this.control.ComboBox.Find(['ObjectType'], ['Link'], 5);
    if (underlyingControl.Exists) {
      return underlyingControl.getAttribute("val") === this.__getValue();
    }
    return this.control.ComboBox.contentText === this.__getValue();
  };
  /** 
   * @function
   * @name ComboBox.__isEnabled
   * @description Check whether the combobox is enabled or not.
   * @returns {boolean} ComboBox is enabled.
   */
  ComboBox.prototype.__isEnabled = function () {
    var underlyingControl = this.control.Find(['ObjectType'], ['TextBox'], 5);
    if (!underlyingControl.Exists) {
      underlyingControl = this.control.Find(['ObjectType'], ['Link'], 5);
    }
    if (underlyingControl.Exists) {
      return underlyingControl.Enabled;
    }
    return this.control.Enabled;
  };
  /**
   * @function
   * @name ComboBoxItem.__click
   * @description Click on a Item in combobox.
   */
  ComboBoxItem.prototype.__click = function () {
    var objectIdentifier, popup, item;
    objectIdentifier = this.control.Item.ObjectIdentifier;
    popup = GetContainer(this.control.ComboBox, false);
    item = popup.FindChild("ObjectIdentifier", objectIdentifier, 2); 
    
    if (!item.VisibleOnScreen) {
      item.scrollIntoView();
    }
    item.Click();
  };
};

/** @description "ComboBox" Dynamic object bindings. */
__binding.ComboBox_Dynamic = function () {
  /** 
   * @function
   * @name ComboBox.__findItem
   * @description Searches for an item contained in a combobox.
   * @param {String} name Name of the column to search for.
   * @returns {Object} The found item.
   */
  ComboBox.prototype.__findItem = function (name) {
    var item, f = function (cc, pp) {
      var a = cc.__getItems(), p = pp.shift(), e = null, i;
      for (i = 0; i < a.length; i++) {
        if (Private_Utils.StringMatches(a[i].GetValue(), p)) {
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
    item = f(this, name.indexOf("|") >= 0 ? name.split("|") : [name]);
    if (item !== null) {
      return [item];
    }
    return [];
  };
  /** 
   * @function
   * @name ComboBox.__getItems
   * @description Retrieve Items contained in a combobox.
   * @returns {Array} Array of Items.
   */
  ComboBox.prototype.__getItems = function () {
    var matches, frame, children, jqueryIdentifier, container, items, control, res, comboWrapper, textbox, x, index, popup;
    if (this.__itemsCache) {
      return this.__itemsCache;
    }
   
    res = [];
    control = this.control;
    matches = this.control.Parent.outerHTML.match(/(jQuery[\d]+)="(\d+)"/);
    if (matches !== null && matches.length === 3) {
      jqueryIdentifier = Private_Utils.COMMON_REPOSITORY.Objects.Strings.Format('{0}="{1}"', matches[1], parseInt(matches[2], 10) + 1);
      frame = Private_Utils.COMMON_REPOSITORY.Control.FindParentByProperties(control, {
        "ObjectType": "Frame"
      });
      if (frame !== null) {
        children = VBArray(frame.FindAllChildren(["ObjectType", "className"], ["Panel", "cmbPopUpWrapper*"])).toArray();
        popup = Private_Utils.COMMON_REPOSITORY.Objects.Arrays.FirstOrDefault(children, function (child) {
          return child.outerHTML.match(jqueryIdentifier) !== null;
        });
        container = popup.FindChild("className", "cmbPopUp");
        
        if (container.ChildCount === 0) {
          comboWrapper = control.FindChild("className", "sCmbWrapper");
          textbox = comboWrapper.FindChild("ObjectType", "Textbox");
          if (textbox.Exists) {
            x = textbox.Width + 5;
          } else {
            x = comboWrapper.Width / 2;
          }
          comboWrapper.Click(x, 5);
          delay(500);
          comboWrapper.Click(x, 5);
        }
        
        index = 0;
        items = VBArray(container.FindAllChildren("ObjectType", "Link")).toArray();
        res = Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, i) {
          return new ComboBoxItem({
            ComboBox: control,
            Popup: popup,
            Panel: null,
            Item: item,
            Parent: null
          }, index++);
        });
        
        items = VBArray(container.FindAllChildren(["ObjectType", "className"], ["Panel", "parenItemWrapper"])).toArray();
        res = res.concat(Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, i) {
          return new ComboBoxItem({
            ComboBox: control,
            Popup: popup,
            Panel: item,
            Item: item.FindChild("ObjectType", "Link", 3),
            Parent: null
          }, index++);
        }));
      }
    } else {
      frame = Private_Utils.COMMON_REPOSITORY.Control.FindParentByProperties(control, {
        "ObjectType": "Frame"
      });
      container = frame.FindChild(["className", "Parent.className", "VisibleOnScreen"], ["cmbPopUp", "cmbPopUpWrapper", true], 5);
      if (container.Exists) {
        index = 0;
        items = VBArray(container.FindAllChildren("ObjectType", "Link")).toArray();
        res = Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, i) {
          return new ComboBoxItem({
            ComboBox: control,
            Popup: popup,
            Panel: null,
            Item: item,
            Parent: null
          }, index++);
        });
      }
    }
    this.__itemsCache = res;
    return res;
  };
  
  /**
   * @function
   * @name ComboBoxItem.__getItems
   * @description Retreive Item's subitems in tree case.
   * @returns {Array} Sub Items.
   */
  ComboBoxItem.prototype.__getItems = function () {
    var res, index, container, self;
    if (this.control.Panel === null) {
      return [];
    }
    
    index = 0;
    self = this;
    container = this.control.Panel.Parent.FindChild(["ObjectType", "className", "ObjectIdentifier"], ["Panel", "subItemsCont*", 1 + this.control.Panel.ObjectIdentifier], 2);
    
    items = VBArray(container.FindAllChildren(["ObjectType", "className"], ["Panel", "parenItemWrapper"])).toArray();
    res = Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, i) {
      return new ComboBoxItem({
        ComboBox: self.control.ComboBox,
        Popup: self.control.Popup,
        Panel: item,
        Item: item.FindChild("ObjectType", "Link", 3),
        Parent: self
      }, index++);
    });
    return res;
  };  

  /**
   * @function
   * @name ComboBoxItem.__getValue
   * @description Retreive Item's name (caption), if any.
   * @returns {String} Item's name.
   */
  ComboBoxItem.prototype.__getValue = function () {
    var value, image;
    value = this.control.Item.contentText;
    image = this.control.Item.FindChild("ObjectType", "Image");
    if (image.Exists) {
      value = image.title;
    }
    if (value === "") {
      value = this.control.Item.getAttribute("val");
    }
    return value;
  };

  /** 
   * @function
   * @name ComboBoxItem.__isSelected
   * @description Check whether a Item is selected in combobox.
   * @returns {boolean} Item is selected.
   */
  ComboBoxItem.prototype.__isSelected = function () {
    if (aqString.Find(this.control.Popup.className, "multiselectPopUp") !== -1) {
      return this.control.Item.FindChild("ObjectType", "Checkbox").checked;
    }
  
    var underlyingControl = this.control.ComboBox.Find(['ObjectType'], ['TextBox'], 5);
    if (underlyingControl.Exists) {
      return underlyingControl.value === this.__getValue();
    }
    underlyingControl = this.control.ComboBox.Find(['ObjectType'], ['Image'], 5);
    if (underlyingControl.Exists) {
      return underlyingControl.title === this.__getValue();
    }
    return this.control.ComboBox.contentText === this.__getValue();
  };
  /** 
   * @function
   * @name ComboBox.__isEnabled
   * @description Check whether the combobox is enabled or not.
   * @returns {boolean} ComboBox is enabled.
   */
  ComboBox.prototype.__isEnabled = function () {
    var underlyingControl = this.control.Find(['ObjectType'], ['TextBox'], 5);
    if (!underlyingControl.Exists) {
      underlyingControl = this.control.Find(['ObjectType'], ['Link'], 5);
    }
    if (underlyingControl.Exists) {
      return underlyingControl.Enabled;
    }
    return this.control.Enabled;
  };
  /**
   * @function
   * @name ComboBoxItem.__click
   * @description Click on a Item in combobox.
   */
  ComboBoxItem.prototype.__click = function () {
    this.control.ComboBox.Click(this.control.ComboBox.Width / 2, this.control.ComboBox.Height / 2);
    if (this.control.Parent !== null) {
      this.control.Parent.__expand();
    }
    
    this.control.Item.Click();
    if (aqString.Find(this.control.Popup.className, "multiselectPopUp") !== -1) {
      this.control.ComboBox.Click();
    }
  };
  
  /**
   * @function
   * @name ComboBoxItem.__expand
   * @description Click on + to expand tree item.
   */
  ComboBoxItem.prototype.__expand = function () {
    var toggleImage;
    if (this.control.Parent !== null) {
      this.control.Parent.__expand();
    }
    
    toggleImage = this.control.Panel.FindChild(["ObjectType", "className"], ["Panel", "toggleImage*"], 3);
    if (aqString.Find(toggleImage.className, "toggled") === -1) {
      toggleImage.Click();
    }
  }
};

/** @description "ComboBox" TopMenu object bindings. */
__binding.ComboBox_TopMenu = function () {
  /** 
   * @function
   * @name ComboBox.__getItems
   * @description Retrieve Items contained in a combobox.
   * @returns {Array} Array of Items.
   */
  ComboBox.prototype.__getItems = function () {
    var page, container, items, control;
    control = this.control;
    control.HoverMouse(control.Width / 2, control.Height / 2);
    page = Private_Utils.GetPage(control);
    container = page.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Panel", "divSubMenuTenrox*", true]);
    items = VBArray(container.FindAllChildren(["ObjectType"], ["Panel"])).toArray();
    return Private_Utils.COMMON_REPOSITORY.Objects.Arrays.Select(items, function (item, index) {
      return new ComboBoxItem({
        ComboBox: control,
        Item: item
      }, index);
    });
  };
  /**
   * @function
   * @name ComboBoxItem.__getValue
   * @description Retreive Item's name (caption), if any.
   * @returns {String} Item's name.
   */
  ComboBoxItem.prototype.__getValue = function () {
    return this.control.Item.contentText;
  };
  /** 
   * @function
   * @name ComboBoxItem.__isSelected
   * @description Check whether a Item is selected in combobox.
   * @returns {boolean} Item is selected.
   */
  ComboBoxItem.prototype.__isSelected = function () {
    return false;
  };
  /** 
   * @function
   * @name ComboBox.__isEnabled
   * @description Check whether the combobox is enabled or not.
   * @returns {boolean} ComboBox is enabled.
   */
  ComboBox.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /**
   * @function
   * @name ComboBoxItem.__click
   * @description Click on a Item in combobox.
   */
  ComboBoxItem.prototype.__click = function () {
    this.control.ComboBox.HoverMouse(this.control.ComboBox.Width / 2, this.control.ComboBox.Height / 2);
    this.control.Item.Click();
  };
};
