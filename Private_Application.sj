//USEUNIT Private_Utils
/** @ignore @description Control binding */
var __binding = {};
/** @ignore @description Initialize control wrapper */
function initWrapper(control) {
  var __wrapper;
  try {
    __wrapper = new Application(control);
  } catch (e) {
    Log.Error("Runtime Object initialization failed. Reason: " + e.message);
    return;
  }
  Log.Message("Runtime Object initialization succeeded.");
  return __wrapper;
}
/* Object Model ***********************************************************************************/
/** @class "Application" object model
    
    @description Represents an application.
    
    @param {Object} control TestComplete's object containing an application.
*/
Application = function (control) {
  /** @field
      
      @description Stores control for which this object model is created.
  */
  this.control = this.__initialize(control);
  /** @function
      
      @name Application.waitForLoad
      
      @description Wait for application to load.
      
      @param {Integer} timeout Amount of time to wait.
      
      @returns {Object} Application has been loaded in time.
  */
  this.waitForLoad = function (timeout) {
    var c = 0, t, isReady = false;
    t = aqDateTime.Now() + timeout;
    while (aqDateTime.Now() < t) {
      isReady = this.__isReady();
      if (isReady) {
        c++;
      } else {
        c = 0;
      }
      // Refreshing the system.
      Sys.Refresh();
      Aliases.RefreshMappingInfo();
      aqUtils.Delay(400, "Waiting for application to load...");
      // return true if the application state remain the same for at least 5 * 400ms.
      if (c > 5) {
        return true;
      }
    }
    return isReady;
  };
};
/* Object Bindings ********************************************************************************/
/** @function
    
    @name Application.__initialize
    
    @description Initialize control passed to "Application" object.
    
    @param {Object} control TestComplete's object containing an application.
    
    @returns {Object} Same control if it passes initialization.
    
    @throws Runtime Object initialization failed.
*/
Application.prototype.__initialize = function (control) {
  var b = [], process, i;
  // if (control properties looks good) { select apropriate binding }
  // Bindings can be stacked. Most common one should go first.
  if (true) { 
    b.push(__binding.application_default);
  }

  process = Private_Utils.GetProcess(control);

  if (process.ProcessName === "iexplore") {
    b.push(__binding.application_webPage);
  }
  if (process.ProcessName === "TenroxSoftware.DBAdmin.App") {
    b.push(__binding.application_TenroxDBAdmin);
  }
  for (i = 0; i < b.length; i++) {
    b[i]();
  }
  return control;
};
/** @Description "Application" default objects binding */
__binding.application_default = function () {
  /** @function
      
      @name Application.__isReady
      
      @description Check whether an application is ready.
      
      @returns {boolean} Application is ready.
  */
  Application.prototype.__isReady = function () {};
};
/** @description "Application" web object bindings. */
__binding.application_webPage = function () {
  /** @function
      
      @name Application.__isReady
      
      @description Check whether an application is ready.
      
      @returns {boolean} Application is ready.
  */
  Application.prototype.__isReady = function () {
    var frames, isReady, i, loaderImage, page;
    page = this.control;
    while (page.Parent && (!aqObject.IsSupported(page, "ObjectType") || page.ObjectType !== "Page")) {
      page = page.Parent;
    }
    frames = page.FindAllChildren("ObjectType", "Frame", 10, true).toArray();
    isReady = true;
    for (i = 0; i < frames.length; i++) {
      if ((frames[i].Exists) && (frames[i].contentDocument.readyState !== "complete")) {
        isReady = false;
        break;
      }
    }
    if (isReady) {
      loaderImage = page.FindAllChildren("ObjectIdentifier", "loadingImage", 10);
      for (i = 0; i < loaderImage.length; i++) {
        if (loaderImage.VisibleOnScreen) {
          isReady = false;
          break;
        }
      }
    }
    return isReady;
  };
};
/* Binding Tenrox Database Admin Application*/
__binding.application_TenroxDBAdmin = function () {
  /** @ignore */
  Application.prototype.__cursorWaitState = null;
  Application.prototype.__cursorAppStartingState = null;
  Application.prototype.__initCursorStates = function () {
    var token, dll;
    token = "USER32_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%H%M%S");
    DLL.DefineDLL(token).DefineProc("LoadCursorW", VT_I4, VT_UI2, VT_I4);
    dll = DLL.Load("USER32.DLL", token);
    // get the propper cursor state to compare with
    this.__cursorWaitState = dll.LoadCursorW(0, Win32API.IDC_WAIT);
    this.__cursorAppStartingState = dll.LoadCursorW(0, Win32API.IDC_APPSTARTING);
  };
  /** @ignore */
  Application.prototype.__getCursorWaitState = function () {
    if (!this.__cursorWaitState) {
      this.__initCursorStates();
    }
    return this.__cursorWaitState;
  };
  /** @ignore */
  Application.prototype.__getCursorAppStartingState = function () {
    if (!this.__cursorAppStartingState) {
      this.__initCursorStates();
    }
    return this.__cursorAppStartingState;
  };
  /** @function
      
      @name Application.__isReady
      
      @description Check whether an application is ready.
      
      @returns {boolean} Application is ready.
  */
  Application.prototype.__isReady = function () {
    var processId, threadId, cursor, isReady, rootProcess, hoverControls, i;
    rootProcess = this.control;
    while (rootProcess.Parent && !aqObject.IsSupported(rootProcess, "ProcessName")) {
      rootProcess = rootProcess.Parent;
    }
    isReady = true;
    hoverControls = rootProcess.FindAllChildren("WndClass", "WindowsForms*").toArray();
    for (i = 0; i < hoverControls.length && isReady; i++) {
      if (hoverControls[i].Enabled === true && hoverControls[i].Visible === true && aqObject.IsSupported(hoverControls[i], "HoverMouse") === true) {
        //move mouse over window
        Log.LockEvents();
        hoverControls[i].HoverMouse();
        Log.UnlockEvents();
        processId = Win32API.GetWindowThreadProcessId(hoverControls[i].Handle, null);
        threadId = Win32API.GetCurrentThreadId();
        Win32API.AttachThreadInput(processId, threadId, true);
        cursor = Win32API.GetCursor();
        Win32API.AttachThreadInput(processId, threadId, false);
        isReady = isReady && (cursor !== this.__getCursorWaitState() && cursor !== this.__getCursorAppStartingState());
      }
    }
    return isReady;
  };
};