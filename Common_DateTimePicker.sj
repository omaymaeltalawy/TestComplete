//USEUNIT Private_DateTimePicker

/**
 * Get Value of the DateTimePicker.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @return {DateTime} - return DateTime of the DateTimePicker.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function ClickCalendarButton(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.GetDateValue");
    return Private_DateTimePicker.initWrapper(DateTimePickerObject).click();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * Get Value of the DateTimePicker.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @return {DateTime} - return DateTime of the DateTimePicker.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function GetDateValue(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.GetDateValue");
    return Private_DateTimePicker.initWrapper(DateTimePickerObject).getValue();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * Verify Date Value of the Calendar.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @param {String/DateTime} Value - The date value need to verify.
 * @sample - VerifyDateValue(CalendarObject, "2013/1/1")
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function VerifyDateValue(DateTimePickerObject, Value) {
  var CurrentDate, CompareDate;
  try {
    Log.AppendFolder("Common_Calendar.VerifyDateValue");
    CurrentDate = GetDateValue(DateTimePickerObject);
    if (aqObject.GetVarType(Value) !== aqObject.varDate) {
      CompareDate = aqConvert.StrToDate(Value);
    }
    if (aqDateTime.Compare(CurrentDate, CompareDate) === 0) {
      Log.Checkpoint("The Calendar is set as '" + Value + "'.");
    } else {
      Log.Error("The Calendar is NOT set as '" + Value + "'.");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * Check DateTimePicker enabled.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @return {Boolean} - True for DateTimePicker enabled, else not.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function IsDateTimePickerEnabled(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.IsDateTimePickerEnabled");
    return Private_DateTimePicker.initWrapper(DateTimePickerObject).isEnabled();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Verify DateTimePicker enabled.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @sample - VerifyDateTimePickerEnabled(DateTimePickerObject)
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function VerifyDateTimePickerEnabled(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.VerifyDateTimePickerEnabled");
    if (IsDateTimePickerEnabled(DateTimePickerObject)) {
      Log.Checkpoint("The DateTimePicker is Enabled.");
    } else {
      Log.Error("The DateTimePicker is NOT Enabled.");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Check DateTimePicker visible.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @return {Boolean} - True for DateTimePicker visible, else not.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function IsDateTimePickerVisible(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.IsDateTimePickerVisible");
    return Private_DateTimePicker.initWrapper(DateTimePickerObject).isVisible();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Verify DateTimePicker visible.
 * @param {Object} DateTimePickerObject - The control object of DateTimePicker.
 * @sample - VerifyDateTimePickerVisible(DateTimePickerObject)
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/22/2014
 */
function VerifyDateTimePickerVisible(DateTimePickerObject) {
  try {
    Log.AppendFolder("Common_DateTimePicker.VerifyDateTimePickerVisible");
    if (IsDateTimePickerVisible(DateTimePickerObject)) {
      Log.Checkpoint("The DateTimePicker is Visible.");
    } else {
      Log.Error("The DateTimePicker is NOT Visible.");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/** @function
    
    @name Common_DateTimePicker.SetDateTimePickerValue
    
    @description Set date in DateTimePicker
    
    @param {Object} control TestComplete's object containing a DateTimePicker.
    @param {String} value Date or time to set.
*/
function SetDateTimePickerValue(control, value) {
  try {
    Log.AppendFolder("Common_DateTimePicker.SetDateTimePickerValue");
    var date = Private_Utils.InputsToDate(value);
    Private_DateTimePicker.initWrapper(control).setValue(date);
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}