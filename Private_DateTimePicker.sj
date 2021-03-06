//USEUNIT Private_Utils
//USEUNIT Common_Calendar

/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new DateTimePicker(control);
  } catch (e) {
    Log.Error("Not intialized wrapper: " + e.message());
  }
  return __wrapper;
}
/* Object Model ***********************************************************************************/
/** @class "DateTimePicker" object model
    
    @description Represents a DateTimePicker.
    
    @param {Object} control TestComplete's object containing a DateTimePicker.
*/
DateTimePicker = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name DateTimePicker.getValue
      
      @description Gets the selected value in DateTimePicker.
      
      @returns {aqDateTime} the aqDateTime object having selected date value.
  */
  this.getValue = function () {
    return this.__getValue();
  };
  /** @function
      
      @name DateTimePicker.setValue
      
      @description Sets the specified date value in the DateTimePicker.
      
      @param {aqDateTime/String} value Date value to be set.
  */
  this.setValue = function (value) {
    this.__setValue(value);
  };
  /** @function
      
      @name DateTimePicker.isEnabled
      
      @description Returns if the DateTimePicker object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
  DateTimePicker.prototype.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function
      
      @name DateTimePicker.isVisible
      
      @description Returns if the DateTimePicker object is visible or not.
      
      @returns {boolean} True, if the control is visible; False, otherwise.
  */
  DateTimePicker.prototype.isVisible = function () {
    return this.__isVisible();
  };
  /** @function
      
      @name DateTimePicker.isVisible
      
      @description Returns if the DateTimePicker object is visible or not.
      
      @returns {boolean} True, if the control is visible; False, otherwise.
  */
  DateTimePicker.prototype.click = function () {
    return this.__click();
  };
};
/* Object Bindings ********************************************************************************/
/** @function
    
    @name DateTimePicker.__initialize
    
    @description Initialize control passed to "DateTimePicker" object.
    
    @param {Object} control TestComplete's object containing a calender.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
DateTimePicker.prototype.__initialize = function (control) {
  var b = [], i;
  // if (control properties looks good) { select apropriate binding }
  // Bindings can be stacked. Most common one should go first.
  if (aqObject.IsSupported(control, "className") && (aqString.StrMatches("settings", control.className))) {
    b.push(__binding.DateTimePicker_Web);
  }
  if (aqObject.IsSupported(control, "ClrClassName") && (aqString.StrMatches("DateTimePicker", control.ClrClassName))) {
    b.push(__binding.DateTimePicker_Desktop);
  }
  
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};


/** @description "DateTimePicker" Default object bindings. */
__binding.DateTimePicker_Web = function () {
  /** @function
      
      @name DateTimePicker.__getValue
      
      @description Returns the date object of the selected date in DateTimePicker object.
      
      @returns {aqDateTime} Selected date object.
  */
  DateTimePicker.prototype.__getValue = function () {
    var textBoxObject;
    textBoxObject = this.control.FindChild(["ObjectType"], ["Textbox"], 3);
    return textBoxObject.Text;
  };
  /** @function
      
      @name DateTimePicker.__isEnabled
      
      @description Returns if the DateTimePicker object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
  DateTimePicker.prototype.__isEnabled = function () {
    var textBoxObject;
    textBoxObject = this.control.FindChild(["ObjectType"], ["Textbox"], 3);
    return textBoxObject.Enabled;
  };
  /** @function
      
      @name DateTimePicker.__isVisible
      
      @description Returns if the DateTimePicker object is Visible or not.
      
      @returns {boolean} True, if the control is Visible; False, otherwise.
  */
  DateTimePicker.prototype.__isVisible = function () {
    var textBoxObject;
    textBoxObject = this.control.FindChild(["ObjectType"], ["Textbox"], 3);
    return textBoxObject.Visible;
  };
  /** @function
      
      @name DateTimePicker.__click
      
      @description Clicks the DateTimePicker.
      
  */
  DateTimePicker.prototype.__click = function () {
    var calendarButtonObject;
    calendarButtonObject = this.control.FindChild(["ObjectType"], ["Image"], 3);
    calendarButtonObject.Click();
  };
   /** @function
      
      @name DateTimePicker.__setValue
      
      @description Sets the specified date value in the DateTimePicker.
      
      @param {aqDateTime/String} value Date value to be set.
  */
  DateTimePicker.prototype.__setValue = function (value) {
    var calendarButtonObject, frame, calendar;
    calendarButtonObject = this.control.FindChild(["ObjectType"], ["Image"], 3);
    calendarButtonObject.Click();
    frame = Private_Utils.GetParentByType(this.control, "Frame");
    calendar = frame.FindChild("className", "*ui-datepicker*");
    Common_Calendar.SetDateValue(calendar, value);
  };
};

/** @description "DateTimePicker" Default object bindings. */
__binding.DateTimePicker_Desktop = function () {
  /** @function
      
      @name DateTimePicker.__getValue
      
      @description Returns the date object of the selected date in DateTimePicker object.
      
      @returns {aqDateTime} Selected date object.
  */
  DateTimePicker.prototype.__getValue = function () {
    return this.control.wDate;
  };
  /** @function
      
      @name DateTimePicker.__isEnabled
      
      @description Returns if the DateTimePicker object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
  DateTimePicker.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function
      
      @name DateTimePicker.__isVisible
      
      @description Returns if the DateTimePicker object is Visible or not.
      
      @returns {boolean} True, if the control is Visible; False, otherwise.
  */
  DateTimePicker.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function
      
      @name DateTimePicker.__click
      
      @description Clicks the DateTimePicker.
      
  */
  DateTimePicker.prototype.__click = function () {
    this.control.Click(97, 9);
  };
  
};