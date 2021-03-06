/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper
 * @param {Object} control The native TestComplete object. */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new TextBox(control);
    __wrapper.__initTextBox();
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}
/** @function @ignore

@name getStyle

@description Retrieve an html element computed style

@param {Object} control The native TestComplete object for html control

@param {String} cssprop The style property to be retrieved.

@returns {String} The html element computed style
 */
function getStyle(control, cssprop) {
  if (aqObject.IsSupported(control, "currentStyle") && control.currentStyle) {
    return control.currentStyle[cssprop]; //IE
  }
  if (aqObject.IsSupported(control.ownerDocument, "defaultView") && control.ownerDocument.defaultView && aqObject.IsSupported(control.ownerDocument.defaultView, "getComputedStyle") && control.ownerDocument.defaultView.getComputedStyle) {
    return control.ownerDocument.defaultView.getComputedStyle(control, "")[cssprop]; //Firefox
  }
  if (aqObject.IsSupported(control, "style") && control.style) {
    return control.style[cssprop]; //try and get inline style
  }
  return null;
}
/** @function @ignore

@name colorToHex

@description Converts color retrieved from html style property to hexadecimal format.

@param {String} color The color to be converted.

@returns {String} The hexadecimal format for the color
 */
function colorToHex(color) {
  if (color.substr(0, 1) === '#') {
    return '0x' + color.substr(1);
  }
  var digits, red, green, blue, rgb;
  digits = /rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)/.exec(color);
  red = parseInt(digits[1], 10);
  green = parseInt(digits[2], 10);
  blue = parseInt(digits[3], 10);
  rgb = (1 << 24) | (red << 16) | (green << 8) | blue;
  return '0x' + rgb.toString(16).substr(1);
}
/* Object Model ***********************************************************************************/
/** @class "TextBox" object model

@description Represents a text box.

@param {Object} control TestComplete's object containing a text box.
 */
TextBox = function (control) {
  /** @field

  @description Stores control for which this object model is created.
   */
  this.control = this.__initialize(control);
  /** @function

  @name TextBox.getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  this.getFontColor = function () {
    return this.__getFontColor();
  };
  /** @function

  @name TextBox.getValue

  @description Retrieve text box value.
   */
  this.getValue = function () {
    return this.__getValue();
  };
  /** @function

  @name TextBox.isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  this.isEnabled = function () {
    return this.__isEnabled();
  };
  /** @function

  @name TextBox.isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  this.isVisible = function () {
    return this.__isVisible();
  };
  /** @function

  @name TextBox.setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign.
   */
  this.setValue = function (value) {
    this.__setValue(value);
  };
};
/* Object Bindings ********************************************************************************/
/** @function

@name TextBox.__initialize

@description Initialize control passed to "TextBox" object.

@param {Object} control TestComplete's object containing an text box.

@returns {Object} Same control if it passes initialization.

@throws Runtime Object initialization failed.
 */
