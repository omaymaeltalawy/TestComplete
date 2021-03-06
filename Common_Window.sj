//USEUNIT Private_Utils

/**
 * Wait for object to have Exists equal false;
 * 
 * @param Object Alias from NameMapping
 * @param Timeout Timeout
 */
function WaitForObjectToDispose(Object, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for object to dispose",
    "Object disposed",
    "Timeout elapsed. Object not disposed",
    function() { return !Object.Exists; },
    Timeout);
}

/**
 * Wait for object to have Exists equal true;
 * 
 * @param Object Alias from NameMapping
 * @param Timeout Timeout
 */
function WaitForObjectToAppear(Object, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for object to appear",
    "Object appeared",
    "Timeout elapsed. Object did not appeared",
    function() { return Object.Exists; },
    Timeout);
}

/**
 * Wait for object to have Exists and VisibleOnScreen equal true;
 * 
 * @param Object Alias from NameMapping
 * @param Timeout Timeout
 */
function WaitForObjectToBeVisibleOnScreen(Object, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for object to be visible on screen",
    "Object is visible on screen",
    "Timeout elapsed. Object is not visible on screen",
    function() { return Object.Exists && Object.VisibleOnScreen; },
    Timeout);
}

/**
 * Wait for object to have Exists or VisibleOnScreen equal false;
 * 
 * @param Object Alias from NameMapping
 * @param Timeout Timeout
 */
function WaitForObjectToBeInvisibleOnScreen(Object, Timeout)
{
  Private_Utils.WaitFor(
    "Waiting for object to be invisible on screen",
    "Object is invisible on screen",
    "Timeout expired. Object is still visible on screen",
    function() { return !Object.Exists || !Object.VisibleOnScreen; },
    Timeout);
}