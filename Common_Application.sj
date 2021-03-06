//USEUNIT Private_Application
//USEUNIT Common_Window

/** @function
    
    @name Common_Application.WaitForLoad
    
    @description Check if an application is ready.
    
    @param {Object} control  TestComplete's object containing an application.
    @param {Integer} timeout Amount of time to wait for.

*/
function WaitForLoad(control, timeout) {
  var startTime, runTimeout;
  try {
    Log.AppendFolder("Common_Application.WaitForLoad");
    startTime = GetTickCount();
    
    runTimeout = Options.Run.Timeout;
    Options.Run.Timeout = 5000;
    Common_Window.WaitForObjectToAppear(control, timeout);
    Options.Run.Timeout = runTimeout;
    
    var r = Private_Application.initWrapper(control).waitForLoad(timeout + startTime - GetTickCount());
    if (r) Log.Message("Application has finished loading.");
    else Log.Error("Application has failed to load in time.");
  } catch (e) { Log.Error("Oops! There's some glitch in the script: " + e); return;
  } finally { Log.PopLogFolder(); }
}