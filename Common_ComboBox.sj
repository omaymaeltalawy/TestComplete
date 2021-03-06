//USEUNIT Private_ComboBox
//USEUNIT Private_Utils
var gitem;

/** @function
 * @name Common_Combobox.ComboBoxEnabled
 * @description Tells whether the combobox is enabled
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 */
function ComboBoxEnabled(ComboBox) {
  Log.AppendFolder("Common_Combobox.ComboBoxItemSelected");
  var enabled = Private_ComboBox.initWrapper(ComboBox).IsEnabled();
  Log.PopLogFolder();
  return enabled;
}
/** 
 * @function
 * @name Common_Combobox.SelectComboBoxItem
 * @description Select an Item of Combobox.
 * @param {Object} combobox  TestComplete's object containing a combobox.
 * @param {string} item    The name of the item to be selected.
 */
function SelectComboBoxItem(ComboBox, Item) {
  try {
    Log.AppendFolder("Common_Combobox.SelectComboBoxItem");
    var foundItem = Private_ComboBox.initWrapper(ComboBox).FindItem(Item);
    if (foundItem.length === 0) {
      Log.Error("ComboBox item '" + Item + "' does not exists.");
      return;
    }
    gitem = foundItem[0];
    gitem.Click();
    Log.Message("ComboBox item '" + foundItem[0].GetValue() + "' was clicked.");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** 
 * @function
 * @name Common_Combobox.ComboBoxItemsExists
 * @description Check if the Combobox Contains an Array of Items in Visionael Product.
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 * @param {Array} ItemList   Names of items to be checked.
 */
function ComboBoxItemsExists(ComboBox, ItemList) {
  try {
    Log.AppendFolder("Common_Combobox.ComboBoxItemsExists");
    if (Object.prototype.toString.call(ItemList) !== '[object Array]') {
      ItemList = [ItemList];
    }
    var wrapper, foundItem, arr, i;
    wrapper = Private_ComboBox.initWrapper(ComboBox);
    arr = [];
    for (i = 0; i < ItemList.length; i++) {
      foundItem = wrapper.FindItem(ItemList[i]);
      if (foundItem.length === 0) {
        return false;
      }
      arr.push(foundItem[0].GetValue());
    }
    gitem = arr;
    return true;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** 
 * @function
 * @name Common_Combobox.ComboBoxItemSelected
 * @description Check if the combobox item is selected
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 * @param {string} Item    The name of the item to be checked
 */
function ComboBoxItemSelected(ComboBox, Item) {
  try {
    Log.AppendFolder("Common_Combobox.ComboBoxItemSelected");
    var foundItem, selectedItem;
    foundItem = Private_ComboBox.initWrapper(ComboBox).FindItem(Item);
    if (foundItem.length === 0) {
      Log.Error("Item '" + Item + "' not found in the combobox object.");
      return false;
    }

    selectedItem = Private_Utils.COMMON_REPOSITORY.Objects.Arrays.FirstOrDefault(foundItem, function (item) {
      return item.IsSelected();
    });

    if (selectedItem !== null) {
      gitem = selectedItem.GetValue();
      return true;
    }
    return false;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return false;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
 * @name Common_Combobox.VerifyComboBoxEnabled
 * @description Verify if the combobox is enabled
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 */
function VerifyComboBoxEnabled(ComboBox) {
  if (ComboBoxEnabled(ComboBox)) {
    Log.Message("The combobox is enabled.");
  } else {
    Log.Error("The combobox is not enabled.");
  }
}
/** 
 * @function
 * @name Common_Combobox.VerifyComboBoxItemsExists
 * @description Verify if the Combobox Contains an Array of Items in Visionael Product.
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 * @param {Array} ItemList   Names of items to be verified.
 */
function VerifyComboBoxItemsExists(ComboBox, ItemList) {
  if (ComboBoxItemsExists(ComboBox, ItemList)) {
    Log.Message("ComboBox item '" + gitem + "' exists.");
  } else {
    Log.Error("ComboBox item '" + ItemList + "' not exists");
  }
  gitem = null;
}
/** @function
 * @name Common_Combobox.VerifyComboBoxItemSelected
 * @description Verify if the combobox item is selected
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 * @param {string} Item    The name of the item to be verified.
 */
function VerifyComboBoxItemSelected(ComboBox, Item) {
  if (ComboBoxItemSelected(ComboBox, Item)) {
    Log.Message("The given item: " + gitem + " is selected.");
  } else {
    Log.Error("The given item: " + Item + " is not selected.");
  }
  gitem = null;
}
/** 
 * @function
 * @name Common_Combobox.VerifyComboBoxItemsNotExists
 * @description Verify if the Combobox Contains an Array of Items in Visionael Product.
 * @param {Object} ComboBox  TestComplete's object containing a combobox.
 * @param {Array} ItemList   Names of items to be verified.
 */
function VerifyComboBoxItemsNotExists(ComboBox, ItemList) {
  if (!ComboBoxItemsExists(ComboBox, ItemList)) {
    Log.Message("ComboBox item '" + gitem + "' not exists.");
  } else {
    Log.Error("ComboBox item '" + ItemList + "' exists.");
  }
  gitem = null;
}