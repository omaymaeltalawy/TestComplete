//USEUNIT Private_MenuBar

/** 
* Click Menu Items.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to click, use as "A|B|C"
* @sample - ClickMenubarItem(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function ClickMenubarItem(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.ClickMenubarItem");
    var MenuItem = Private_MenuBar.initWrapper(Menubar).findItem(Item);
    if(MenuItem == null) Log.Error("Can not find the Menu '"+Item+"'.");
    MenuItem.click();
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}

/** 
* Check if Menu items exists.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to check, use as "A|B|C".
* @return {Boolean} - true for menuitem exists, false for not exists.
* @sample - MenubarItemExists(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function MenubarItemExists(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.MenubarItemExists");
    return Private_MenuBar.initWrapper(Menubar).findItem(Item) != null;
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}

/** 
* Verify Menu items exists.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to verify, use as "A|B|C".
* @sample - VerifyMenubarItemExists(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function VerifyMenubarItemExists(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.VerifyMenubarItemExists");
    if(MenubarItemExists(Menubar, Item))
      Log.Checkpoint("The Menu Items '"+Item+"' exists.");
    else Log.Error("The Menu Items '"+Item+"' NOT exists.")
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}

/** 
* Check if Menu items enabled.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to check, use as "A|B|C".
* @return {Boolean} - true for menuitem enabled, false for not enabled.
* @sample - MenubarItemEnabled(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function MenubarItemEnabled(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.MenubarItemEnabled");
    var MenuItem = Private_MenuBar.initWrapper(Menubar).findItem(Item);
    if(MenuItem == null) Log.Error("Can not find the Menu '"+Item+"'.");
    return MenuItem.isEnabled();
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}

/** 
* Verify Menu items Enabled.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to verify, use as "A|B|C".
* @sample - VerifyMenubarItemEnabled(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function VerifyMenubarItemEnabled(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.VerifyMenubarItemEnabled");
    if(MenubarItemEnabled(Menubar, Item))
      Log.Checkpoint("The Menu Items '"+Item+"' enabled.");
    else Log.Error("The Menu Items '"+Item+"' NOT enabled.")
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}

/** 
* Verify Menu items Not exists.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to verify, use as "A|B|C".
* @sample - VerifyMenubarItemNotExists(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function VerifyMenubarItemNotExists(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.VerifyMenubarItemNotExists");
    if(!MenubarItemExists(Menubar, Item))
      Log.Checkpoint("The Menu Items '"+Item+"' NOT exists.");
    else Log.Error("The Menu Items '"+Item+"' exists.")
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}
/** 
* Verify Menu items Not Enabled.
* @param {Object} Menubar - The control object of Menubar. 
* @param {String} Item - The menu items need to verify, use as "A|B|C".
* @sample - VerifyMenubarItemNotEnabled(Menubar, "Edit|System Tables|This Window")
* @autor Tang Liping <tang.liping@gteamstaff.com>
* @creation 12/18/2013
*/
function VerifyMenubarItemNotEnabled(Menubar, Item)
{
  try {
    Log.AppendFolder("Common_MenuBar.VerifyMenubarItemNotEnabled");
    if(!MenubarItemEnabled(Menubar, Item))
      Log.Checkpoint("The Menu Items '"+Item+"' NOT enabled.");
    else Log.Error("The Menu Items '"+Item+"' enabled.")
  }
   catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e); 
    return;
   }
   finally { Log.PopLogFolder(); }
}