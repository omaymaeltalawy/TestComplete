//USEUNIT Common_Calendar
//USEUNIT Private_Log
//USEUNIT Private_SchedulingGrid
//#QBV:Common script does not fit for this kind of Grid that ObjectType = "Table" && className = "GMMainTable", so here need use custom script
/**
@class Common_SchedulingGrid
*/
/**
 *  @function
 *  @description Verify if grid row exists.
 *  @name Common_SchedulingGrid.GridRowExists
 *  @param {TODO} control TestComplete's object containing a grid.
 *  @param {TODO} params search parameters in json representation.
 *  @returns {boolean} Grid row exists.
 *  @author tyler.libei
 *  @modified 06/20/ 2014
 */
function GridRowExists(control, params) {
    try {
        Log.AppendFolder("Common_SchedulingGrid.GridRowExists");
        var w, r;
        if (typeof params === "string") {
            params = eval("(" + params + ")");
        }
        w = Private_SchedulingGrid.initWrapper(control);
        r = w.findRows(params, 1);
        if (r === null) {
            return false;
        }
        return true;
    } catch (e) {
        Log.Error("Oops! There's some glitch in the script: " + e);
        return;
    } finally {
        Log.PopLogFolder();
    }
}
/**
 *  @function
 *  @description Verify if grid row exists. Write a log message.
 *  @name Common_SchedulingGrid.VerifyGridRowExists
 *  @param {TODO} control TestComplete's object containing a grid.
 *  @param {TODO} params search parameters in json representation.
 *  @returns {void}
 *  @author tyler.libei
 *  @modified 06/26/ 2014
 */