TextBox.prototype.__initialize = function (control) {
  var i, isHtmlControl, b = [];
  // if (control properties looks good) { select appropriate binding }
  // Bindings can be stacked. Most common one should go first.
  b.push(__binding.textbox_default);
  isHtmlControl = aqObject.IsSupported(control, "ownerDocument") && control.ownerDocument;
  if (isHtmlControl && aqObject.IsSupported(control, "ObjectType") && (control.ObjectType === "Textbox" || control.ObjectType === "PasswordBox")) {
    b.push(__binding.textbox_web);
  }
  if (isHtmlControl && aqObject.IsSupported(control, "ObjectType") && (control.ObjectType === "Textbox" || control.ObjectType === "PasswordBox") && aqObject.IsSupported(control, "className") && (/(^|\s+)TenroxText(\s+|$)/g).test(control.className) && aqObject.IsSupported(control, "ObjectIdentifier") && control.ObjectIdentifier === "E_Password") {
    b.push(__binding.textbox_tenrox_password);
  }
  if (isHtmlControl && aqObject.IsSupported(control, "ObjectType") && control.ObjectType === "Textbox" && aqObject.IsSupported(control, "className") && (/(^|\s+)TB(ETC)?(\s+|$)/g).test(control.className)) {
    b.push(__binding.textbox_web_tb);
  }
  if (isHtmlControl && aqObject.IsSupported(control, "ObjectType") && (control.ObjectType === "Panel" || control.ObjectType === "Textarea")) {
    b.push(__binding.textbox_panel);
  }
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};
__binding.textbox_default = function () {
  /** @function

  @name TextBox.__initTextBox

  @description Do any additional initialization steps required for the text box wrapper.
   */
  TextBox.prototype.__initTextBox = function () { /* todo */ };
  /** @function

  @name TextBox.__getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  TextBox.prototype.__getFontColor = function () { /* todo */ };
  /** @function

  @name TextBox.__getValue

  @description Retrieve text box value.
   */
  TextBox.prototype.__getValue = function () { /* todo */ };
  /** @function

  @name TextBox.__getName

  @description Retrieve text box name.
   */
  TextBox.prototype.__getName = function () { /* todo */ };
  /** @function

  @name TextBox.__isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  TextBox.prototype.__isEnabled = function () { /* todo */ };
  /** @function

  @name TextBox.__isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  TextBox.prototype.__isVisible = function () { /* todo */ };
  /** @function

  @name TextBox.__setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign.
   */
  TextBox.prototype.__setValue = function (value) { /* todo */ };
};
__binding.textbox_web = function () {
  /** @function

  @name TextBox.__initTextBox

  @description Do any additional initialization steps required for the text box wrapper.
  */
  TextBox.prototype.__initTextBox = function () {};
  /** @function

  @name TextBox.__getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  TextBox.prototype.__getFontColor = function () {
    var color = getStyle(this.control, "color");
    return color ? colorToHex(color) : 0x0;
  };
  /** @function

  @name TextBox.__getValue

  @description Retrieve text box value.
   */
  TextBox.prototype.__getValue = function () {
    return this.control.Text;
  };
  /** @function

  @name TextBox.__getName

  @description Retrieve text box name.
   */
  TextBox.prototype.__getName = function () {
    var res = this.control.idStr;
    res = aqString.Replace(res, "E_", "");
    res = aqString.Replace(res, "txt", "");
    res = aqString.Replace(res, "0_text", "");
    return res;
  };
  /** @function

  @name TextBox.__isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  TextBox.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function

  @name TextBox.__isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  TextBox.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function

  @name TextBox.__setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign.
   */
  TextBox.prototype.__setValue = function (value) {
    this.control.DblClick();
    this.control.Keys("^a");
    this.control.Keys(value);
  };
};
__binding.textbox_panel = function () {
  /** @function

  @name TextBox.__initTextBox

  @description Do any additional initialization steps required for the text box wrapper.
   */
  TextBox.prototype.__initTextBox = function () {};
  /** @function

  @name TextBox.__getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  TextBox.prototype.__getFontColor = function () {
    var color = getStyle(this.control, "color");
    return color ? colorToHex(color) : 0x0;
  };
  /** @function

  @name TextBox.__getValue

  @description Retrieve text box value.
   */
  TextBox.prototype.__getValue = function () {
    return this.control.contentText;
  };
  /** @function

  @name TextBox.__getName

  @description Retrieve text box name.
   */
  TextBox.prototype.__getName = function () {
    return "Cell";
  };
  /** @function

  @name TextBox.__isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  TextBox.prototype.__isEnabled = function () {
    return this.control.Enabled;
  };
  /** @function

  @name TextBox.__isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  TextBox.prototype.__isVisible = function () {
    return this.control.Visible;
  };
  /** @function

  @name TextBox.__setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign.
   */
  TextBox.prototype.__setValue = function (value) {
    this.control.DblClick();
    this.control.Keys("^a");
    this.control.Keys(value);
  };
};
__binding.textbox_web_tb = function () {
  TextBox.prototype.mObjectIdentifier = null;
  TextBox.prototype.mParent = null;
  TextBox.prototype.mTextBoxControl = null;
  TextBox.prototype.mTextAreaControl = null;
  /** @function @ignore

  @name synchronizeControls

  @description Provides up-to-date information about text box controls
   */
  function synchronizeControls() {
    this.mTextBoxControl = this.mParent.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Textbox", this.mObjectIdentifier, true], 0, true);
    this.mTextAreaControl = this.mParent.FindChild(["ObjectType", "ObjectIdentifier", "Visible"], ["Textarea", "TInputControl_Shadow", true], 0, true);
  }
  /** @function

  @name TextBox.__initTextBox

  @description Do any additional initialization steps required for the text box wrapper.
   */
  TextBox.prototype.__initTextBox = function () {
    this.mObjectIdentifier = this.control.ObjectIdentifier;
    this.mParent = this.control.Parent;
  };
  /** @function

  @name TextBox.__getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  TextBox.prototype.__getFontColor = function () {
    synchronizeControls.call(this);
    var color = getStyle(this.mTextBoxControl.Exists ? this.mTextBoxControl : this.mTextAreaControl, "color");
    return color ? colorToHex(color) : 0x0;
  };
  /** @function

  @name TextBox.__getValue

  @description Retrieve text box value.
   */
  TextBox.prototype.__getValue = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Text : this.mTextAreaControl.contentText;
  };
  /** @function

  @name TextBox.__getName

  @description Retrieve text box name.
   */
  TextBox.prototype.__getName = function () {
    return "Cell";
  };
  /** @function

  @name TextBox.__isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  TextBox.prototype.__isEnabled = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Enabled : this.mTextAreaControl.Enabled;
  };
  /** @function

  @name TextBox.__isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  TextBox.prototype.__isVisible = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Visible : this.mTextAreaControl.Visible;
  };
  /** @function

  @name TextBox.__setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign
   */
  TextBox.prototype.__setValue = function (value) {
    this.control.DblClick();
    synchronizeControls.call(this);
    var control = this.mTextBoxControl.Exists ? this.mTextBoxControl : this.mTextAreaControl;
    control.Keys("^a");
    control.Keys(value);
    control.blur();
  };
};
__binding.textbox_tenrox_password = function () {
  TextBox.prototype.mObjectIdentifier = null;
  TextBox.prototype.mParent = null;
  TextBox.prototype.mTextBoxControl = null;
  TextBox.prototype.mPasswordControl = null;
  /** @function @ignore

  @name synchronizeControls

  @description Provides up-to-date information about text box controls
   */
  function synchronizeControls() {
    this.mTextBoxControl = this.mParent.FindChild(["ObjectType", "ObjectIdentifier"], ["Textbox", this.mObjectIdentifier], 0, true);
    this.mPasswordControl = this.mParent.FindChild(["ObjectType", "ObjectIdentifier"], ["PasswordBox", this.mObjectIdentifier], 0, true);
  }
  /** @function

  @name TextBox.__initTextBox

  @description Do any additional initialization steps required for the text box wrapper.
   */
  TextBox.prototype.__initTextBox = function () {
    this.mObjectIdentifier = this.control.ObjectIdentifier;
    this.mParent = this.control.Parent;
  };
  /** @function

  @name TextBox.__getFontColor

  @description Retrieve text box font color.

  @returns {Object} Text box font color.
   */
  TextBox.prototype.__getFontColor = function () {
    synchronizeControls.call(this);
    var color = getStyle(this.mTextBoxControl.Exists ? this.mTextBoxControl : this.mPasswordControl, "color");
    return color ? colorToHex(color) : 0x0;
  };
  /** @function

  @name TextBox.__getValue

  @description Retrieve text box value.
   */
  TextBox.prototype.__getValue = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Text : this.mPasswordControl.Text;
  };
  /** @function

  @name TextBox.__getName

  @description Retrieve text box name.
   */
  TextBox.prototype.__getName = function () {
    var textboxControl;
    synchronizeControls.call(this);
    textboxControl = this.mTextBoxControl.Exists ? this.mTextBoxControl : this.mPasswordControl;
    return aqString.Replace(textboxControl.idStr, "E_", "");
  };
  /** @function

  @name TextBox.__isEnabled

  @description Check whether a text box is enabled.

  @returns {boolean} Text box is enabled.
   */
  TextBox.prototype.__isEnabled = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Enabled : this.mPasswordControl.Enabled;
  };
  /** @function

  @name TextBox.__isVisible

  @description Check whether a text box is visible on screen.

  @returns {boolean} Text box is visible on screen.
   */
  TextBox.prototype.__isVisible = function () {
    synchronizeControls.call(this);
    return this.mTextBoxControl.Exists ? this.mTextBoxControl.Visible : this.mPasswordControl.Visible;
  };
  /** @function

  @name TextBox.__setValue

  @description Assign new value to a text box.

  @param {String} value New value to assign
   */
  TextBox.prototype.__setValue = function (value) {
    this.control.DblClick();
    synchronizeControls.call(this);
    var control = this.mTextBoxControl.Exists ? this.mTextBoxControl : this.mPasswordControl;
    control.Keys("^a");
    control.Keys(value);
  };
};