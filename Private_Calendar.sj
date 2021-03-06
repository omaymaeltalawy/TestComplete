//USEUNIT Common_ComboBox
/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new Calendar(control);
  } catch (e) {
    Log.Error("Not intialized wrapper: " + e.message());
  }
  return __wrapper;
}
/* Object Model ***********************************************************************************/
/** @class "Calendar" object model
    
    @description Represents a calendar.
    
    @param {Object} control TestComplete's object containing a calendar.
*/
Calendar = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name Calendar.getValue
      
      @description Gets the selected value in Calendar.
      
      @returns {aqDateTime} the aqDateTime object having selected date value.
  */
  this.getValue = function () {
    return this.__getValue();
  };
  /** @function
      
      @name Calendar.setValue
      
      @description Sets the specified date value in the Calendar.
      
      @param {aqDateTime/String} value Date value to be set.
  */
  this.setValue = function (value) {
    this.__setValue(value);
  };
  /** @function
      
      @name Calendar.isEnabled
      
      @description Returns if the calendar object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
  Calendar.prototype.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function
      
      @name Calendar.isVisible
      
      @description Returns if the calendar object is visible or not.
      
      @returns {boolean} True, if the control is visible; False, otherwise.
  */
  Calendar.prototype.isVisible = function () {
    return this.__isVisible();
  };
};
/* Object Bindings ********************************************************************************/
/** @function
    
    @name Calendar.__initialize
    
    @description Initialize control passed to "Calendar" object.
    
    @param {Object} control TestComplete's object containing a calender.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
Calendar.prototype.__initialize = function (control) {
  var b = [], i;
  // if (control properties looks good) { select apropriate binding }
  // Bindings can be stacked. Most common one should go first.

  if (aqObject.IsSupported(control, "className") && (aqString.StrMatches("ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all", control.className))) {
    b.push(__binding.Calendar_Web);
  }
  
  if (aqObject.IsSupported(control, "WndClass") && (aqString.StrMatches("SysMonthCal32", control.WndClass))) {
    b.push(__binding.Calendar_Desktop);
  }
  
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};

/** @description "Calendar" Default object bindings. */
__binding.Calendar_Web = function () {
/** @function
      
      @name Calendar.__getValue
      
      @description Returns the date object of the selected date in Calendar object.
      
      @returns {aqDateTime} Selected date object.
  */
Calendar.prototype.__getValue = function () {
  var currentYearObject, currentYear, currentMonthObject, currentMonth, currentDayObject, currentDay, currentDate;
  /* Get the year values */
  currentYearObject = this.control.FindChild(["ObjectType", "className"], ["Select", "ui-datepicker-year"], 3);
  currentYear = currentYearObject.wText;
  /* Get the Month values */
  currentMonthObject = this.control.FindChild(["ObjectType", "className"], ["Select", "ui-datepicker-month"], 3);
  currentMonth = currentMonthObject.wText;
  /* Get the Day values */
  currentDayObject = this.control.FindChild(["ObjectType", "className"], ["Cell", "*" + "current-day" + "*"], 2);
  currentDay = currentDayObject.contentText;
  /* Concatinate tthe date Day, Month, and year into one string to convert it*/
  currentDate = currentDay + " " + currentMonth + " " + currentYear;
  /* Convert and return the Date*/
  return aqConvert.StrToDate(currentDate);
};

/** @function
      
      @name Calendar.__isEnabled
      
      @description Returns if the calendar object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
Calendar.prototype.__isEnabled = function () {
  return this.control.Enabled;
};

/** @function
      
      @name Calendar.__isVisible
      
      @description Returns if the calendar object is Visible or not.
      
      @returns {boolean} True, if the control is Visible; False, otherwise.
*/
Calendar.prototype.__isVisible = function () {
  return this.control.Visible;
};

/** @function
      
      @name Calendar.__clickToday
      
      @description click the Today Link
*/
Calendar.prototype.__clickToday = function () {
  var todayLinkObject;
  todayLinkObject = this.control.FindChild(["ObjectType", "contentText"], ["TextNode", "Today"], 2);
  todayLinkObject.Click();
};

/** @function
      
      @name Calendar.__setValue
      
      @description Select the specified date object.
      
      @param {aqDateTime/String} value Date value to be selected.
  */
Calendar.prototype.__setValue = function (value) {
  var currentYearObject, dateDayValue, currentMonthObject, currentDayObject, i;
  /* Get the year Object and click it */
  currentYearObject = this.control.FindChild(["ObjectType", "className"], ["Select", "ui-datepicker-year"], 3);
  Common_ComboBox.SelectComboBoxItem(currentYearObject, aqConvert.DateTimeToFormatStr(value, "%Y"));
  
  /* Get the Month Object and click it */
  currentMonthObject = this.control.FindChild(["ObjectType", "className"], ["Select", "ui-datepicker-month"], 3);
  Common_ComboBox.SelectComboBoxItem(currentMonthObject, aqConvert.DateTimeToFormatStr(value, "%B"));
  
  /* Get the day Value from the date*/
  dateDayValue = aqDateTime.GetDay(value);
  /* Get the Day Object and click it */
  currentDayObject = this.control.FindChild(["ObjectType", "className", "contentText"], ["Link", "ui-state-default", dateDayValue], 3);
  if(!currentDayObject.Exists) {
    currentDayObject = this.control.FindChild(["ObjectType", "className", "contentText"], ["Link", "ui-state-default*ui-state-highlight*", dateDayValue], 3);
  }
  if(!currentDayObject.Exists) {
    currentDayObject = this.control.FindChild(["ObjectType", "className", "contentText"], ["Link", "ui-state-default ui-state-active", dateDayValue], 3);
  }
  if(!currentDayObject.Exists) {
    throw "There is no day:" + dateDayValue;
  }
  currentDayObject.Click();
};
};

