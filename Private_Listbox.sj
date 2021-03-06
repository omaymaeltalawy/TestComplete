/** 
 * @ignore
 * @description Control binding
 */
var __binding = {};

/** 
 * @ignore
 * @description Initialize control wrapper
 */
function initWrapper(Control) {
  var __wrapper;
  try {
    __wrapper = new ListBox(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}

/* Object Model ***********************************************************************************/

/** 
 * @class "ListBox" object model
 * @description Represents a list box.
 * @param {Object} - Control TestComplete's object containing a list box.
 * @sample - new ListBox(Listbox)
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
ListBox = function (Control) {

  this.control = this.__initialize(Control);

  /** 
   * This function find list item by its value.
   * @param {String} - Value List item's value.
   * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program".
   * @returns {ListItem} Desired list item or null.
   * @sample - ListBox.FindItem("item")
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  this.FindItem = function (Value) {
    var items, i;
    items = this.__getItems();
    for (i = 0; i < items.length; i++) {
      if (items[i].GetValue() === Value) {
        return items[i];
      }
    }
    return null;
  };

  /** 
   * This function find a selected item by its value.
   * @param {String} Value - List item's value.
   * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program".
   * @returns {ListItem} Desired list item or null.
   * @sample - ListBox.FindSelectedItem("item")
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  this.FindSelectedItem = function (Value) {
    var items, i;
    items = this.__getSelectedItems();
    for (i = 0; i < items.length; i++) {
      if (items[i].GetValue() === Value) {
        return items[i];
      }
    }
    return null;
  };


  /** 
   * This function select or deselect list items.
   * @param {String} Value - List item's value.
   * @param {boolean} Flag - flag that indicates if the item will be selected of deselected
   * @sample - ListBox.SelectItems("item", true)
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  this.SelectItems = function (Value, Flag) {
    var items, i;
    items = this.__getItems();
    for (i = 0; i < items.length; i++) {
      if (items[i].GetValue() === Value) {
        this.__selectItem(items[i].index, Flag);
      }
    }
  };
};

/** 
 * @class "ListItem" object model
 * @description Represents a list item.
 * @param {Object} - Control TestComplete's object containing a list item.
 * @sample - new ListItem(ListItem)
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
ListItem = function (Control, Index) {

  this.control = this.__initialize(Control);

  this.index = Index ? Index : 0;

  /** 
   * This function returns a list item's value.
   * @param {String} Value - List item's value.
   * @returns {String} - List item's value.
   * @sample - ListItem.GetValue("item", true)
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  this.GetValue = function () {
    return this.__getValue();
  };
};

/* Object Bindings ********************************************************************************/


/** 
 * This function initializes control passed to "ListBox" object.
 * @param {Object} Control - TestComplete's object containing a list box.
 * @returns {Object} - Same control if it passes initialization.
 * @throws - Runtime Object initialization failed.
 * @sample - ListBox.__initialize(ListBox)
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
ListBox.prototype.__initialize = function (Control) {
  var i, b;
  b = [];

  // if (control properties looks good) { select apropriate binding }
  // Bindings can be stacked. Most common one should go first.
  if (true)
    b.push(__binding.listbox_default);

  if (aqObject.IsSupported(Control, "className") && (Control.className === "ListView" || Control.className === "dxgvTable"))
    b.push(__binding.listbox_listview);

  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return Control;
};

/** 
 * This function initializes control passed to "ListItem" object.
 * @param {Object} Control - TestComplete's object containing a list item.
 * @returns {Object} - Same control if it passes initialization.
 * @throws - Runtime Object initialization failed.
 * @sample - ListItem.__initialize(ListItem)
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
ListItem.prototype.__initialize = function (Control) {
  return Control;
};

__binding.listbox_default = function () {

  ListBox.prototype.__getItems = function () { /* todo */ };
  ListBox.prototype.__getSelectedItems = function () { /* todo */ };
  ListBox.prototype.__selectItem = function (value, flag) { /* todo */ };
  ListItem.prototype.__getValue = function () { /* todo */ };
};

__binding.listbox_listview = function () {

  /** 
   * This function returns an array of the list items contained in the list box.
   * @returns {Array} - An array of list items
   * @sample - ListBox.__getItems()
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListBox.prototype.__getItems = function () {
    var i, items, checkBox;
    items = [];
    for (i = 0; i < this.control.RowCount; i++) {
      checkBox = this.control.Cell(i, 0).FindChild(["ObjectType"], ["Checkbox"], 2);
      items[i] = new ListItem({
        list: this.control,
        flag: checkBox.checked,
        value: this.control.Cell(i, 1).contentText
      }, i);
    }
    return items;
  };

  /** 
   * This function returns an array of the selected list items contained in the list box.
   * @returns {Array} - An array of selected list items
   * @sample - ListBox.__getSelectedItems()
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListBox.prototype.__getSelectedItems = function () {
    var items, selectedItems, i;
    items = this.__getItems();
    selectedItems = [];
    for (i = 0; i < items.length; i++) {
      if (items[i].__isSelected() === true) {
        selectedItems[selectedItems.length] = items[i];
      }
    }
    return selectedItems;
  };

  /** 
   * This function selects or deselect a list items contained in the list box.
   * @param {String} Value - The value of the item list
   * @param {Boolean} Flag - The flag to select or deselect list item
   * @sample - ListBox.__selectItem("item", true)
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListBox.prototype.__selectItem = function (Value, Flag) {
    var items, i;
    items = this.__getItems();
    for (i = 0; i < items.length; i++) {
      if (items[i].index === Value) {
        items[i].__select(Flag);
      }
    }
  };

  /** 
   * This function returns the value of a list item
   * @return {String} - Value of the list item
   * @sample - ListItem.__getValue()
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListItem.prototype.__getValue = function () {
    return this.control.value;
  };

  /** 
   * This function return a boolean indicating if a list item is selected.
   * @return {Boolean} - Boolean indicating if a list item is selected.
   * @sample - ListItem.__isSelected()
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListItem.prototype.__isSelected = function () {
    return this.control.flag;
  };

  /** 
   * This function selects a list item.
   * @sample - ListItem.__select()
   * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
   * @creation 1/27/2013
   */
  ListItem.prototype.__select = function (Flag) {
    this.control.list.Cell(this.index, 0).FindChild(["ObjectType"], ["Checkbox"], 2).checked = Flag;
    this.control.flag = Flag;
  };
};