//USEUNIT Private_Utils
//USEUNIT Common_ComboBox

/**
*	@function
*	@description This is the main TimeSheet Class 
*	@name Private_TimeSheet.TimeSheet
*	@param {Object} control TimeSheet Object
*	@author Ahmed Galal <ahmed_galal@devfactory.com>
*	@modified 01/30/14
*/
function TimeSheet(control) {
  if (control === undefined || control === null) {
    Log.Error("'control' parameter must be provided and cannot be null.");
    return;
  }
  if (control.ObjectType === "Panel" && control.ObjectIdentifier === "daTaskTimeEntry") {
    control = control.FindChild("ObjectType", "Table", 2);
  }
  if (control.ObjectType === "Panel" && control.ObjectIdentifier.indexOf("TSControl") !== -1) {
    control = control.FindChild("ObjectType", "Table");
  }
  if (!control.Exists || control.ObjectType !== "Table" || control.Parent.ObjectIdentifier.indexOf("TSControl") === -1) {
    Log.Error("'control' parameter does not match with a TimeSheet editor.");
  }
  this.InnerControl = TimeSheet;
  this.GetTimeSheetTable = function (TableName) {
    var id, headers = [], bodies = [], footers = [], i, header, bodyPanel, body, footer;
    id = null;
    switch (TableName) {
    case "In/Out Times":
      id = "Attendance";
      break;
    case "Assignments":
      id = "TaskTimeEntry";
      break;
    case "Non-Working Time":
      id = "NonWorkingTimeEntry";
      break;
    case "Adjustments":
      id = "TaskTimeEntry_Adjustment";
      break;
    }
    if (id === null) {
      return null;
    }
    for (i = 0; i < 3; i++) {
      header = control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", id + "_Header_" + i + "_*"], 5);
      headers.push(header);
      bodyPanel = control.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", id + "_Body_" + i + "_*"], 5);
      if (bodyPanel.Exists) {
        body = bodyPanel.FindChild("ObjectType", "Table");
        bodies.push(body);
      }
      footer = control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", id + "Footer_" + i + "_*"], 6);
      footers.push(footer);
    }
    if (headers.length === 0 || headers.length !== bodies.length || headers.length !== footers.length) {
      return null;
    }
    return new TimeSheetTable(control, TableName, headers, bodies, footers);
  };
  this.GetTotalTable = function () {
    var headers = [], bodies = [], footers = [], i, header, body, footer;
    for (i = 0; i < 3; i++) {
      header = control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*_Header_" + i + "_*"], 5);
      headers.push(header);
      body = {
        Exists: false
      };
      bodies.push(body);
      footer = control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "TimeFooter_" + i + "_*"], 5);
      footers.push(footer);
    }
    if (headers.length === 0 || headers.length !== bodies.length || headers.length !== footers.length) {
      return null;
    }
    return new TimeSheetTable(control, "%total%", headers, bodies, footers);
  };
}

