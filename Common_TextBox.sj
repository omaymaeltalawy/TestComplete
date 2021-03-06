//USEUNIT Private_TextBox

/** @function

@name Common_TextBox.SetTextBoxValue

@description Assign text box with a new value.

@param {Object} control  TestComplete's object containing a text box.
@param {String} value    Value to assign.
 */
function SetTextBoxValue(control, value) {
	try {
		Log.AppendFolder("Common_TextBox.SetTextBoxValue");
		Private_TextBox.initWrapper(control).setValue(value);
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.GetTextBoxValue

@description Get text box with a value.

@param {Object} control  TestComplete's object containing a text box.
 */
function GetTextBoxValue(control) {
	try {
		Log.AppendFolder("Common_TextBox.GetTextBoxValue");
		return Private_TextBox.initWrapper(control).getValue();
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.IsTextBoxValue

@description Checks if the TextBox value equals the supplied text

@param {Object} control  TestComplete's object containing a text box.

@param {String} text  The string to be compared to the TextBox value.

@returns {Boolean} True if the TextBox value equals the supplied text
 */
function IsTextBoxValue(control, text) {
	try {
		Log.AppendFolder("Common_TextBox.IsTextBoxValue");
		return GetTextBoxValue(control) == text;
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.VerifyTextBoxValue

@description Verify if text box's text is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} text    Text to compare with.

@returns {boolean} Text box's text is the same as the one provided.
 */
function VerifyTextBoxValue(control, text) {
	if (IsTextBoxValue(control, text)) {
		Log.Checkpoint("Text box's text is the same as the one provided.");
	} else {
		Log.Error("Text box's text is NOT the same as the one provided.");
	}
}

/** @function

@name Common_TextBox.IsTextBoxFontColor

@description Verify if text box's color is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} color    Color to compare with.

@returns {boolean} Text box's color is the same as the one provided.
 */
function IsTextBoxFontColor(control, color) {
	try {
		Log.AppendFolder("Common_TextBox.IsTextBoxFontColor");
		return Private_TextBox.initWrapper(control).getFontColor() == color;
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.VerifyTextBoxFontColor

@description Verify if text box's color is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} color    Color to compare with.
 */
function VerifyTextBoxFontColor(control, color) {
	if (IsTextBoxFontColor(control, color)) {
		Log.Checkpoint("Text box's color is the same as the one provided.");
	} else {
		Log.Error("Text box's color is NOT the same as the one provided.");
	}
}

/** @function-

@name Common_TextBox.IsTextBoxEnabled

@description Verify if text box's enablity is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} enablity Enablity to compare with.

@returns {boolean} Text box's enablity is the same as the one provided.
 */
function IsTextBoxEnabled(control, enablity) {
	try {
		Log.AppendFolder("Common_TextBox.IsTextBoxEnabled");
		return Private_TextBox.initWrapper(control).isEnabled() == enablity;
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.VerifyTextBoxEnabled

@description Verify if text box's enablity is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} enablity Enablity to compare with.
 */
function VerifyTextBoxEnabled(control, enablity) {
	if (IsTextBoxEnabled(control, enablity)) {
		Log.Checkpoint("Text box's enablity is the same as the one provided.");
	} else {
		Log.Error("Text box's enablity is NOT the same as the one provided.");
	}
}

/** @function-

@name Common_TextBox.IsTextBoxVisible

@description Verify if text box's visibility is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} visibility Visibility to compare with.

@returns {boolean} Text box's visibility is the same as the one provided.
 */
function IsTextBoxVisible(control, visibility) {
	try {
		Log.AppendFolder("Common_TextBox.IsTextBoxVisible");
		return Private_TextBox.initWrapper(control).isVisible() == visibility;
	} catch (e) {
		Log.Error("Oops! There's some glitch in the script: " + e.message);
		return;
	}
	finally {
		Log.PopLogFolder();
	}
}

/** @function

@name Common_TextBox.VerifyTextBoxVisible

@description Verify if text box's visibility is the same as the one provided.

@param {Object} control  TestComplete's object containing a text box.
@param {Object} visibility Visibility to compare with.
 */
function VerifyTextBoxVisible(control, visibility) {
	if (IsTextBoxVisible(control, visibility)) {
		Log.Checkpoint("Text box's visibility is the same as the one provided.");
	} else {
		Log.Error("Text box's visibility is NOT the same as the one provided.");
	}
}