/** @description "Calendar" Default object bindings. */
__binding.Calendar_Desktop = function () {
/** @function
      
      @name Calendar.__getValue
      
      @description Returns the date object of the selected date in Calendar object.
      
      @returns {aqDateTime} Selected date object.
  */
Calendar.prototype.__getValue = function () {
  var currentDate;
  currentDate = this.control.wDate;
  return aqConvert.StrToDate(currentDate);
};

/** @function
      
      @name Calendar.__isEnabled
      
      @description Returns if the calendar object is enabled or not.
      
      @returns {boolean} True, if the control is enabled; False, otherwise.
  */
Calendar.prototype.__isEnabled = function () {
  return this.control.Enabled;
};

/** @function
      
      @name Calendar.__isVisible
      
      @description Returns if the calendar object is Visible or not.
      
      @returns {boolean} True, if the control is Visible; False, otherwise.
*/
Calendar.prototype.__isVisible = function () {
  return this.control.Visible;
};

/** @function
      
      @name Calendar.__clickToday
      
      @description click the Today Link
*/
Calendar.prototype.__clickToday = function () {
  var dateDay, dateMonth, dateYear, currentDate;
  currentDate = aqDateTime.Today();
  dateDay = aqDateTime.GetDay(currentDate);
  dateMonth = aqDateTime.GetMonth(currentDate);
  dateYear = aqDateTime.GetYear(currentDate)  
  this.control.wDate = aqDateTime.SetDateElements(dateYear, dateMonth, dateDay);
};

/** @function
      
      @name Calendar.__setValue
      
      @description Select the specified date object.
      
      @param {aqDateTime/String} value Date value to be selected.
  */
Calendar.prototype.__setValue = function (value) {
  var dateDay, dateMonth, dateYear;
  dateDay = aqDateTime.GetDay(value);
  dateMonth = aqDateTime.GetMonth(value);
  dateYear = aqDateTime.GetYear(value)  
  this.control.wDate = aqDateTime.SetDateElements(dateYear, dateMonth, dateDay);
};
};