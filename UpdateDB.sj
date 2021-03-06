function ClickCheckBox_DBToBeUpdatedGrid(GridObj, DBClientName)
{
  for(i = 0; i<= GridObj.wRowCount-1 ; i++)
  {
    if(aqString.Compare(GridObj.wValue(i, 1).OleValue,DBClientName, false) == 0)
    {
      GridObj.WPFObject("DataGridRow", "", i+1).WPFObject("DataGridCell", "", i+1).
      WPFObject("ContentPresenter", "", i+1).WPFObject("CheckColumn").wState = cbChecked;
      return;
    }//if  
  }//for
}

function ClickCheckBox_SelectValidationScript (GridObj, DBClientName, ValidationScriptName)
{
  for(i=0; i < Aliases.Tenrox_ProvisioningTool_WPF.
  WPFObject("HwndSource: frmMultiUpgradeClientWindow", "Multi-Upgrade for \""+DBClientName+"\"").
  WPFObject("frmMultiUpgradeClientWindow", "Multi-Upgrade for \""+DBClientName+"\"", 1).
  WPFObject("Grid", "", 1).WPFObject("ctlClientDatabaseUpgradeInstance").
  WPFObject("Grid", "", 1).WPFObject("DockPanel", "", 1).
  WPFObject("gbSelectAndSort").WPFObject("DockPanel", "", 1).
  WPFObject("ctlVerificationScriptsList").WPFObject("Grid", "", 1).
  WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).
  WPFObject("DockPanel", "", 1).WPFObject("StackPanel", "", 1).
  WPFObject("chklstLeftSide").wItemCount ; i++)
  {
    // Specify the sought-for property names
  PropArray = new Array ("ClrClassName", "WPFControlText");
  // Specify the sought-for property values
  ValuesArray = new Array ("TextBlock", ValidationScriptName);
  CheckBoxControlPanel =   Aliases.Tenrox_ProvisioningTool_WPF.
    WPFObject("HwndSource: frmMultiUpgradeClientWindow", "Multi-Upgrade for \""+DBClientName+"\"").
    WPFObject("frmMultiUpgradeClientWindow", "Multi-Upgrade for \""+DBClientName+"\"", 1).
    WPFObject("Grid", "", 1).WPFObject("ctlClientDatabaseUpgradeInstance").
    WPFObject("Grid", "", 1).WPFObject("DockPanel", "", 1).
    WPFObject("gbSelectAndSort").WPFObject("DockPanel", "", 1).
    WPFObject("ctlVerificationScriptsList").WPFObject("Grid", "", 1).
    WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).
    WPFObject("DockPanel", "", 1).WPFObject("StackPanel", "", 1).
    WPFObject("chklstLeftSide").FindAllChildren(PropArray, ValuesArray,3);
    
    CheckBoxControlPanel = (new VBArray(CheckBoxControlPanel)).toArray();

  // Log the search results
  if (CheckBoxControlPanel.length > 0)
  {
    for (i = 0; i < CheckBoxControlPanel.length; i++)
      Log.Message("FullName: " + CheckBoxControlPanel[i].FullName + "\r\n" +
                  "Text: " + CheckBoxControlPanel[i].wText);
    Log.Message("Total number of found edit buttons: " + CheckBoxControlPanel.length);
  }
  else//scroll down
  {
    Log.Warning("No edit buttons found.");
  }

    
//    Aliases.Tenrox_ProvisioningTool_WPF.WPFObject("HwndSource: frmMultiUpgradeClientWindow", "Multi-Upgrade for \"CIBER\"").WPFObject("frmMultiUpgradeClientWindow", "Multi-Upgrade for \"CIBER\"", 1).WPFObject("Grid", "", 1).WPFObject("ctlClientDatabaseUpgradeInstance").WPFObject("Grid", "", 1).WPFObject("DockPanel", "", 1).WPFObject("gbSelectAndSort").WPFObject("DockPanel", "", 1).WPFObject("ctlVerificationScriptsList").WPFObject("Grid", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("DockPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("chklstLeftSide").WPFObject("ListBoxItem", "", 51).WPFObject("StackPanel", "", 1).WPFObject("CheckBox", "", 1)
  }
}