function VerifyGridRowExists(control, params) {
    if (GridRowExists(control, params)) {
        Log.Checkpoint("Row with values '" + Private_Log.VarToStr(params) + "' exists");
    } else {
        Log.Error("Row with values '" + Private_Log.VarToStr(params) + "' NOT exists");
    }
}
/**
*  @function
*  @description check if Grid row exists
*  @name Common_SchedulingGrid.GridMultipleRowExists
*  @param {object} control grid contains row
*  @param {string} paramsLeft left part of grid row exists
*  @param {string} paramsRight right part of grid row exits
*  @returns {boolean}if row exists return true, or return false
*  @example GridMultipleRowExists(object,
                                  "[{"Name": "Team Member"},{"Name": "General","Role":"Team Member","Booking Type":"Hard Booked"}]")
                                  "{"05/19":"0.20"}"
*  @author tyler.libei
*  @modified 06/26/ 2014
*/
function GridMultipleRowExists(control, paramsLeft, paramsRight) {
    try {
        Log.AppendFolder("Common_SchedulingGrid.GridMultipleRowExists");
        var w, r, i, RightRowExists, LeftCell, rowIndex;
        if (typeof paramsLeft === "string") {
            paramsLeft = eval("(" + paramsLeft + ")");
        }
        w = Private_SchedulingGrid.initWrapper(control);
        r = w.findRows(paramsLeft, 1);
        if (typeof paramsRight === "string") {
            paramsRight = eval("(" + paramsRight + ")");
        }
        for (i = 0; i < r.length; i++) {
            LeftCell = r[i].control.body.Parent;
            if (LeftCell.ObjectType !== "Cell") {
                continue;
            }
            rowIndex = LeftCell.RowIndex;
            RightRowExists = w.IsRightRowsExists(paramsRight, rowIndex, 1, 0);
            if (RightRowExists !== null) {
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
//#QBV:Common script does not supprot this object type and object method not fit for this kind of Grid.
//@classname
/**
*  @function
*  @description check if Grid row exists
*  @name Common_SchedulingGrid.VerifyGridMultipleRowExists
*  @param {object} control grid contains row
*  @param {string} paramsLeft left part of grid row exists
*  @param {string} Date  start day
*  @param {string} day   the weekday to set
*  @param {string} Value Column value
*  @returns {void}
*  @example VerifyGridMultipleRowExists(object,
                                  "[{"Name": "Team Member"},{"Name": "General","Role":"Team Member","Booking Type":"Hard Booked"}]")
                                  aqDateTime.Today(), 1, 0.20)
*  @author tyler.libei
*  @modified 06/26 /2014
*/
function VerifyGridMultipleRowExists(control, paramsLeft, Date, day, Value) {
    var paramsRight, columndate;
    columndate = aqConvert.DateTimeToFormatStr(Common_Calendar.GetComingDate(Date, day), "%m/%d");
    paramsRight = "{" + "\"" + columndate + "\"" + ":" + "\"" + Value + "\"" + "}";
    if (GridMultipleRowExists(control, paramsLeft, paramsRight)) {
        Log.Checkpoint("Row with values '" + Private_Log.VarToStr(paramsLeft) + Private_Log.VarToStr(paramsRight) + "' exists");
    } else {
        Log.Error("Row with values '" + Private_Log.VarToStr(paramsLeft) + Private_Log.VarToStr(paramsRight) + "' NOT exists");
    }
}
/**
 *  @function
 *  @description click checkbox
 *  @name Common_SchedulingGrid.ClickCheckBoxInRow
 *  @param {Object} control - TestComplete's object containing a grid.
 *  @param {String} params1 - search parameters in json representation.
 *  @param {String} params2 - search sub parameters in json representation.
 *  @expand {Boolean} Expand - need Expand or not
 *  @returns {void}
 *  @modified 14*/
function ClickCheckBoxInRow(control, params1, params2) {
 try {
        Log.AppendFolder("Common_SchedulingGrid.ClickCheckBoxInRow");
        var w, LeftCell, rowIndex,ParentObject,expandObject, leftObject, leftRow;
        if (typeof params1 === "string") {
            params1 = eval("(" + params1 + ")");
        }
        w = Private_SchedulingGrid.initWrapper(control);
        if (typeof params2 === "string") {
            params2 = eval("(" + params2 + ")");
        }
        LeftCell = w.GetRows(params1, 1, 0);
        if (LeftCell === null) {
            Log.Error("can not find row value '" + params1 + "'");
        }
        rowIndex = LeftCell.RowIndex ;
        Aliases.Browser.Page_TenroxEnterpriseMain.Panel_Right.Panel_Main.Panel_MyWorkPlan.Panel_Main.Panel_Table.Panel_TableLeft.Table_Main.Cell(rowIndex, 2).Click();   
        ParentObject = Aliases.Browser.Page_TenroxEnterpriseMain.Panel_Right.Panel_Main.Panel_MyWorkPlan.Panel_Main.Panel_Table.Panel_TableLeft.Table_Main.Cell(rowIndex,1);
        if (ParentObject ===null) {} else{ ParentObject.Click();return  true;};
        
    } catch (e) {
        Log.Error("Oops! There's some glitch in the script: " + e);
        return;
    } finally {
        Log.PopLogFolder();
    }
}
/**
 *  @function
 *  @description Verify if grid row exists.
 *  @name Common_SchedulingGrid.ClickRGridCell
 *  @param {TODO} control TestComplete's object containing a grid.
 *  @param {TODO} params search parameters in json representation.
 *  @returns {boolean} Grid row exists.
 *  @author tyler.libei
 *  @modified 06/20/ 2014
 */
function ClickRGridCell(control, params,column,x,y,keys) {

    try {
        Log.AppendFolder("Common_SchedulingGrid.ClickRGridCell");
        var  g,w,c, r;
        if (typeof params === "string") {
            params = eval("(" + params + ")");
        }
        g = Private_SchedulingGrid.initWrapper(control);
        
        r = g.findRows(params, 1);
        if (r.length === 0) {
          Log.Error("Row with specified parameters not found");
        }
        c = g.findColumn(column);
        if (c === null) {
          Log.Error("Column '" + column + "' NOT exists");
        }
 Aliases.Browser.Page_TenroxEnterpriseMain.Panel_Right.Panel_Main.Panel_MyWorkPlan.Panel_Main.Panel_Table.Panel_TableLeft.Table_Main.Cell(r[0].index+1, c.index).HoverMouse();       
 Aliases.Browser.Page_TenroxEnterpriseMain.Panel_Right.Panel_Main.Panel_MyWorkPlan.Panel_Main.Panel_Table.Panel_TableLeft.Table_Main.Cell(r[0].index+1, c.index).ClickR() ;      
     
        return true;
    } catch (e) {
        Log.Error("Oops! There's some glitch in the script: " + e);
        return;
    } finally {
        Log.PopLogFolder();
    }
}
/**
 *  @function
 *  @description Verify if grid row exists.
 *  @name Common_SchedulingGrid.ClickExpandCell
 *  @param {TODO} control TestComplete's object containing a grid.
 *  @param {TODO} params search parameters in json representation.
 *  @returns {boolean} Grid row exists.
 *  @author tyler.libei
 *  @modified 06/20/ 2014
 */
function ClickExpandCell(RowIndex) {
 Aliases.Browser.Page_TenroxEnterpriseMain.Panel_Right.Panel_Main.Panel_MyWorkPlan.Panel_Main.Panel_Table.Panel_TableLeft.Table_Main.Cell(RowIndex, 2).Click();   

}