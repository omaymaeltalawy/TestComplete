function SelectItemByName(ComboBox, itemName){
  for (i = 0; i <= ComboBox.Items.Count - 1;i++)
  {
    ComboBox.Click()
    ComboBox.SelectedIndex = i
    ComboBox.Click()   
  if (aqString.Compare(ComboBox.wText, itemName, false) == 0) 
    return true;

  ComboBox.SelectedIndex = -1

  } 
  return false;
}