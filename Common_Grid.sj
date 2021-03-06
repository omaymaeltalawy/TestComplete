//USEUNIT Private_Grid
//USEUNIT Private_Log
/**
 * @class Common_Grid
 */
/** @function
    
    @name Common_Grid.GridColumnExists
    
    @description Check is a grid column exists.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to check.
    
    @returns {boolean} Grid column exists.
*/
function GridColumnExists(control, column) {
  try {
    Log.AppendFolder("Common_Grid.GridColumnExists");
    return Private_Grid.initWrapper(control).findColumn(column) !== null;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridColumnExists
    
    @description Check is a grid column exists. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to check.
*/
function VerifyGridColumnExists(control, column) {
  if (GridColumnExists(control, column)) {
    Log.Checkpoint("Column '" + Private_Log.VarToStr(column) + "' exists");
  } else {
    Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
  }
}
/** @function
    
    @name Common_Grid.VerifyGridColumnNotExists
    
    @description Check is a grid column exists. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to check.
*/
function VerifyGridColumnNotExists(control, column) {
  if (!GridColumnExists(control, column)) {
    Log.Checkpoint("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
  } else {
    Log.Error("Column '" + Private_Log.VarToStr(column) + "' exists");
  }
}
/** @function
    
    @name Common_Grid.ClickGridColumn
    
    @description Clicks grid column.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function ClickGridColumn(control, column, x, y, keys) {
  var c;
  try {
    Log.AppendFolder("Common_Grid.ClickGridColumn");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    c.click(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ClickRGridColumn
    
    @description Right click grid column.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function ClickRGridColumn(control, column, x, y, keys) {
  var c;
  try {
    Log.AppendFolder("Common_Grid.ClickRGridColumn");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    c.clickR(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.DblClickGridColumn
    
    @description Right click grid column.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function DblClickGridColumn(control, column, x, y, keys) {
  var c;
  try {
    Log.AppendFolder("Common_Grid.DblClickGridColumn");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    c.dblClick(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.HoverMouseGridColumn
    
    @description Hover mouse grid column.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
*/
function HoverMouseGridColumn(control, column, x, y) {
  var c;
  try {
    Log.AppendFolder("Common_Grid.HoverMouseGridColumn");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    c.hoverMouse(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ClickGridColumnControl
    
    @description Click on control inside column header by it's name. 
                 For example: cell with 2 buttons, we may click button by tooltip. 
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {String} controlName - Control identificator, like tooltip.
*/
function ClickGridColumnControl(control, column, controlName) {
  var c, controls, i;
  try {
    Log.AppendFolder("Common_Grid.ClickGridColumnControl");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    controls = c.__getHeader();
    if (Object.prototype.toString.call(controls) !== "[object Array]") {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no controls");
    }
    for (i = 0; i < controls.length; i++) {
      if (Private_Utils.StringMatches(controls[i].name, controlName)) {
        controls[i].object.Click();
        return;
      }
    }
    Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no control '" + Private_Log.VarToStr(controlName) + "'");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ClickRGridColumnControl
    
    @description Right click on control inside column header by it's name. 
                 For example: cell with 2 buttons, we may click button by tooltip. 
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} column - Name of the column to click.
    @param {String} controlName - Control identificator, like tooltip.
*/
function ClickRGridColumnControl(control, column, controlName) {
  var c, controls, i;
  try {
    Log.AppendFolder("Common_Grid.ClickRGridColumnControl");
    c = Private_Grid.initWrapper(control).findColumn(column);
    if (c === null) {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' NOT exists");
    }
    controls = c.__getHeader();
    if (Object.prototype.toString.call(controls) !== "[object Array]") {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no controls");
    }
    for (i = 0; i < controls.length; i++) {
      if (Private_Utils.StringMatches(controls[i].name, controlName)) {
        controls[i].object.ClickR();
        return;
      }
    }
    Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no control '" + Private_Log.VarToStr(controlName) + "'");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.GridRowExists
    
    @description Verify if grid row exists
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    
    @returns {boolean} Grid row exists.
*/
function GridRowExists(control, params) {
  try {
    Log.AppendFolder("Common_Grid.GridRowExists");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    return Private_Grid.initWrapper(control).findRows(params, 1).length !== 0;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridRowExists
    
    @description Verify if grid row exists. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function VerifyGridRowExists(control, params) {
  if (GridRowExists(control, params)) {
    Log.Checkpoint("Row with values '" + Private_Log.VarToStr(params) + "' exists");
  } else {
    Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' NOT exists");
  }
}
/** @function
    
    @name Common_Grid.VerifyGridRowNotExists
    
    @description Verify if grid row not exists. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function VerifyGridRowNotExists(control, params) {
  if (!GridRowExists(control, params)) {
    Log.Checkpoint("Row with values '" + Private_Log.VarToStr(params) + "' not exists");
  } else {
    Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' exists");
  }
}
/** @function
    
    @name Common_Grid.GridAllRowsExists
    
    @description Verify if all grid rows have provided values.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    
    @returns {boolean} All grid rows contains values.
*/
function GridAllRowsExists(control, params) {
  var g, t, c, f, k, rows, i;
  try {
    Log.AppendFolder("Common_Grid.GridAllRowsExists");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    if (Object.prototype.toString.call(params) === "[object Array]") {
      params = params[0];
    }
    g = Private_Grid.initWrapper(control);
    t = {};
    for (k in params) {
      c = g.findColumn(k);
      if (c === null) {
        Log.Error("Invalid column name: " + k);
      }
      t["c_" + c.index] = params[k];
    }
    f = function (row) {
      var subRows, j;
      if (!row.__doCompare(t)) {
        return false;
      }
      subRows = row.__getSubRows();
      for (j = 0; j < subRows.length; j++) {
        if (!f(subRows[j])) {
          return false;
        }
      }
      return true;
    };
    rows = g.findRows({}, -1, 0);
    for (i = 0; i < rows.length; i++) {
      if (!f(rows[i])) {
        return false;
      }
    }
    return true;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridAllRowsExists
    
    @description Verify if all grid rows have provided values. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function VerifyGridAllRowsExists(control, params) {
  if (GridAllRowsExists(control, params)) {
    Log.Checkpoint("All rows contains values '" + Private_Log.VarToStr(params) + "'");
  } else {
    Log.Error("Not all rows contains values '" + Private_Log.VarToStr(params) + "'");
  }
}
/** @function
    
    @name Common_Grid.GridRowIndex
    
    @description Verify if grid row exists by index row.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} index - row position number.
    
    @returns {boolean} Grid row exists by index row.
*/
function GridRowIndex(control, params, index) {
  var rows, i;
  try {
    Log.AppendFolder("Common_Grid.GridRowIndex");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    rows = Private_Grid.initWrapper(control).findRows(params);
    for (i = 0; i < rows.length; i++) {
      if (rows[i].index === index) {
        return true;
      }
    }
    return false;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridRowIndex
    
    @description Verify if grid row exists by index row. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} index - row position number.
*/
function VerifyGridRowIndex(control, params, index) {
  if (GridRowIndex(control, params, index)) {
    Log.Checkpoint("Row with values '" + Private_Log.VarToStr(params) + "' have index = " + index);
  } else {
    Log.Error("Row with values '" + Private_Log.VarToStr(params) + "'  NOT have index = " + index);
  }
}
/** @function
    
    @name Common_Grid.ClickGridCell
    
    @description Click on Grid Cell
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function ClickGridCell(control, params, column, x, y, keys) {
  var g, r, c;
  try {
    Log.AppendFolder("Common_Grid.ClickGridCell");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    r[0].__getCells()[c.index].click(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ClickRGridCell
    
    @description Right click on Grid Cell
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.    
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function ClickRGridCell(control, params, column, x, y, keys) {
  var g, r, c;
  try {
    Log.AppendFolder("Common_Grid.ClickRGridCell");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    r[0].__getCells()[c.index].clickR(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.DblClickGridCell
    
    @description Double click on Grid Cell
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.
    @param {Object} keys - Keys to press during click. For more details see TestComplete help; Optional.
*/
function DblClickGridCell(control, params, column, x, y, keys) {
  var g, r, c;
  try {
    Log.AppendFolder("Common_Grid.DblClickGridCell");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    r[0].__getCells()[c.index].dblClick(x, y, keys);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.HoverMouseGridCell
    
    @description Hover mouse on Grid Cell
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.
    @param {Integer} x - x coordinate to click on cell, by default -1; Optional.
    @param {Integer} y - y coordinate to click on cell, by default -1; Optional.    
*/
function HoverMouseGridCell(control, params, column, x, y) {
  var g, r, c;
  try {
    Log.AppendFolder("Common_Grid.HoverMouseGridCell");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    r[0].__getCells()[c.index].hoverMouse(x, y);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ClickGridCellControl
    
    @description Click on control inside cell by it's name. 
                 For example: cell with 2 buttons, we may click button by tooltip. 
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - Search parameters in json representation.
    @param {String} column - Name of the column.
    @param {String} controlName - Control identificator, like tooltip.
*/
function ClickGridCellControl(control, params, column, controlName) {
  var g, r, c, controls, i;
  try {
    Log.AppendFolder("Common_Grid.ClickGridCellControl");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    controls = r[0].__getCells()[c.index].__getContent();
    if (Object.prototype.toString.call(controls) !== "[object Array]") {
      Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no controls");
    }
    for (i = 0; i < controls.length; i++) {
      if (Private_Utils.StringMatches(controls[i].value, controlName)) {
        controls[i].object.Click();
        return;
      }
    }
    Log.Error("Column '" + Private_Log.VarToStr(column) + "' have no control '" + Private_Log.VarToStr(controlName) + "'");
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.GridRowSelected
    
    @description Verify if grid row selected.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    
    @returns {boolean} Grid row selected.
*/
function GridRowSelected(control, params) {
  var r;
  try {
    Log.AppendFolder("Common_Grid.GridRowSelected");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    r = Private_Grid.initWrapper(control).findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    return r[0].isSelected();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridRowSelected
    
    @description Verify if grid row selected. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function VerifyGridRowSelected(control, params) {
  if (GridRowSelected(control, params)) {
    Log.Checkpoint("Row with values '" + Private_Log.VarToStr(params) + "' selected");
  } else {
    Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' NOT selected");
  }
}
/** @function
    
    @name Common_Grid.SetGridCellValue
    
    @description Set value in Grid Cell depends of cell control.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.
    @param {Object} value - value to set in cell.
*/
function SetGridCellValue(control, params, column, value) {
  var g, r, c;
  try {
    Log.AppendFolder("Common_Grid.SetGridCellValue");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    r[0].__getCells()[c.index].setContent(value);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.GetGridCellValue
    
    @description Get value in Grid Cell depends of cell control.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
    @param {String} column - column name.
*/
function GetGridCellValue(control, params, column) {
  var g, r, c, content;
  try {
    Log.AppendFolder("Common_Grid.GetGridCellValue");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    g = Private_Grid.initWrapper(control);
    r = g.findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with specified parameters not found");
    }
    c = g.findColumn(column);
    if (c === null) {
      Log.Error("Column '" + column + "' NOT exists");
    }
    content = r[0].__getCells()[c.index].getContent();
    if (Object.prototype.toString.call(content) !== "[object Array]") {
      return content;
    }
    return content[0].value;
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.GridRowCount
    
    @description Сhecks if grid contains Count rows.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {Integer} count - Expected number of rows.
    
    @returns {boolean} Grid is contains Count rows.
*/
function GridRowCount(control, count) {
  try {
    Log.AppendFolder("Common_Grid.GridRowCount");
    return Private_Grid.initWrapper(control).findRows({}, -1).length === aqConvert.VarToInt(count);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridRowCount
    
    @description Сhecks if grid contains Count rows. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {Integer} count - Expected number of rows.
*/
function VerifyGridRowCount(control, count) {
  if (GridRowCount(control, count)) {
    Log.Checkpoint("Grid contains " + count + " rows");
  } else {
    Log.Error("Grid not contains " + count + " rows");
  }
}
/** @function
    
    @name Common_Grid.GridEmpty
    
    @description Verify if grid empty.
    
    @param {Object} control - TestComplete's object containing a grid.
    
    @returns {boolean} Grid empty.
*/
function GridEmpty(control) {
  try {
    Log.AppendFolder("Common_Grid.GridEmpty");
    return Private_Grid.initWrapper(control).isEmpty();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.VerifyGridEmpty
    
    @description Verify if grid empty. Write a log message.
    
    @param {Object} control - TestComplete's object containing a grid.
*/
function VerifyGridEmpty(control) {
  if (GridEmpty(control)) {
    Log.Checkpoint("Grid empty");
  } else {
    Log.Error("Grid not empty");
  }
}
/** @function
    
    @name Common_Grid.CollapseGridRow
    
    @description Collapse Grid Row in a tree
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function CollapseGridRow(control, params) {
  var r;
  try {
    Log.AppendFolder("Common_Grid.CollapseGridRow");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    r = Private_Grid.initWrapper(control).findRows(params, 1);
    if (r.length === 0) {
      Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' NOT exists");
    }
    r[0].collapse();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/** @function
    
    @name Common_Grid.ExpandGridRow
    
    @description Expand Grid Row in a tree
    
    @param {Object} control - TestComplete's object containing a grid.
    @param {String} params - search parameters in json representation.
*/
function ExpandGridRow(control, params) {
  var r;
  try {
    Log.AppendFolder("Common_Grid.ExpandGridRow");
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    r = Private_Grid.initWrapper(control).findRows(params, 11);
    if (r.length === 0) {
      Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' NOT exists");
    }
    r[0].expand();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e);
    return;
  } finally {
    Log.PopLogFolder();
  }
}