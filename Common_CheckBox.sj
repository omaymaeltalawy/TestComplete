//USEUNIT Private_CheckBox

/** @function
    @name Common_CheckBox.CheckBoxValue
    @description Compare check box's value with a given one.
    @param {Object} control  TestComplete's object containing a check box.
    @param {boolean} value   Value to check with.
*/
function CheckBoxStatus(control, value) {
  try {
    Log.AppendFolder("Common_CheckBox.CheckBoxStatus");
    return Private_CheckBox.initWrapper(control).getValue() === value;
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    @name Common_CheckBox.VerifyCheckBoxValue
    @description Compare check box's value with a given one.
    @param {Object} control  TestComplete's object containing a check box.
    @param {boolean} value   Value to check with.
*/
function VerifyCheckBoxStatus(control, value) {
  if (CheckBoxStatus(control, value)) {
    Log.Checkpoint("Check box's value is the same as the one provided State."+value);
  } else {
    Log.Error("Check box's value is NOT the same as the one provided State."+value);
  }
}

/** @function
    @name Common_CheckBox.SetValue
    @description Assign CheckBox with a new value.
    @param {Object} control  TestComplete's object containing a check box.
    @param {boolean} value   Value to assign.
*/
function SetValue(control, value) {
  try {
    Log.AppendFolder("Common_CheckBox.SetValue");
    Private_CheckBox.initWrapper(control).setValue(value);
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    @name Common_CheckBox.CheckBoxEnabled
    @description Verify if check box is enabled.
    @param {Object} control  TestComplete's object containing a check box.
    @returns {boolean} Check box's is enabled.
*/
function CheckBoxEnabled(control) {
  try {
    Log.AppendFolder("Common_CheckBox.CheckBoxEnabled");
    return Private_CheckBox.initWrapper(control).isEnabled();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    @name Common_CheckBox.VerifyCheckBoxEnabled
    @description Verify if check box is enabled.
    @param {Object} control  TestComplete's object containing a check box.
    @returns {boolean} Check box's is enabled.
*/
function VerifyCheckBoxEnabled(control) {
  if (CheckBoxEnabled(control)) {
    Log.Checkpoint("Check box is enabled.");
  } else {
    Log.Error("Check box is NOT enabled.");
  }
}
/** @function
    @name Common_CheckBox.CheckBoxVisible
    @description Verify if check box is visible.
    @param {Object} control  TestComplete's object containing a check box.
    @returns {boolean} Check box's is visible.
*/
function CheckBoxVisible(control) {
  try {
    Log.AppendFolder("Common_CheckBox.CheckBoxVisible");
    return Private_CheckBox.initWrapper(control).isVisible();
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}

/** @function
    @name Common_CheckBox.VerifyCheckBoxVisible
    @description Verify if check box is visible.
    @param {Object} control  TestComplete's object containing a check box.
    @returns {boolean} Check box's is visible.
*/
function VerifyCheckBoxVisible(control) {
  if (CheckBoxVisible(control)) {
    Log.Checkpoint("Check box is visible.");
  } else {
    Log.Error("Check box is NOT visible.");
  }
}
