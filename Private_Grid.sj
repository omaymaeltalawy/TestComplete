//USEUNIT Private_Utils
//USEUNIT Common_CheckBox
//USEUNIT Common_ComboBox
//USEUNIT Common_TextBox
/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new Grid(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}
/* Object Model ***********************************************************************************/
/** @class "Grid" object model
    @description Represents a gird.
    @param {Object} control - TestComplete's object containing a grid.
*/
Grid = function (control) {
  /** @field
      @description Stores control for which this object model is created.
      @param {Object} control - TestComplete's object containing a grid.
  */
  this.control = this.__initialize(control);
  /** @function
      @name Grid.findColumn
      @description Retrieve a column by its name.
      @param {String} name - Name of the column to search for.
  */
  this.findColumn = function (name) {
    var columns, matches, name_part, id, i, j, header;
    if (this.__getColumnsCache !== null || this.__getColumnsCache !== undefined) {
      this.__getColumnsCache = this.__getColumns();
    }
    columns = this.__getColumnsCache;
    for (i = 0; i < columns.length; i++) {
      header = columns[i].__getHeader();
      if (Object.prototype.toString.call(header) === "[object Array]") {
        for (j = 0; j < header.length; j++) {
          if (Private_Utils.StringMatches(header[j].name, name)) {
            return columns[i];
          }
        }
      } else {
        if (Private_Utils.StringMatches(header, name)) {
          return columns[i];
        }
      }
    }
    matches = name.match(/(.*)\[(\d+)\]$/);
    if (matches) {
      name_part = matches[1];
      id = aqConvert.VarToInt(matches[2]);
      for (i = 0; i < columns.length; i++) {
        header = columns[i].__getHeader();
        if (Object.prototype.toString.call(header) === "[object Array]") {
          for (j = 0; j < header.length; j++) {
            if (Private_Utils.StringMatches(header[j].name, name_part)) {
              if (id === 0) {
                return columns[i];
              }
              id--;
              break;
            }
          }
        } else {
          if (Private_Utils.StringMatches(header, name_part)) {
            if (id === 0) {
              return columns[i];
            }
            id--;
          }
        }
      }
    }
    return null;
  };
  /** @function
      @name Grid.findRows
      @description Find rows by cell values contained.
      @param {String} params - JSON hash with search parameters. Example: {'col_name':'cell_value'}.
      @param {Integer} limit - Number of matching records to search for (optional).
      @param {Integer} depth - Depth to search in trees (optional).
  */
  this.findRows = function (params, limit, depth) {
    var column, newParams, param, p, k;
    // if it's a string -> try to evaluate to get either array or hash
    if (typeof params === "string") {
      params = eval("(" + params + ")");
    }
    // if it's a hash -> put it inside array
    if (Object.prototype.toString.call(params) !== "[object Array]") {
      params = [params];
    }
    // parse params and replace column names with their indexes
    newParams = [];
    for (p in params) {
      param = {};
      for (k in params[p]) {
        column = this.findColumn(k);
        if (column === null) {
          Log.Error("Invalid column name: " + k);
        }
        param["c_" + column.index] = params[p][k];
      }
      newParams.push(param);
    }
    // perform search
    return this.__doSearch(this.__getRows(), newParams, limit, depth ? depth - 1 : 0);
  };
  /** @function
      @name Grid.__doSearch
      @description Requry proceed rows by cell values contained.
      @param {String} rows - Rows of current node.
      @param {String} params - JSON hash with search parameters. Example: {'c_1':'cell_value'}.
      @param {Integer} limit - Number of matching records to search for (optional).
      @param {Integer} depth - Depth to search in trees (optional).
  */
  this.__doSearch = function (rows, params, limit, depth) {
    var res, row;
    res = [];
    if (Object.prototype.toString.call(rows) === "[object Array]") {
      rows = new Enumerator(rows);
    }
    for (; !rows.atEnd(); rows.moveNext()) {
      row = rows.item();
      if (row.__doCompare(params[0])) { // if current row complies with search request
        if (params.length > 1) { // if we've been requested to search for child nodes
          res = res.concat(this.__doSearch(row.__getSubRows(), params.slice(1), limit, 0));
        } else { // add current row to result
          res.push(row);
        }
      } else if (depth !== 0) { // cheat! :D
        res = res.concat(this.__doSearch(row.__getSubRows(), params, limit, depth - 1));
      }
      if (res.length === limit) {
        break;
      }
    }
    return res;
  };
  /** @function
      @name Grid.isEmpty
      @description Check is rows not contains data.
  */
  this.isEmpty = function () {
    return this.__isEmpty();
  };
  return this;
};
/** @class "Column" object model
    @description Represents a gird column.
    @param {Object} control - object containing a grid column.
    @param {Integer} index - Column's index (as appears on screen).
*/
Column = function (control, index) {
  /** @field
      @description Stores control for which this object model is created.
      @param {Object} control - object containing a grid column.
  */
  this.control = this.__initialize(control);
  /** @field
      @description Stores column's index (as appears on screen).
  */
  this.index = index || 0;
  /** @function
      @name Column.click
      @description Click on column's header, if any.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.click = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__click(x, y, keys);
  };
  /** @function
      @name Column.clickR
      @description Right click on column's header, if any.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.clickR = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__clickR(x, y, keys);
  };
  /** @function
      @name Column.dblClick
      @description Double click on column's header, if any.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.dblClick = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__dblClick(x, y, keys);
  };
  /** @function
      @name Column.hoverMouse
      @description Hover mouse on column's header, if any.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  this.hoverMouse = function (x, y) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    this.__hoverMouse(x, y);
  };
  return this;
};
/** @class "Row" object model
    @description Represents a gird row.
    @param {Object} control - TestComplete's object containing a grid row.
    @param {Integer} index Row's index (as appears on screen).
*/
Row = function (control, index) {
  /** @field
      @description Stores control for which this object model is created.
      @param {Object} control - TestComplete's object containing a grid row.
  */
  this.control = this.__initialize(control);
  /** @field
      @description Stores row's index (as appears on screen).
  */
  this.index = index || 0;
  /** @function
      @name Row.__doCompare
      @description Compare row with search parameters.
      @param {String} params - JSON hash with search parameters. Example: {'c_1':'cell_value'}.
  */
  this.__doCompare = function (params) {
    var cells, value, prop, p, k, i, flag;
    cells = this.__getCells();
    for (p in params) {
      if (typeof params[p] !== "object") {
        value = cells[p.substring(2)].__getContent();
        if (value === null) {
          continue;
        }
        if (Object.prototype.toString.call(value) === "[object Array]") {
          flag = false;
          for (i = 0; i < value.length; i++) {
            if (Private_Utils.StringMatches(value[i].value, params[p])) {
              flag = true;
              break;
            }
          }
          if (!flag) {
            return false;
          }
        } else {
          if (!Private_Utils.StringMatches(value, params[p])) {
            return false;
          }
        }
      } else {
        for (k in params[p]) {
          prop = cells[p.substring(2)][k];
          if (prop && typeof prop === "function") {
            prop = prop.call(cells[p.substring(2)]);
          }
          if (prop === null) {
            continue;
          }
          if (prop !== params[p][k]) {
            return false;
          }
        }
      }
    }
    return true;
  };
  /** @function
      @name Row.isSelected
      @description Check whether a row is selected.
      @returns {boolean} Row is selected.
  */
  this.isSelected = function () {
    return this.__isSelected();
  };
  /** @function
      @name Row.collapse
      @description Collapse grid row in a tree.
  */
  this.collapse = function () {
    return this.__collapse();
  };
  /** @function
      @name Row.expand
      @description Expand grid row in a tree.
  */
  this.expand = function () {
    return this.__expand();
  };
  /** @function
      @name Row.isExpanded
      @description Check whether a row is expanded.
      @returns {boolean} Row is expanded.
  */
  this.isExpanded = function () {
    return this.__isExpanded();
  };
  return this;
};
/** @class "Cell" object model
    @description Represents a gird cell.
    @param {Object} control - TestComplete's object containing a grid cell.
    @param {Integer} index - Cell's index (as appears on screen).
*/
Cell = function (control, index) {
  /** @field
      @description Stores control for which this object model is created.
      @param {Object} control - TestComplete's object containing a grid cell.
  */
  this.control = this.__initialize(control);
  /** @field
      @description Stores cell's index (as appears on screen).
  */
  this.index = index || 0;
  /** @function
      @name Cell.click
      @description Click on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.click = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__navigateTo();
    this.__click(x, y, keys);
  };
  /** @function
      @name Cell.clickR
      @description Click right mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.clickR = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__navigateTo();
    this.__clickR(x, y, keys);
  };
  /** @function
      @name Cell.dblClick
      @description Double click right mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  this.dblClick = function (x, y, keys) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    if (keys === null || keys === undefined) { keys = skNoShift; }
    this.__navigateTo();
    this.__dblClick(x, y, keys);
  };
  /** @function
      @name Cell.hoverMouse
      @description Hover mouse on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  this.hoverMouse = function (x, y) {
    if (x === null || x === undefined) { x = -1; }
    if (y === null || y === undefined) { y = -1; }
    this.__navigateTo();
    this.__hoverMouse(x, y);
  };
  /** @function
      @name Cell.setContent
      @description Set value in cell depends of control.
      @param {Object} value - value to set in cell.
  */
  this.setContent = function (value) {
    this.__setContent(value);
  };
  /** @function
      @name Cell.getContent
      @description Get value from cell.
      @returns {Object} value in cell.
  */
  this.getContent = function () {
    return this.__getContent();
  };
  /** @function
      @name Cell.isEnabled
      @description Check whether a cell is selected.
      @returns {boolean} Cell is enabled.
  */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
  return this;
};
/* Object Bindings ********************************************************************************/
/** @function
    @name Grid.__initialize
    @description Initialize control passed to "Grid" object.
    @param {Object} control TestComplete's object containing a grid.
    @returns {Object} Same control if it passes initialization.
    @throws Runtime Object initialization failed.
*/
Grid.prototype.__initialize = function (control) {
  var i, b;
  b = [];
  // if (control properties looks good) { select apropriate binding }
  // Bindings can be stacked. Most common one should go first.
  if (true) { b.push(__binding.grid_default); }
  if (aqObject.IsSupported(control, "className") && control.className === "t-grid-main") {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_main);
  }
  if (aqObject.IsSupported(control, "className") && control.className === "ListView") {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_listView);
  }
  if (aqObject.IsSupported(control, "className") && control.className === "dxgvControl") {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_dxgv);
  }
  if (aqObject.IsSupported(control, "ObjectType") && aqObject.IsSupported(control, "className") 
    && control.ObjectType === "Table" && control.className === "" && control.FindChild("ObjectIdentifier", "*Header_0_0", 5).Exists) {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_TGrid);
  }
  if (aqObject.IsSupported(control, "ObjectType") && aqObject.IsSupported(control, "className") 
    && control.ObjectType === "Panel" && control.className === "RadGrid_Tenrox") {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_RadGrid);
  }
  if (aqObject.IsSupported(control, "ObjectType") && aqObject.IsSupported(control, "className") 
    && control.ObjectType === "Table" && control.className === "" && control.FindChild("className", "RadGrid_Tenrox", 2).Exists) {
    b.push(__binding.grid_web_base);
    b.push(__binding.grid_web_RadGrid);
    control = control.FindChild("className", "RadGrid_Tenrox", 2);
  }
  if (aqObject.IsSupported(control, "className") && control.className == "GMMainTable")
    b.push(__binding.gm_main_table);
  if (b.length === 0) {
    throw "Runtime Object validation failed";
  }
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};
/** @function
    @name Column.__initialize
    @description Initialize control passed to "Column" object.
    @param {Object} control TestComplete's object containing a grid column.
    @returns {Object} Same control if it passes initialization.
    @throws Runtime Object initialization failed.
*/
Column.prototype.__initialize = function (control) {
  return control;
};
/** @function
    @name Row.__initialize
    @description Initialize control passed to "Row" object.
    @param {Object} control TestComplete's object containing a grid row.
    @returns {Object} Same control if it passes initialization.
    @throws Runtime Object initialization failed.
*/
Row.prototype.__initialize = function (control) {
  return control;
};
/** @function
    @name Cell.__initialize
    @description Initialize control passed to "Cell" object.
    @param {Object} control TestComplete's object containing a grid cell.
    @returns {Object} Same control if it passes initialization.
    @throws Runtime Object initialization failed.
*/
Cell.prototype.__initialize = function (control) {
  return control;
};
/** @description "Grid" default object bindings. */
__binding.grid_default = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    throw "Not implemented";
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    throw "Not implemented";
  };
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__getSubRows
      
      @description Retrieve subnodes contained in a row.
      
      @returns {Array} Array of Rows.
  */
  Row.prototype.__getSubRows = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__collapse
      
      @description Collapse grid row in a tree.
  */
  Row.prototype.__collapse = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__expand
      
      @description Expand grid row in a tree.
  */
  Row.prototype.__expand = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Row.__isExpanded
      
      @description Check whether a row is expanded.
      
      @returns {boolean} Row is expanded.
  */
  Row.prototype.__isExpanded = function () {
    throw "Not implemented";
  };
  /** @function
      @name Column.__click
      @description Click on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__click = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Column.__clickR
      @description Click right mouse button on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__clickR = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Column.__dblClick
      @description Double click mouse button on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__dblClick = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Column.__hoverMouse
      @description Hover mouse on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  Column.prototype.__hoverMouse = function (x, y) {
    throw "Not implemented";
  };
  /** @function
      @name Column.__getHeader
      @description Retreive columns's name (header), if any.
      @returns {String} Column's name.
  */
  Column.prototype.__getHeader = function () {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__click
      @description Click on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__click = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__clickR
      @description Click right mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__clickR = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__dblClick
      @description Double click mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__dblClick = function (x, y, keys) {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__hoverMouse
      @description Hover mouse on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  Cell.prototype.__hoverMouse = function (x, y) {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__navigateTo
      @description Ensure cell visibleOnScreen
  */
  Cell.prototype.__navigateTo = function () {
    throw "Not implemented";
  };
  /** @function
      @name Cell.__getContent
      @description Retrieve cell's content.
      @returns {Object} Cell's content.
  */
  Cell.prototype.__getContent = function () {
    throw "Not implemented";
  };
  /** @function
      
      @name Cell.__setContent
      
      @description Set value in cell depends of control.
      
      @param {Object} value - value to set in cell.
  */
  Cell.prototype.__setContent = function (value) {
    throw "Not implemented";
  };
};
/** @description Base "Grid" object bindings for Views grids. */
__binding.grid_web_base = function () {
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    var rows;
    rows = this.__getRows();
    if (Object.prototype.toString.call(rows) === "[object Array]") {
      return rows.length === 0;
    } else {
      return rows.ItemCount === 0;
    }
  };
  /** @function
      
      @name Row.__getSubRows
      
      @description Retrieve subnodes contained in a row.
      
      @returns {Array} Array of Rows.
  */
  Row.prototype.__getSubRows = function () {
    return [];
  };
  /** @function
      @name Column.__click
      @description Click on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__click = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.Click(x, y, keys);
  };
  /** @function
      @name Column.__clickR
      @description Click right mouse button on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__clickR = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.ClickR(x, y, keys);
  };
  /** @function
      @name Column.__dblClick
      @description Double click mouse button on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Column.prototype.__dblClick = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.DblClick(x, y, keys);
  };
  /** @function
      @name Column.__hoverMouse
      @description Hover mouse on column's header.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  Column.prototype.__hoverMouse = function (x, y) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.HoverMouse(x, y);
  };
  /** @function
      @name Column.__getHeader
      @description Retreive columns's name (header), if any.
      @returns {String} Column's name.
  */
  Column.prototype.__getHeader = function () {
    var res, objects, i;
    res = [];
    objects = this.control.cell.FindAllChildren("ObjectType", "Checkbox", 4);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        name: "%select%",
        value: objects[i].checked,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Image", 4);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        name: objects[i].title,
        value: objects[i].title,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren(["ObjectType", "className"], ["Panel", "*t-grid-*"], 4);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      if (objects[i].title !== null && objects[i].title !== undefined && objects[i].title !== "") {
        res.push({
          name: objects[i].title,
          value: objects[i].title,
          object: objects[i]
        });
      }
    }
    if (res.length > 0) {
      if (this.control.cell.contentText !== null && this.control.cell.contentText !== undefined && this.control.cell.contentText !== "") {
        res.push({
          name: this.control.cell.contentText,
          value: this.control.cell.contentText,
          object: this.control.cell
        });
      }
      return res;
    } else {
      return this.control.cell.contentText;
    }
  };
  /** @function
      @name Cell.__click
      @description Click on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__click = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.Click(x, y, keys);
  };
  /** @function
      @name Cell.__clickR
      @description Click right mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__clickR = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.ClickR(x, y, keys);
  };
  /** @function
      @name Cell.__dblClick
      @description Double click mouse button on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
      @param {Object} keys - Keys to press during click. For more details see TestComplete help.
  */
  Cell.prototype.__dblClick = function (x, y, keys) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.DblClick(x, y, keys);
  };
  /** @function
      @name Cell.__hoverMouse
      @description Hover mouse on cell.
      @param {Integer} x - x coordinate to click on cell, by default -1.
      @param {Integer} y - y coordinate to click on cell, by default -1.
  */
  Cell.prototype.__hoverMouse = function (x, y) {
    if (x === -1) { x = this.control.cell.Width / 2; }
    if (y === -1) { y = this.control.cell.Height / 2; }
    this.control.cell.HoverMouse(x, y);
  };
  /** @function
      @name Cell.__navigateTo
      @description Ensure cell visibleOnScreen
  */
  Cell.prototype.__navigateTo = function () {};
  /** @function
      @name Cell.__getContent
      @description Retrieve cell's content.
      @returns {Object} Cell's content.
  */
  Cell.prototype.__getContent = function () {
    var res, objects, i;
    res = [];
    objects = this.control.cell.FindAllChildren("ObjectType", "Checkbox", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].checked,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("className", "sComboWrapper", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].FindChild("ObjectType", "Textbox", 2).Text,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Textbox", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].Text,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Textarea", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].value,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Select", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].wText,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Image", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].title,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren("ObjectType", "Link", 2);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].contentText,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren(["ObjectType", "className"], ["Panel", "t-boolean-readonly-checked"]);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: true,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren(["ObjectType", "className"], ["Panel", "t-boolean-readonly"]);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: false,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren(["ObjectType", "className"], ["Panel", "tb"], 4);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      res.push({
        value: objects[i].contentText,
        object: objects[i]
      });
    }
    objects = this.control.cell.FindAllChildren(["ObjectType", "className"], ["Panel", "t-grid-*"], 4);
    objects = (new VBArray(objects)).toArray();
    for (i = 0; i < objects.length; i++) {
      if (objects[i].title !== null && objects[i].title !== undefined && objects[i].title !== "") {
        res.push({
          value: objects[i].title,
          object: objects[i]
        });
      }
    }
    if (res.length > 0) {
      if (this.control.cell.contentText !== null && this.control.cell.contentText !== undefined && this.control.cell.contentText !== "") {
        res.push({
          value: this.control.cell.contentText,
          object: this.control.cell
        });
      }
      return res;
    } else {
      return this.control.cell.contentText;
    }
  };
  /** @function
      
      @name Cell.__setContent
      
      @description Set value in cell depends of control.
      
      @param {Object} value - value to set in cell.
  */
  Cell.prototype.__setContent = function (value) {
    var object;
    object = this.control.cell.FindChild("ObjectType", "Checkbox", 2);
    if (object.Exists) {
      Common_CheckBox.SetValue(object, value);
      return;
    }
    object = this.control.cell.FindChild("className", "sComboWrapper", 2);
    if (object.Exists) {
      Common_ComboBox.SelectComboBoxItem(object, value);
      return;
    }
    object = this.control.cell.FindChild("ObjectType", "Textbox", 2);
    if (object.Exists) {
      Common_TextBox.SetTextBoxValue(object, value);
      return;
    }
    object = this.control.cell.FindChild("ObjectType", "Textarea", 2);
    if (object.Exists) {
      Common_TextBox.SetTextBoxValue(object, value);
      return;
    }
    object = this.control.cell.FindChild("ObjectType", "Select", 2);
    if (object.Exists) {
      Common_ComboBox.SelectComboBoxItem(object, value);
      return;
    }
  };
};
/** @description "t-grid-main" "Grid" object bindings for Views grids. */
__binding.grid_web_main = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    var res, headerTable, cells, index, i;
    headerTable = this.control.FindChild(["ObjectType", "className"], ["Table", "t-grid-header*"], 3);
    cells = headerTable.FindAllChildren("ObjectType", "Cell");
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    var res, bodyTable, index, i;
    bodyTable = this.control.FindChild(["ObjectType", "className"], ["Table", "t-grid-body*"], 3);
    res = [];
    index = 0;
    for (i = 0; i < bodyTable.rows.length; i++) {
      if (bodyTable.rows[i].cells.length === 0) {
        continue;
      }
      if (bodyTable.rows[i]["tree-level"] === undefined || bodyTable.rows[i]["tree-level"] === "0") {
        res.push(new Row({
          grid: this.control,
          body: bodyTable,
          id: bodyTable.rows[i]["id"]
        }, index++));
      }
    }
    return res;
  };
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    var bodyTable;
    bodyTable = this.control.FindChild(["ObjectType", "className"], ["Table", "t-grid-body*"], 3);
    return bodyTable.RowCount === 0 || bodyTable.contentText === "No data to display";
  };
  /** @function
      
      @name Row.__getSubRows
      
      @description Retrieve subnodes contained in a row.
      
      @returns {Array} Array of Rows.
  */
  Row.prototype.__getSubRows = function () {
    var res, index, i;
    this.__expand();
    res = [];
    index = 0;
    for (i = 0; i < this.control.body.rows.length; i++) {
      if (this.control.body.rows[i]["tree-parent"] === this.control.id) {
        res.push(new Row({
          grid: this.control.grid,
          body: this.control.body,
          id: this.control.body.rows[i]["id"]
        }, index++));
      }
    }
    return res;
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    var id, res, cells, index, i;
    for (i = 0; i < this.control.body.rows.length; i++) {
      if (this.control.body.rows[i]["id"] === this.control.id) {
        id = i;
        break;
      }
    }
    cells = this.control.body.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", id]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Cell({
        grid: this.control.grid,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    return false;
  };
  /** @function
      
      @name Row.__collapse
      
      @description Collapse grid row in a tree.
  */
  Row.prototype.__collapse = function () {
    var cell, button;
    cell = this.__getCells()[0];
    button = cell.FindChild("className", "*t-grid-tree-collapse*");
    if (button.Exists) {
      button.Click();
    }
  };
  /** @function
      
      @name Row.__expand
      
      @description Expand grid row in a tree.
  */
  Row.prototype.__expand = function () {
    var cell, button;
    cell = this.__getCells()[0];
    button = cell.control.cell.FindChild("className", "*t-grid-tree-expand*");
    if (button.Exists) {
      button.Click();
    }
  };
  /** @function
      
      @name Row.__isExpanded
      
      @description Check whether a row is expanded.
      
      @returns {boolean} Row is expanded.
  */
  Row.prototype.__isExpanded = function () {
    var cell;
    cell = this.__getCells()[0];
    return cell.FindChild("className", "*t-grid-tree-collapse*").Exists;
  };
};
/** @description "ListView" "Grid" object bindings for Views grids. */
__binding.grid_web_listView = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    var res, headerContainer, headerTable, cells, index, i;
    headerContainer = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Cell", "0"]);
    headerTable = headerContainer.FindChild(["ObjectType", "className", "ObjectIdentifier"], ["Table", "ListView", "0"]);
    cells = headerTable.FindAllChildren("ObjectType", "Cell");
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0 || cells[i].className === "LISTHEADER ListHeaderLastColumn") { continue; }
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    var res, bodyTable, index, i, bodyContainer;
    bodyContainer = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Cell", "1"]);
    bodyTable = bodyContainer.FindChild(["ObjectType", "className"], ["Table", "ListView"], 2);
    res = [];
    index = 0;
    for (i = 0; i < bodyTable.RowCount; i++) {
      res.push(new Row({
        grid: this.control,
        body: bodyTable
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    var res, cells, index, i;
    cells = this.control.body.FindAllChildren(["ObjectType", "Visible", "RowIndex"], ["Cell", "true", this.index]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Cell({
        grid: this.control.grid,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    return false;
  };
};
/** @description "dxgvControl" "Grid" object bindings for Views grids. */
__binding.grid_web_dxgv = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    var res, headerTable, cells, index, i;
    headerTable = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*HeaderTable"], 3);
    cells = headerTable.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", "0"]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0 || cells[i].className === "LISTHEADER ListHeaderLastColumn") { continue; }
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    var res, bodyTable, index, i;
    bodyTable = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*MainTable"], 3);
    res = [];
    index = 0;
    for (i = 0; i < bodyTable.RowCount; i++) {
      res.push(new Row({
        grid: this.control,
        body: bodyTable
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    var bodyTable;
    bodyTable = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*MainTable"], 3);
    return bodyTable.RowCount === 0 || bodyTable.contentText === "No data to display";
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    var res, cells, index, i;
    cells = this.control.body.FindAllChildren(["ObjectType", "Visible", "RowIndex"], ["Cell", "true", this.index]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Cell({
        grid: this.control.grid,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    return false;
  };
};
/** @description "TGrid" "Grid" object bindings for Views grids. */
__binding.grid_web_TGrid = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    var res, headerTable, cells, index, i;
    headerTable = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*Header_0_0"], 5);
    cells = headerTable.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", "1"]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    var res, body, bodyTable, index, i;
    body = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*Body_0_1"], 5);
    bodyTable = body.FindChild("ObjectType", "Table");
    res = [];
    index = 0;
    for (i = 1; i < bodyTable.RowCount; i++) {
      res.push(new Row({
        grid: this.control,
        body: bodyTable
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    var body, bodyTable;
    body = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*Body_0_1"], 5);
    bodyTable = body.FindChild("ObjectType", "Table");
    return bodyTable.RowCount === 0 || bodyTable.contentText === "No data to display";
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    var res, cells, index, i;
    cells = this.control.body.FindAllChildren(["ObjectType", "Visible", "RowIndex"], ["Cell", "true", this.index + 1]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Cell({
        grid: this.control.grid,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    return false;
  };
};
/** @description "RadGrid_Tenrox" "Grid" object bindings for Views grids. */
__binding.grid_web_RadGrid = function () {
  /** @function
      @name Grid.__getColumns
      @description Retrieve columns contained in a grid.
      @returns {Array} Array of columns.
  */
  Grid.prototype.__getColumns = function () {
    var res, headerTable, cells, index, i;
    headerTable = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", "*_Header"], 2);
    cells = headerTable.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", "0"]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__getRows
      @description Retrieve rows contained in a grid.
      @returns {Array} Enumerable of rows.
  */
  Grid.prototype.__getRows = function () {
    var res, body, bodyTable, index, i;
    body = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*_GridData"]);
    bodyTable = body.FindChild("ObjectType", "Table");
    res = [];
    index = 0;
    for (i = 0; i < bodyTable.RowCount; i++) {
      res.push(new Row({
        grid: this.control,
        body: bodyTable
      }, index++));
    }
    return res;
  };
  /** @function
      @name Grid.__isEmpty
      @description Check is grid not contains data.
  */
  Grid.prototype.__isEmpty = function () {
    var body, bodyTable;
    body = this.control.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", "*_GridData"]);
    bodyTable = body.FindChild("ObjectType", "Table");
    return bodyTable.RowCount === 0 || bodyTable.contentText === "No data to display";
  };
  /** @function
      
      @name Row.__getCells
      
      @description Retrieve cells contained in a grid row.
      
      @returns {Array} Array of cells.
  */
  Row.prototype.__getCells = function () {
    var res, cells, index, i;
    cells = this.control.body.FindAllChildren(["ObjectType", "Visible", "RowIndex"], ["Cell", "true", this.index]);
    cells = (new VBArray(cells)).toArray();
    cells = cells.sort(function (a, b) {
      return a.ColumnIndex - b.ColumnIndex;
    });
    res = [];
    index = 0;
    for (i = 0; i < cells.length; i++) {
      if (cells[i].Width === 0) { continue; }
      res.push(new Cell({
        grid: this.control.grid,
        cell: cells[i]
      }, index++));
    }
    return res;
  };
  /** @function
      
      @name Row.__isSelected
      
      @description Check whether a row is selected.
      
      @returns {boolean} Row is selected.
  */
  Row.prototype.__isSelected = function () {
    return false;
  };
};


/** @description "Grid" object bindings for Resource Scheduling grids. */
__binding.gm_main_table = function() {
  /* Cell.control = Cell as TC object
     Column.control = grid: Grid containing column as TC object
                      cell: Cell (sometimes panel) corresponding to column-header as TC object
     Row.control = grid: Grid containing column as TC object
                   container: Array containing all rows of a grid
                   row: RowIndex
                   cells: Array containing all cells of row as JavaScript objects
  */

  /** @function
      @name Grid.__getColumns
      @description Get all column-header cells and panels (from both left and right side of page)
      @returns {Array} Array of Onscreen objects (cells and panels)
  */
  Grid.prototype.__getColumns = function () {
    var tmp, cells, res, index, panels, i, j;
    res = [];
    index = 0;

    // Find left-side grid
    tmp = this.control.FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 0, 0]);
    tmp = tmp.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0]);
    tmp = tmp.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", 0]);
    // Find cells of grid that correspond to column-headers. Sort them by ColumnIndex
    cells = tmp.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", 2]);
    cells = (new VBArray(cells)).toArray();
    cells.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
    for (i = 0; i < cells.length; i++) {
      // Ignore if invisible
      if (cells[i].Width === 0) { continue; }
      panels = cells[i].FindAllChildren(["ObjectType"], ["Panel"]);
      panels = (new VBArray(panels)).toArray();
      // If cell contains no panels, cell corresponds to column-header...
      if (panels.length == 0) {
        res.push(new Column({
          grid: this.control,
          cell: cells[i]
        }, index++));
        continue;
      }
      // ...otherwise, add panels
      panels.sort(function(a,b){return a.ObjectIdentifier-b.ObjectIdentifier;});
      for (j = 0; j < panels.length; j++) {
        res.push(new Column({
          grid: this.control,
          cell: panels[j]
        }, index++));
      }
    }
    
    // Find right-side grid
    tmp = this.control.FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 0, 2]);
    tmp = tmp.FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0]);
    tmp = tmp.FindChild(["ObjectType", "ObjectIdentifier"], ["Table", 0]);
    // Find cells of grid that correspond to column-headers. Sort them by ColumnIndex
    cells = tmp.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", 2]);
    cells = (new VBArray(cells)).toArray();
    cells.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
    for (i = 0; i < cells.length; i++) {
      // Ignore if invisible
      if (cells[i].Width === 0) { continue; }
      // Add to results
      res.push(new Column({
        grid: this.control,
        cell: cells[i]
      }, index++));
    }
    
    return res;
  };
  
  /** @function
      @name Column.__getHeader
      @description Gets name of a column = content text of column-header cell/panel
      @returns {String} Name (header) of column
  */
  Column.prototype.__getHeader = function() {
    return this.control.cell.contentText;
  };
  
  /** @function
      @name Grid.__getRows
      @description Returns all rows of grid
      @returns {Array} Array of grid rows
  */
  Grid.prototype.__getRows = function () {
    var res, leftTable, rightTable, index, i, j, list1, list2, leftSub, rightSub, k, list, ind;
    leftTable = this.control
                    .FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 1, 0])
                    .FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0])
                    .FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0])
                    .FindChild(["ObjectType", "ObjectIdentifier"], ["Table", 0]);
    rightTable = this.control
                     .FindChild(["ObjectType", "RowIndex", "ColumnIndex"], ["Cell", 1, 2])
                     .FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0])
                     .FindChild(["ObjectType", "ObjectIdentifier"], ["Panel", 0])
                     .FindChild(["ObjectType", "ObjectIdentifier"], ["Table", 0]);
    res = [];
    index = 0;
    for (i = 0; i < leftTable.RowCount; i++) {
      list1 = leftTable.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", i]);
      list1 = (new VBArray(list1)).toArray();
      // Ignore if no cell found
      if (list1.length === 0) { continue; }
      // Ignore if invisible
      if (list1[0].Width == 0) { continue; }
      // If there is more than 1 cell - this list corresponds to row...
      if (list1.length > 1) {
        // Find equivalent row from right-side grid
        list2 = rightTable.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", i]);
        list2 = (new VBArray(list2)).toArray();
        list = [];
        ind = 0;
        // Add cells to array of cells
        list1.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
        for (j in list1) {
          if (list1[j].Width == 0) continue;
          list.push(new Cell(
            list1[j],
            ind++
          ));
        }
        list2.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
        for (j in list2) {
          if (list2[j].Width == 0) continue;
          list.push(new Cell(
            list2[j],
            ind++
          ));
        }
        // Add to array of rows 
        res.push(new Row({
          grid: this.control,
          container: res,
          row: i,
          cells: list
        }, index++));
        continue;
      }
      
      // ...otherwise, this list is only one cell, which contains table
      // Rows of that table correspond to Onscreen rows
      // Below routine is equivalent to upper one, just for nested tables
      leftSub = list1[0].FindChild("ObjectType", "Table");
      rightSub = rightTable.FindChild(["ObjectType", "RowIndex"], ["Cell", i])
                           .FindChild("ObjectType", "Table");
      for (k = 0; k < leftSub.RowCount; k++) {
        list1 = leftSub.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", k]);
        list1 = (new VBArray(list1)).toArray();
        // Ignore if no cell found
        if (list1.length === 0) { continue; }
        // Ignore if invisible
        if (list1[0].Width == 0) { continue; }
        // If there is more than 1 cell - this list corresponds to row
        // Other case was never met, so it wasn't implemented
        // In case such situation is found, recursion might be the best solution
        if (list1.length > 1) {
          // Find equivalent row from right-side grid
          list2 = rightSub.FindAllChildren(["ObjectType", "RowIndex"], ["Cell", k]);
          list2 = (new VBArray(list2)).toArray();
          list = [];
          ind = 0;
          // Add cells to array of cells
          list1.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
          for (j in list1) {
            if (list1[j].Width == 0) continue;
            list.push(new Cell(
              list1[j],
              ind++
            ));
          }
          list2.sort(function(a,b){return a.ColumnIndex-b.ColumnIndex;});
          for (j in list2) {
            if (list2[j].Width == 0) continue;
            list.push(new Cell(
              list2[j],
              ind++
            ));
          }
          // Add to array of rows
          res.push(new Row({
            grid: this.control,
            container: res,
            row: i,
            cells: list
          }, index++));
        }
      }
    }
    return res;
  };
  
  /** @function
      @name Row.__getCells
      @description Returns array of cells (JavaScript objects)
      @returns {Array} Array of cells
  */
  Row.prototype.__getCells = function () {
    return this.control.cells;
  };
  
  /** @function
      @name Cell.__getContent
      @description Returns content of cell
      @returns {String} Content of cell
  */
  Cell.prototype.__getContent = function() {
    var textbox = this.control.FindChild("ObjectType", "TextBox", 4);
    if (textbox.Exists) return textbox.Text;
    return this.control.contentText;
  };
  
  /** @function
      @name Cell.__setContent
      @description Sets cell value (text to textbox, true/false to checkbox...)
  */
  Cell.prototype.__setContent = function (value) {
    var textbox = this.control.FindChild("ObjectType", "TextBox");
    if (textbox.Exists) {
      textbox.Keys(value);
      return;
    }
  };
  
  /** @function
      @name Cell.__getContent
      @description For given row, finds it's subRows (children)
      @returns {Array} Array of rows (Javascript objects)
  */
  Row.prototype.__getSubRows = function () {
    var allRows = this.control.container;
    var childrenRowId = this.control.row + 1;
    var res = [];
    for (var i in allRows) {
      if (allRows[i].control.row == childrenRowId)
        res.push(allRows[i]);
    }
    return res;
  };
};