/**
*	@function
*	@description This is the main TimeSheet Sub Table Class 
*	@name Private_TimeSheet.TimeSheetTable
*	@param {Object} TimeSheet TimeSheet Object
*	@param {String} TableName The Sub Table name inside the timesheet
*	@param {Object} Headers Object
*	@param {Object} Bodies Object
*	@param {Object} Footers Object
*	@author Ahmed Galal <ahmed_galal@devfactory.com>
*	@modified 01/30/14
*/
function TimeSheetTable(TimeSheet, TableName, Headers, Bodies, Footers) {
  var that;
  that = this;
  this.TimeSheet = TimeSheet;
  this.Name = TableName;

  function IsDoubleCell(Table) {
    return aqString.Find(Table.Parent.ObjectIdentifier, "Attendance_Body") !== -1;
  };
  this.GetBodyRowCount = function () {
    var res;
    if (!Bodies[0].Exists) {
      return 0;
    }
    res = Bodies[0].RowCount - 1;
    if (IsDoubleCell(Bodies[0])) {
      res *= 2;
    }
    return res;
  };
  this.GetRowCount = function () {
    var res;
    res = that.GetBodyRowCount();
    if (Footers[0].Exists) {
      res += Footers[0].RowCount - 1;
    }
    return res;
  };
  this.GetRowId = function (SearchParameters) {
    var res;
    res = that.GetRowIds(SearchParameters);
    return res.length !== 0 ? res[0] : -1;
  };
  this.GetRowIds = function (SearchParameters) {
    var ids = [], rowCount, rowId, found, Index, cell, match, dateStr;
    rowCount = that.GetRowCount();
    for (rowId = 0; rowId < rowCount; rowId++) {
      found = true;
      for (Index in SearchParameters) {
        cell = that.GetCellByColumnName(SearchParameters[Index][0], rowId);
        if (cell === null) {
          found = false;
          break;
        }
        dateStr = aqString.StrMatches("[0-9]+\/[0-9]+", SearchParameters[Index][0]);
        match = !Private_Utils.StringMatches(cell.GetValue(), SearchParameters[Index][1]);
        if (match && cell.GetValue() === "00:00" && dateStr && aqDateTime.GetDayOfWeek(SearchParameters[Index][0]) === 3) {
          match = !Private_Utils.StringMatches("", SearchParameters[Index][1]);
        }
        if (match) {
          found = false;
          break;
        }
      }
      if (found) {
        ids.push(rowId);
      }
    }
    return ids;
  };
  this.GetNewRowId = function () {
    var wrapper, cell;
    wrapper = Bodies[0].FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*_wrapper"], 2);
    if (!wrapper.Exists) {
      return -1;
    }
    cell = Private_Utils.GetParentByType(wrapper, "Cell");
    return cell.RowIndex - 1;
  };
  this.FindCell = function (SearchParameters, Column) {
    var rowId;
    rowId = that.GetRowId(SearchParameters);
    if (rowId === -1) {
      return null;
    }
    return that.GetCellByColumnName(Column, rowId);
  };
  this.FindColumn = function (ColumnName) {
    return GetColumnId_0(ColumnName) !== -1 || GetColumnId_1(ColumnName) !== -1 || GetColumnId_2(ColumnName) !== -1;
  };
  this.GetCellByColumnName = function (ColumnName, RowId) {
    var tableId, ColumnId, bodyRowCount;
    tableId = -1;
    ColumnId = GetColumnId_0(ColumnName);
    if (ColumnId !== -1) {
      tableId = 0;
    } else {
      ColumnId = GetColumnId_1(ColumnName);
      if (ColumnId !== -1) {
        tableId = 1;
      } else {
        ColumnId = GetColumnId_2(ColumnName);
        if (ColumnId !== -1) {
          tableId = 2;
        }
      }
    }
    bodyRowCount = that.GetBodyRowCount()
    return (bodyRowCount > RowId) ? GetCell(Bodies[tableId], ColumnId, RowId) : GetCell(Footers[tableId], ColumnId, RowId - bodyRowCount);
  };

  function GetColumnId_0(Column) {
    var columnCount, cell, i;
    if (Column == undefined || Column == null || Column == "") {
      return 0;
    }
    columnCount = Headers[0].ColumnCount(2);
    for (i = 1; i < columnCount; i++) {
      cell = Headers[0].FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 2, i]);
      if (Private_Utils.StringMatches(cell.contentText, Column)) {
        return i;
      }
    }
    return -1;
  };

  function GetColumnId_1(Column) {
    var columnCount, i, dayCell, dateCell, day, date;
    columnCount = Headers[1].ColumnCount(1);
    for (i = 0; i < columnCount; i++) {
      dayCell = Headers[1].FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 1, i]);
      dateCell = Headers[1].FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 2, i]);
      day = dayCell.contentText;
      date = dateCell.contentText;
      if (Column === day || Column === date || Column === day + " " + date) {
        return i;
      }
    }
    return -1;
  };

  function GetColumnId_2(Column) {
    var cell;
    if (Column === "Total") {
      //Total footer may have any header
      if (TableName === "%total%") {
        return 0;
      }
      cell = Headers[2].FindChild(["ObjectType", "contentText"], ["Cell", "Total"]);
      if (cell.Exists) {
        return 0;
      }
    }
    return -1;
  };

  function GetCell(Table, ColumnId, RowId) {
    //Double cell
    var isDoubleCell, rowId, cell;
    isDoubleCell = IsDoubleCell(Table);
    rowId = isDoubleCell ? Math.floor(RowId / 2) + 1 : RowId + 1;
    cell = Table.FindChild(["ObjectType", "ColumnIndex", "RowIndex"], ["Cell", ColumnId, rowId]);
    return cell.Exists ? isDoubleCell ? new DoubleCellClass(that, cell, ColumnId, RowId) : new CellClass(that, cell, ColumnId, RowId) : null;
  };
}

