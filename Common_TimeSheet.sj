//USEUNIT Private_TimeSheet
//USEUNIT Private_Utils
//USEUNIT Private_Log
/**
 *	@function
 *	@description This function check if the row exists in the TimeSheet sub Table
 *	@name Common_TimeSheet.TimeSheetTableRowExists
 *	@param {Object} control TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@returns {Bool}
 *	@example TimeSheetTableRowExists(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function TimeSheetTableRowExists(control, TableName, searchParameters) {
  var requriedSearchParameters, timeSheetObject, table;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    return false;
  }
  return table.GetRowId(requriedSearchParameters) !== -1;
}
/**
 *	@function
 *	@description This function check if the row exists in the TimeSheet sub Table
 *	@name Common_TimeSheet.VerifyTimeSheetTableRowExists
 *	@param {Object} control TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@example VerifyTimeSheetTableRowExists(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function VerifyTimeSheetTableRowExists(control, TableName, searchParameters) {
  if (TimeSheetTableRowExists(control, TableName, searchParameters)) {
    Log.Checkpoint("TimeSheet contains row with " + Private_Log.VarToStr(searchParameters) + " in table '" + TableName + "'");
  } else {
    Log.Error("TimeSheet NOT contains row with " + Private_Log.VarToStr(searchParameters) + " in table '" + TableName + "'");
  }
}
/**
 *	@function
 *	@description This function check if the TOTAL row exists in the TimeSheet
 *	@name Common_TimeSheet.TimeSheetTableTotalRowExists
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@returns {Bool}
 *	@example TimeSheetTableTotalRowExists(TimeSheetObject, "{"Col_1":"Cell_1","Col_2":"Cell_2"}")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function TimeSheetTableTotalRowExists(control, searchParameters) {
  var requriedSearchParameters, timeSheetObject, table;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTotalTable();
  if (table === null) {
    return false;
  }
  return table.GetRowId(requriedSearchParameters) !== -1;
}
/**
 *	@function
 *	@description This function check if the TOTAL row exists in the TimeSheet
 *	@name Common_TimeSheet.VerifyTimeSheetTableTotalRowExists
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@example VerifyTimeSheetTableTotalRowExists(TimeSheetObject, "{"Col_1":"Cell_1","Col_2":"Cell_2"}")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function VerifyTimeSheetTableTotalRowExists(control, searchParameters) {
  if (TimeSheetTableTotalRowExists(control, searchParameters)) {
    Log.Checkpoint("TimeSheet total contains row with specified values");
  } else {
    Log.Error("TimeSheet total NOT contains row with specified values");
  }
}
/**
 *	@function
 *	@description This function check if the row eIndex is correct
 *	@name Common_TimeSheet.TimeSheetTableRowIndex
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Index the required index of the Row
 *	@returns {Bool}
 *	@example TimeSheetTableRowIndex(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "2")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function TimeSheetTableRowIndex(control, TableName, searchParameters, Index) {
  var requriedSearchParameters, timeSheetObject, table, ids = [];
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    return false;
  }
  ids = table.GetRowIds(requriedSearchParameters);
  return Private_Utils.IndexOf(ids, Index) !== -1;
}
/**
 *	@function
 *	@description This function check if the row eIndex is correct
 *	@name Common_TimeSheet.VerifyTimeSheetTableRowIndex
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Index the required index of the Row
 *	@returns {Bool}
 *	@example VerifyTimeSheetTableRowIndex(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "2")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function VerifyTimeSheetTableRowIndex(control, TableName, searchParameters, Index) {
  if (TimeSheetTableRowIndex(control, TableName, searchParameters, Index)) {
    Log.Checkpoint("TimeSheet contains specified values in table '" + TableName + "'" + " row " + Index);
  } else {
    Log.Error("TimeSheet NOT contains specified values in table '" + TableName + "'" + " row " + Index);
  }
}
/**
 *	@function
 *	@description This function is used to set the cell value with the required value
 *	@name Common_TimeSheet.SetTimeSheetTableCellValue
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Column Required Column Name that you want to edit the cell under it
 *	@param {String} Value The required Value that you want to set it in the Cell
 *	@example SetTimeSheetTableCellValue(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "Client", "Internal")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function SetTimeSheetTableCellValue(control, TableName, searchParameters, Column, Value) {
  var requriedSearchParameters, timeSheetObject, table, cell;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    Log.Error("Table '" + TableName + "' not founded");
  }
  cell = table.FindCell(requriedSearchParameters, Column);
  if (cell === null) {
    Log.Error("Cell not found");
  }
  cell.SetValue(Value);
}

/**
 *	@function
 *	@description This function is used to set the cell value with the required value without Tab
 *	@name Common_TimeSheet.SetTimeSheetTableCellValueStrictly
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Column Required Column Name that you want to edit the cell under it
 *	@param {String} Value The required Value that you want to set it in the Cell
 *	@example SetTimeSheetTableCellValueStrictly(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "Client", "Internal")
 *	@author Abhilash Jaiswal (abhilash.jaiswal@devfactory.com)
 *	@modified 06/04/14
 */
