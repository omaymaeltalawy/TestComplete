/** @ignore @description Control binding */
var __binding = {};

/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try { __wrapper = new CheckBox(control); } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message); return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
};

/* Object Model ***********************************************************************************/

/** @class "CheckBox" object model
    
    @description Represents a check box.
    
    @param {Object} control TestComplete's object containing a check box.
*/
CheckBox = function(control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  
  /** @function
      
      @name CheckBox.getValue
      
      @description Retrieve check box’s value.
  */
  this.getValue = function() { return this.__getValue(); };
  
  /** @function
      
      @name CheckBox.isEnabled
      
      @description Check whether a check box is enabled.
      
      @param {boolean} Check box is enabled.
  */
  this.isEnabled = function() { return this.__isEnabled(); };
  
  /** @function
      
      @name CheckBox.isVisible
      
      @description Check whether a check box is visible on screen.
      
      @param {boolean} Check box is visible on screen.
  */
  this.isVisible = function() { return this.__isVisible(); };
  
  /** @function
      
      @name CheckBox.setValue
      
      @description Assign new value to a check box.
      
      @param {boolean} value New value to assing.
  */
  this.setValue = function(value) { this.__setValue(value); };
};

/* Object Bindings ********************************************************************************/

/** @function
    
    @name CheckBox.__initialize
    
    @description Initialize control passed to "CheckBox" object.
    
    @param {Object} control TestComplete's object containing an check box.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
CheckBox.prototype.__initialize = function(control) {
  var b = [];
 
   if (true) b.push(__binding.checkbox_default);
  
  if (aqObject.IsSupported(control,"ObjectType")  
         && (control.ObjectType == "Checkbox" ))
      b.push(__binding.checkbox_Checkbox);
  
  for (var i = 0; i < b.length; i++) { b[i](); }
 
  return control;
};


__binding.checkbox_default = function() {
  /** @function
      
      @name CheckBox.__getValue
      
      @description Retrieve check box’s value.
  */
  CheckBox.prototype.__getValue = function() { /* todo */ };
  
  /** @function
      
      @name CheckBox.__isEnabled
      
      @description Check whether a check box is enabled.
      
      @param {boolean} Check box is enabled.
  */
  CheckBox.prototype.__isEnabled = function() { /* todo */ };
  
  /** @function
      
      @name CheckBox.__isVisible
      
      @description Check whether a check box is visible on screen.
      
      @param {boolean} Check box is visible on screen.
  */
  CheckBox.prototype.__isVisible = function() { /* todo */ };
  
  /** @function
      
      @name CheckBox.__setValue
      
      @description Assign new value to a check box.
      
      @param {boolean} value New value to assing.
  */
  CheckBox.prototype.__setValue = function(value) { /* todo */ };
};

__binding.checkbox_Checkbox = function () {
/** @function
      
    @name CheckBox.__getValue
      
    @description Retrieve check box’s value.
*/
  CheckBox.prototype.__getValue = function () {
    return this.control.status;
  };
/** @function
      
    @name CheckBox.__isEnabled
      
    @description Check whether a check box is enabled.
      
    @param {boolean} Check box is enabled.
*/
  CheckBox.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
/** @function
      
    @name CheckBox.__isVisible
      
    @description Check whether a check box is visible on screen.
      
    @param {boolean} Check box is visible on screen.
*/
  CheckBox.prototype.__isVisible = function () {
    return this.control.VisibleOnScreen;
  };
/** @function
      
    @name CheckBox.__setValue
      
    @description Assign new value to a check box.
      
    @param {boolean} value New value to assing.
*/
  CheckBox.prototype.__setValue = function (value) {
    this.control.ClickChecked(value);
  };
};