/**
*	@function
*	@description This is the main TimeSheet Sub Table Cell Class 
*	@name Private_TimeSheet.TimeSheetTable
*	@param {Object} Table TimeSheet Object
*	@param {Object} Cell The Sub Table name inside the timesheet
*	@param {Int} ColumnId Cell Columns Id
*	@param {Int} RowId Cell Row Id
*	@author Ahmed Galal <ahmed_galal@devfactory.com>
*	@modified 01/30/14
*/
function CellClass(Table, Cell, ColumnId, RowId) {
  var that, textarea, textbox, checkbox, combobox;
  that = this;
  this.GetValue = function () {
    textarea = Cell.FindChild("ObjectType", "Textarea");
    if (textarea.Exists) {
      return textarea.contentText;
    }
    textbox = Cell.FindChild("ObjectType", "Textbox", 2);
    if (textbox.Exists) {
      return textbox.Text;
    }
    checkbox = Cell.FindChild("ObjectType", "Checkbox", 2);
    if (checkbox.Exists) {
      return checkbox.status;
    }
    combobox = Cell.FindChild(["ObjectType", "className"], ["Panel", "ComboBox_Tenrox"], 3);
    if (combobox.Exists) {
      return combobox.wText;
    }
    return Cell.contentText;
  };
  this.SetValue = function (Value) {
    textbox = Cell.FindChild("ObjectType", "Textbox");
    if (textbox.Exists) {
      that.Click();
      textarea = Cell.FindChild("ObjectType", "Textarea");
      if (textarea.Exists) {
        if (Value === null || Value === undefined) {
          Value = "";
        }
        if (Value.toString().indexOf("[Tab]") === -1) {
          Value += "[Tab]";
        }
        textarea.Keys("[End]![Home][Del]" + Value);
      }
    }
    checkbox = Cell.FindChild("ObjectType", "Checkbox", 2);
    if (checkbox.Exists) {
      checkbox.ClickChecked(Value);
      return;
    }
    combobox = Cell.FindChild(["ObjectType", "className"], ["Panel", "ComboBox_Tenrox"], 3);
    if (combobox.Exists) {
      // Replace it with our code: Common_Combobox_EnterprisePortal.SelectComboboxItem(combobox, Value);
      Common_ComboBox.SelectComboBoxItem(combobox, Value);
      return;
    }
  };
  this.GetButton = function (ButtonTitle) {
    var image;
    image = Cell.FindChild(["ObjectType", "title"], ["Image", ButtonTitle], 3);
    return image.Exists ? image : null;
  };
  this.Click = function () {
    Cell.Click();
  };
  // For inputting the value in the cell without Tab
  this.SetValueWithoutTab = function (Value) {
    textbox = Cell.FindChild("ObjectType", "Textbox");
    if (textbox.Exists) {
      that.Click();
      textarea = Cell.FindChild("ObjectType", "Textarea");
      if (textarea.Exists) {
        if (Value === null || Value === undefined) {
          Value = "";
        }
        if (Value.toString().indexOf("[Tab]") === -1) {
          Value;
        }
        textarea.Keys("[End]![Home][Del]" + Value);
      }
    }
    checkbox = Cell.FindChild("ObjectType", "Checkbox", 2);
    if (checkbox.Exists) {
      checkbox.ClickChecked(Value);
      return;
    }
    combobox = Cell.FindChild(["ObjectType", "className"], ["Panel", "ComboBox_Tenrox"], 3);
    if (combobox.Exists) {
      // Replace it with our code: Common_Combobox_EnterprisePortal.SelectComboboxItem(combobox, Value);
      Common_ComboBox.SelectComboBoxItem(combobox, Value);
      return;
    }
  };
  this.GetButton = function (ButtonTitle) {
    var image;
    image = Cell.FindChild(["ObjectType", "title"], ["Image", ButtonTitle], 3);
    return image.Exists ? image : null;
  };
  this.Click = function () {
    Cell.Click();
  };
}


/**
*	@function
*	@description This is the main TimeSheet Sub Table Cell Class 
*	@name Private_TimeSheet.TimeSheetTable
*	@param {Object} Table TimeSheet Object
*	@param {Object} Cell The Sub Table name inside the timesheet
*	@param {Int} ColumnId Cell Columns Id
*	@param {Int} RowId Cell Row Id
*	@author Ahmed Galal <ahmed_galal@devfactory.com>
*	@modified 01/30/14
*/
function DoubleCellClass(Table, Cell, ColumnId, RowId) {
  var textarea, textboxAttrib, textbox;
  //Using Cell as base class
  CellClass.apply(this, arguments);
  this.GetValue = function () {
    textarea = Cell.FindChild("ObjectType", "Textarea");
    if (textarea.Exists) {
      if ((textarea.offsetTop === 2 && (RowId % 2 === 0)) || (textarea.offsetTop === 23 && (RowId % 2 === 1))) {
        return textarea.contentText;
      }
    }
    if (Cell.contentText === "IN\nOUT") {
      return RowId % 2 === 0 ? "IN" : "OUT";
    }
    textboxAttrib = "* pos=\"" + (RowId % 2) + "\"*";
    textbox = Cell.FindChild(["ObjectType", "outerHTML"], ["Textbox", textboxAttrib]);
    if (textbox.Exists) {
      return textbox.Text;
    }
    return "";
  };
  this.Click = function () {
    var x, y;
    x = Cell.Width / 2;
    y = ((RowId % 2) === 0) ? Cell.Height / 4 : Cell.Height * 3 / 4;
    Cell.Click(x, y);
  };
}

/**
*	@function
*	@description Convert JSON String into Array Format
*	@name Private_TimeSheet.renderStringAsArray
*	@param {String} JSONString Input string in JSON Format
*	@returns {TODO}
*	@example renderStringAsArray("{Col1":"Cell1"}")
*	@author Ahmed Galal <ahmed_galal@devfactory.com>
*	@modified 01/30/14
*/
function renderStringAsArray(JSONString) {
  var outputArray = [], key;
  JSONString = eval("(" + JSONString + ")");
  for (key in JSONString) {
    outputArray.push([]);
    outputArray[outputArray.length - 1].push(key);
    outputArray[outputArray.length - 1].push(JSONString[key]);
  }
  return outputArray;
}