function SetTimeSheetTableCellValueStrictly(control, TableName, searchParameters, Column, Value) {
  var requriedSearchParameters, timeSheetObject, table, cell;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    Log.Error("Table '" + TableName + "' not founded");
  }
  cell = table.FindCell(requriedSearchParameters, Column);
  if (cell === null) {
    Log.Error("Cell not found");
  }
  cell.SetValueWithoutTab(Value);
}

/**
 *	@function
 *	@description This function is used to set the new cell value with the required value
 *	@name Common_TimeSheet.SetTimeSheetTableNewRowCellValue
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Column Required Column Name that you want to edit the cell under it
 *	@param {String} Value The required Value that you want to set it in the Cell
 *	@example SetTimeSheetTableNewRowCellValue(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "Client", "Internal")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function SetTimeSheetTableNewRowCellValue(control, TableName, Column, Value) {
  var timeSheetObject, table, newRowId, cell;
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    Log.Error("Table '" + TableName + "' not founded");
  }
  newRowId = table.GetNewRowId();
  if (newRowId === -1) {
    Log.Error("Table have no row to add new values");
  }
  cell = table.GetCellByColumnName(Column, newRowId);
  if (cell === null) {
    Log.Error("Cell not found");
  }
  cell.SetValue(Value);
}
/**
 *	@function
 *	@description Click TimeSheet Sub Table Row Button
 *	@name Common_TimeSheet.ClickTimeSheetTableRowButton
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Button Required button Name
 *	@example ClickTimeSheetTableRowButton(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "Edit")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function ClickTimeSheetTableRowButton(control, TableName, searchParameters, Button) {
  var requriedSearchParameters, timeSheetObject, table, cell, button;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    Log.Error("Table '" + TableName + "' not founded");
  }
  cell = table.FindCell(requriedSearchParameters, "");
  if (cell === null) {
    Log.Error("Cell with buttons not found");
  }
  button = cell.GetButton(Button);
  if (button === null) {
    Log.Error("Button not found");
  }
  button.Click();
}
/**
 *	@function
 *	@description This function is used to set the new cell value with the required value
 *	@name Common_TimeSheet.ClickTimeSheetTableCell
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} searchParameters the search paramters that you want to reference using JSON Format
 *	@param {String} Column Required Column Name that you want to edit the cell under it
 *	@example ClickTimeSheetTableCell(TimeSheetObject, "Assignments", "{"Col_1":"Cell_1","Col_2":"Cell_2"}", "Client")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function ClickTimeSheetTableCell(control, TableName, searchParameters, Column) {
  var requriedSearchParameters, timeSheetObject, table, cell;
  requriedSearchParameters = Private_TimeSheet.renderStringAsArray(searchParameters);
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    Log.Error("Table '" + TableName + "' not founded");
  }
  cell = table.FindCell(requriedSearchParameters, Column);
  if (cell === null) {
    Log.Error("Cell not found");
  }
  cell.Click();
}
/**
 *	@function
 *	@description This function check if Column exists in the Table.
 *	@name Common_TimeSheet.TimeSheetTableColumnExists
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} column The column name need to check.
 *	@returns {Boolean} True for exists. else not
 *	@example TimeSheetTableColumnExists(TimeSheetObject, "Assignments", "Task")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function TimeSheetTableColumnExists(control, TableName, column) {
  var timeSheetObject, table;
  timeSheetObject = new Private_TimeSheet.TimeSheet(control);
  table = timeSheetObject.GetTimeSheetTable(TableName);
  if (table === null) {
    return false;
  }
  return table.FindColumn(column);
}
/**
 *	@function
 *	@description This function check if Column exists in the Table. Log pass message.
 *	@name Common_TimeSheet.VerifyTimeSheetTableColumnExists
 *	@param {Object} TimeSheet TimeSheet Object
 *	@param {String} TableName Table name inside Timesheet that you want to work on
 *	@param {String} column The column name need to check.
 *	@example VerifyTimeSheetTableColumnExists(TimeSheetObject, "Assignments", "Task")
 *	@author Ahmed M. Galal <ahmed_galal@devfactory.com>
 *	@modified 01/30/14
 */
function VerifyTimeSheetTableColumnExists(control, TableName, column) {
  if (TimeSheetTableColumnExists(control, TableName, column)) {
    Log.Checkpoint("Column '" + column + "' found in the Table '" + TableName + "'.");
  } else {
    Log.Error("Column '" + column + "' NOT found in the Table '" + TableName + "'.");
  }
}