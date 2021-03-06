//USEUNIT Private_Listbox
//USEUNIT Private_Utils
/** 
 * This function is used to select specified items in a listbox.
 * @param {Object} Listbox - The Listbox object.
 * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program".
 * @return {Boolean} - True if all the items exist in the Listbox, false otherwise.
 * @sample - SelectListboxItems(Listbox, "Resource|Program")
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
function SelectListboxItems(Listbox, Items) {
  var ItemArray, list, Index;
  try {
    Log.AppendFolder("Common_ListBox.SelectListboxItems");
    // Convert input to array
    ItemArray = Private_Utils.InputsToArray(Items);
    list = Private_Listbox.initWrapper(Listbox);
    // Loop over the specified Items array
    for (Index = 0; Index < ItemArray.length; Index++) {
      list.SelectItems(ItemArray[Index], true);
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** 
 * This function is used to check whether specified items exist in the listbox or not
 * @param {Object} Listbox - The Listbox object.
 * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program".
 * @return {Boolean} - True if all the items exist in the Listbox, false otherwise.
 * @sample - ListboxItemsExists(Listbox, "Resource|Program")
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
function ListboxItemsExists(Listbox, Items) {
  var foundedItems, ItemArray, list, Index;
  try {
    Log.AppendFolder("Common_ListBox.ListboxItemsExists");
    foundedItems = [];
    // Convert input to array
    ItemArray = Private_Utils.InputsToArray(Items);
    list = Private_Listbox.initWrapper(Listbox);

    // Loop over the specified Items array 
    for (Index = 0; Index < ItemArray.length; Index++) {
      if (list.FindItem(ItemArray[Index]) !== null) {
        foundedItems[Index] = ItemArray[Index];
      }
    }

    /* Check length of the founded Items*/
    if (foundedItems.length === ItemArray.length) {
      return true;
    }
    return false;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}


/** 
 * This function is used to verify whether specified items exist in the listbox or not.
 * @param {Object} Listbox - The Listbox object.
 * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program"
 * @sample - VerifyListboxItemsExists(Listbox, "Resource|Program")
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
function VerifyListboxItemsExists(Listbox, Items) {
  if (ListboxItemsExists(Listbox, Items)) {
    // Log message notifying all items exist
    Log.Picture(Sys.Desktop);
    Log.Message("Listbox items '" + Items + "' exist.");
    Log.Checkpoint("Listbox items '" + Items + "' exist on the Listbox.");
  } else {
    // Log error notifying all items do not exist
    Log.Error("Listbox items '" + Items + "' do not exist.");
  }
}


/** 
 * This function is used to check whether specified items are selected in the listbox or not
 * @param {Object} Listbox - The Listbox object.
 * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program"
 * @return {Boolean} - True if all the items are selected in the Listbox, false otherwise
 * @sample - ListboxItemsSelected(Listbox, "Resource|Program")
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
function ListboxItemsSelected(Listbox, Items) {
  var selectedItems, ItemArray, list, Index;
  try {
    Log.AppendFolder("Common_ListBox.ListboxItemsSelected");
    selectedItems = [];
    // Convert input to array
    ItemArray = Private_Utils.InputsToArray(Items);
    list = Private_Listbox.initWrapper(Listbox);
    // Loop over the specified Items array
    for (Index = 0; Index < ItemArray.length; Index++) {
      if (list.FindSelectedItem(ItemArray[Index]) !== null) {
        selectedItems[Index] = ItemArray[Index];
      }
    }
    /* Check length of the founded Items*/
    if (selectedItems.length === ItemArray.length) {
      return true;
    }
    return false;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** 
 * This function is used to verify whether specified items are selected in the listbox or not
 * @param {Object} Listbox - The Listbox object.
 * @param {String} Items - A list of items in forms of a '|' delimited string e.g. "Resource|Program"
 * @sample - VerifyListboxItemsSelected(Listbox, "Resource|Program")
 * @autor Carlos Almonte <carlos.almonte@gteamstaff.com>
 * @creation 1/27/2013
 */
function VerifyListboxItemsSelected(Listbox, Items) {
  if (ListboxItemsSelected(Listbox, Items)) {
    // Log message notifying specified items are selected
    Log.Picture(Sys.Desktop);
    Log.Message("Items in the Listbox are selected.");
    Log.Checkpoint("The items " + Items + "are selected on the Listbox.");
  } else {
    // Log error notifying specifying items are not selected
    Log.Error("Items in the Listbox are not selected.");
  }
}