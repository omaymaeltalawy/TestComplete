//USEUNIT Private_Calendar
/**
 * Get Date Value of the Calendar.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @return {DateTime} - return DateTime of the Calendar.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function GetDateValue(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.GetDateValue");
    return Private_Calendar.initWrapper(CalendarObject).getValue();
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
function VerifyDateValue(CalendarObject, Value) {
  var CurrentDate, CompareDate;
  try {
    Log.AppendFolder("Common_Calendar.VerifyDateValue");
    CurrentDate = GetDateValue(CalendarObject);
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
 * Set Date Value to the Calendar.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @param {String/DateTime} Value - The date value need to set.
 * @sample - SetDateValue(CalendarObject, "2013/1/1")
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function SetDateValue(CalendarObject, Value) {
  try {
    Log.AppendFolder("Common_Calendar.SetDateValue");
    Private_Calendar.initWrapper(CalendarObject).setValue(Value);
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * Set Date Value to today.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @sample - SetDateValue(CalendarObject, "2013/1/1")
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/28/2014
 */
function SetDateToToday(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.SetDateValue");
    Private_Calendar.initWrapper(CalendarObject).__clickToday();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}

/**
 * Check Calendar enabled.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @return {Boolean} - True for calendar enabled, else not.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function IsCalendarEnabled(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.IsCalendarEnabled");
    return Private_Calendar.initWrapper(CalendarObject).isEnabled();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Verify Calendar enabled.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @sample - VerifyCalendarEnabled(CalendarObject)
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function VerifyCalendarEnabled(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.VerifyCalendarEnabled");
    if (IsCalendarEnabled(CalendarObject)) {
      Log.Checkpoint("The Calendar is Enabled.");
    } else {
      Log.Error("The Calendar is NOT Enabled.");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Check Calendar visible.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @return {Boolean} - True for calendar visible, else not.
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function IsCalendarVisible(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.IsCalendarVisible");
    return Private_Calendar.initWrapper(CalendarObject).isVisible();
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}
/**
 * Verify Calendar visible.
 * @param {Object} CalendarObject - The control object of Calendar.
 * @sample - VerifyCalendarVisible(CalendarObject)
 * @autor Victor Hugo Rios Rada <victorhugo.riosrada@gteamstaff.com>
 * @creation 1/21/2014
 */
function VerifyCalendarVisible(CalendarObject) {
  try {
    Log.AppendFolder("Common_Calendar.VerifyCalendarVisible");
    if (IsCalendarVisible(CalendarObject)) {
      Log.Checkpoint("The Calendar is Visible.");
    } else {
      Log.Error("The Calendar is NOT Visible.");
    }
  } catch (e) {
    Log.Error("Oops! There's some glitch in the script: " + e.message);
    return;
  } finally {
    Log.PopLogFolder();
  }
}