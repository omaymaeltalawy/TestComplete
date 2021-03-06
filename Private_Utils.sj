/**
*  This namespace is intended to contain common functionality in an organized way to improve code reuse.
*  Feel free to add generic, well rounded, well thought, commonly used methods.
* @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
* @creation 13/01/2013
*/

var COMMON_REPOSITORY = {
  BindingHelpers : {
    CreateBindingMap : function (PropertyKeyaluePairs, Binding) {
      return {
        identificationCriteria : PropertyKeyaluePairs,
        binding: Binding
      };
    }
  },
  Exceptions : {
    /*
    *  This function is used to create a custom exception. While you can create any exception on the fly, it's usually best to 
    *  DEFINE an exception instead of creating random ones (such as NotImplementedException defined below) and try to reuse the existing ones
    * @param {string} Name - Exception name
    * @param {string} Message - Message displayed to the user explaining the cause of the exception
    * @return {object} - An object representing an exception
    * @example - throw COMMON_REPOSITORY.Exceptions.BaseException("CodeFailedException", "This is a meaningful message explaining why")
    * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
    * @creation 01/09/2014
    */
    BaseException : function (Name, Message) {
      Name = Name || "BaseException";
      Message = Message || "An error occurred";
      return {
        name : Name,
        message : Message,
        toString : function () {return this.Name + ": " + this.Message; }
      };
    },
    /*
    *  This function is used to create a meaningful exception when an item could not be found within a control or an object
    * @param {string} ItemName - The name of the item not found
    * @param {string} [Details=""] - Extra details to explain our case.
    * @return {object} - An object representing an exception
    * @example - throw COMMON_REPOSITORY.Exceptions.ItemNotFoundException()
    * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
    * @creation 01/09/2014
    */
    ItemNotFoundException : function (ItemName, Details) {
      return COMMON_REPOSITORY.Exceptions.BaseException("ItemNotFoundException", "The item '" + ItemName + "' could not be found. " + (Details || ""));
    },
    /*
    *  This function is used to create a meaningful exception when a method has yet not been implemented
    * @return {object} - An object representing an exception
    * @example - throw COMMON_REPOSITORY.Exceptions.NotImplementedException()
    * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
    * @creation 01/09/2014
    */
    NotImplementedException : function () {
      return COMMON_REPOSITORY.Exceptions.BaseException("NotImplementedException", "This method is not implemented");
    }
  },
  Control : {
    /*
    *  Finds the parent object that matches the KeyValuPairsSpecification
    * @param {object} TargetObject - The leaf of the tree that we'll scalate
    * @param {object} KeyValuPairsSpecification - A set of properties and values to match the parent with
    * @return {object}
    * @example - COMMON_REPOSITORY.Control.FindParentByProperties(TargetObject, {"PropertyA" : "ValueA", "PropertyB" : "ValueB"})
    * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
    * @creation 01/09/2014
    */
    FindParentByProperties : function (TargetObject, KeyValuPairsSpecification) {

      if (COMMON_REPOSITORY.Control.IsIdentifiedBy(TargetObject, KeyValuPairsSpecification)) {
        return TargetObject;
      }
      if (aqObject.IsSupported(TargetObject, 'Parent') && TargetObject.Parent.Exists) {
        return COMMON_REPOSITORY.Control.FindParentByProperties(TargetObject.Parent, KeyValuPairsSpecification);
      }
      return null;
    },
    /*
    *  Tells if an object matches the KeyValuPairsSpecification
    * @param {object} TargetObject
    * @param {object} KeyValuPairsSpecification - A set of properties and values to match the object with
    * @return {boolean}
    * @example - COMMON_REPOSITORY.Control.IsIdentifiedBy(TargetObject, {"PropertyA" : "ValueA", "PropertyB" : "ValueB"})
    * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
    * @creation 01/09/2014
    */
    IsIdentifiedBy : function (Control, KeyValuPairsSpecification) {
      var value, property, j, properties, targetObject;
      for (property in KeyValuPairsSpecification) {
        if (KeyValuPairsSpecification.hasOwnProperty(property)) {
          value = KeyValuPairsSpecification[property];
          if (property.match(/\./) !== null) {
            properties = property.split(".");
            for (j = 0; j < properties.length - 1; j++) {
              targetObject = Control[properties[j]];
              property = properties[j + 1];
            }
          } else {
            targetObject = Control;
          }
          if (!(aqObject.IsSupported(Control, property) && (value === "*" || (StringMatches(targetObject[property], value))))) {
            return false;
          }
        }
      }
      return true;
    }
  },
  Objects : {
    Strings : {
      /*
      *  Formats an string
      * @param {String} format - The string we will format
      * @return {String} - The formatted string
      * @example
      * COMMON_REPOSITORY.Strings.Format("I like {0}, but I dislike {1}. Hand me {2} bars", 
      * 'Chocolate', 'Mint', 3)
      * Will return: "I like Chocolate, but I dislike Mint. Hand me 3 bars"
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 01/27/2014
      */
      Format : function (format) {
        var args, sprintfRegex, sprintf;
        args = Array.prototype.slice.call(arguments, 1);
        sprintfRegex = /\{(\d+)\}/g;
        sprintf = function (match, number) {
          return number in args ? args[number] : match;
        };
        return format.replace(sprintfRegex, sprintf);
      }
    },
    Arrays : {
      /*
      *  Tells whether an array contains an object or not
      * @param {object[]} ArraySource - The array to search in
      * @param {object} ObjectToSearch - What we'll be searching for
      * @return {boolean}
      * @example - COMMON_REPOSITORY.Arrays.Contains([1, 2, 3], 2)
      * @example - COMMON_REPOSITORY.Arrays.Contains(["a", "b", "c"], "f")
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 01/09/2014
      */
      Contains : function (ArraySource, ObjectToSearch) {
        var i;
        if (ArraySource === null || ArraySource === undefined) {
          return false;
        }
        for (i = 0; i < ArraySource.length; i++) {
          if (ArraySource[i] === ObjectToSearch) {
            return true;
          }
        }
        return false;
      },
      /*
      *  Tells whether there's any element that matches the given criteria
      * @param {object[]} ArrayObject - The array to search in
      * @param {object} Criteria - The function to match the element
      * @return {object}
      * @example - COMMON_REPOSITORY.Arrays.Any([1, 2, 3], function (item) { return item > 0 && item % 2 === 0; }) -> Returns true because there's a pair
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 13/09/2014
      */
      Any : function (ArraySource, Criteria) {
        var i;
        for (i = 0; i < ArraySource.length; i++) {
          if (Criteria(ArraySource[i], i)) {
            return true;
          }
        }
        return false;
      },
      /*
      *  Retrieves the first element matching the given criteria
      * @param {object[]} ArrayObject - The array to search in
      * @param {object} Criteria - The function to match the element
      * @return {object}
      * @example - COMMON_REPOSITORY.Arrays.FirstOrDefault([1, 2, 3], function (item) { return item > 0 && item % 2 === 0; }) -> Returns pairs
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 13/09/2014
      */
      FirstOrDefault : function (ArraySource, Criteria) {
        var i;
        for (i = 0; i < ArraySource.length; i++) {
          if (Criteria(ArraySource[i], i)) {
            return ArraySource[i];
          }
        }
        return null;
      },
      /*
      *  Transforms/Maps each element of an array using the given mapper
      * @param {object[]} ArrayObject - The array to search in
      * @param {object} Mapper - The function to transform/map the item
      * @return {object[]}
      * @example - COMMON_REPOSITORY.Arrays.Select([1, 2, 3], function (item) { return item*item; })
      * @example - COMMON_REPOSITORY.Arrays.Select(["a", "b", "c"], function () { return item.toUpperCase(); })
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 13/09/2014
      */
      Select : function (ArraySource, Mapper) {
        if (typeof Mapper !== "function") {
          return [];
        }
        var i, mappedElements = [];
        for (i = 0; i < ArraySource.length; i++) {
          mappedElements.push(Mapper(ArraySource[i], i));
        }
        return mappedElements;
      },
      /*
      *  Filters the array using the given criteria
      * @param {object[]} ArrayObject - The array to search in
      * @param {object} Criteria - The function to filter the array
      * @return {object[]}
      * @example - COMMON_REPOSITORY.Arrays.Where([1, 2, 3], function (item) { return item > 0 && item % 2 === 0; }) -> Returns pairs
      * @author Jefferson De La Cruz Blanco <jefferson.blanco@gteamstaff.com>
      * @creation 13/09/2014
      */
      Where : function (ArraySource, Criteria) {
        var i, matchedElements = [];
        for (i = 0; i < ArraySource.length; i++) {
          if (Criteria(ArraySource[i], i)) {
            matchedElements.push(ArraySource[i]);
          }
        }
        return matchedElements;
      }
    }
  },
  Picture : {
    /** @function 

        @name ToBlackAndWhite

        @description Convert a picture to the black and white version

        @param {Object} picture The picture to convert

        @param {Integer} pivot Optional, the value above which colors are considered white (e.g. 127)
        
        @returns {Object} The black and white picture
        
        @author Mohammad Aliraqi <mohameed.aliraqi@gdev.biz>
        
        @creation 20/01/2014
    */
    ToBlackAndWhite : function (picture, pivot) {
      if (pivot === null || pivot === undefined) {
        // this value is better for Everest than the normal 127
        pivot = 140;
      }

      var result, i, j, pixel, blue, green, red;

      result = picture.GetRect(0, 0); //clone the picture

      for (i = 0; i < result.Size.Width; i++) {
        for (j = 0; j < result.Size.Height; j++) {
          pixel = result.Pixels(i, j);
          blue = (pixel >> 16) & 0xFF;
          green = (pixel >> 8) & 0xFF;
          red = pixel & 0xFF;

          pixel = (blue + green + red) / 3;

          pixel = pixel > pivot ? 0xFFFFFF : 0;
          result.Pixels(i, j) = pixel;
        }
      }
      
      return result;
    },

    /** @function

        @name ToNegative

        @description Convert a picture to the negative version

        @param {Object} picture The picture to convert

        @returns {Object} The negative picture
        
        @author Mohammad Aliraqi <mohameed.aliraqi@gdev.biz>
        
        @creation 20/01/2014
    */
    ToNegative : function (picture) {
      var result, i, j, pixel;

      result = picture.GetRect(0, 0); //clone the picture

      for (i = 0; i < result.Size.Width; i++) {
        for (j = 0; j < result.Size.Height; j++) {
          pixel = result.Pixels(i, j);
          pixel = 0xFFFFFF - pixel;
          result.Pixels(i, j) = pixel;
        }
      }
      
      return result;
    }
  },
  WinAPI : {
    /** @function

      @name TwipsPerPixelX
      
      @description Utility function to convert metrics based on X-Axis (Left and Width) from Twips to Pixels.

      @date 2014/2/2
      
      @author Mohammad Aliraqi <mohameed.aliraqi@gdev.biz>
    */
    TwipsPerPixelX : function () {
      var LOGPIXELSX = 88,
        hWndDesk, hDCDesk,
        logPix, r;

      //Get the handle of the desktop window
      hWndDesk = Win32API.GetDesktopWindow();

      //Get the desktop window's device context
      hDCDesk = Win32API.GetDC(hWndDesk);

      //Get the width of the screen
      logPix = Win32API.GetDeviceCaps(hDCDesk, LOGPIXELSX);

      //Release the device context
      r = Win32API.ReleaseDC(hWndDesk, hDCDesk);

      return 1440/logPix; //1 inch is always 1440 twips
    },
    /** @function

      @name TwipsPerPixelY
      
      @description Utility function to convert metrics based on Y-Axis (Top and Height) from Twips to Pixels.

      @date 2014/2/2
      
      @author Mohammad Aliraqi <mohameed.aliraqi@gdev.biz>
    */
    TwipsPerPixelY : function () {
      var LOGPIXELSY = 90,
        hWndDesk, hDCDesk,
        logPix, r;

      //Get the handle of the desktop window
      hWndDesk = Win32API.GetDesktopWindow();

      //Get the desktop window's device context
      hDCDesk = Win32API.GetDC(hWndDesk);

      //Get the width of the screen
      logPix = Win32API.GetDeviceCaps(hDCDesk, LOGPIXELSY);

      //Release the device context
      r = Win32API.ReleaseDC(hWndDesk, hDCDesk);

      return 1440/logPix; //1 inch is always 1440 twips
    }
  }
};

/**
 * Wait for Condition during specified timeout
 *
 * @param ExecutionMessage Message to show it TC status during execution
 * @param SuccessMessage Message to log if Condition passed
 * @param FailureMessage Message to log if Condition not passed during timeout
 * @param Condition function which return is current state acceptable
 * @param Timeout Timeout 
 */
function WaitFor(ExecutionMessage, SuccessMessage, FailureMessage, Condition, Timeout) {
  var stopTime;
  stopTime = GetTickCount() + Timeout;

  //Delay for Timeout seconds until the Service is started Completely
  while (GetTickCount() < stopTime) {
    Sys.Refresh();
    Aliases.RefreshMappingInfo();

    if (Condition()) {
      Log.Checkpoint(SuccessMessage);
      return;
    }
    Delay(500, ExecutionMessage);
  }
  Log.Error(FailureMessage);
}

/**
 * Verify is string contains Expression and returns true or false
 * Expression could be in next formats:
 *  1) "value" - check is string equal value
 *  2) "!value" - check is string not equal value 
 *  3) "!!value" - check is string equal value "!value"
 *  4) "/regexp/" - check is string contains regular expression
 *  5) "!/regexp/" - check is string not contains regular expression
 *
 * @param String String to search in
 * @param Expr Expression to search
 * @return {bool} Result
 */
function StringMatches(String, Expr) {
  var match, reverse, regexp, searchString, length;
  reverse = false;
  regexp = false;

  if (String === null || Expr === null) {
    return false;
  }

  searchString = Expr;
  length = aqString.GetLength(searchString);

  if (length > 1) {
    if (aqString.SubString(searchString, 0, 2) === "!!") {
      searchString = aqString.Remove(searchString, 0, 1);
      length = aqString.GetLength(searchString);
    } else if (aqString.SubString(searchString, 0, 1) === "!") {
      searchString = aqString.Remove(searchString, 0, 1);
      length = aqString.GetLength(searchString);
      reverse = true;
    }
  }

  if (length > 1) {
    if (aqString.SubString(searchString, 0, 1) === "/"
        && aqString.SubString(searchString, length - 1, 1) === "/") {
      searchString = aqString.SubString(searchString, 1, length - 2);
      regexp = true;
    }
  }

  match = regexp
    ? aqString.StrMatches(searchString, String)
    : aqString.Compare(String, searchString, true) === 0;

  if (reverse) {
    return !match;
  }
  return match;
}

function GetBrowser(TargetObject) {
  return COMMON_REPOSITORY.Control.FindParentByProperties(TargetObject, {"ObjectType" : "Browser"});
}

function GetPage(TargetObject) {
  return COMMON_REPOSITORY.Control.FindParentByProperties(TargetObject, {"ObjectType" : "Page"});
}

function GetProcess(TargetObject) {
  return COMMON_REPOSITORY.Control.FindParentByProperties(TargetObject, {"Parent" : "*", "Parent.Name" : "Sys"});
}


function GetParentByType(object, type) {
  var res = object;
  while(res.ObjectType != type){
    res = res.Parent
  }
  return res
}
function GetParentByClassName(object, type) {
  var res = object;
  while(res.ClassName != type){
    res = res.Parent
  }
  return res
}


//Convert an items string seperated by '|' to Array
function InputsToArray(data)
{
  var res = [];
  var typeID = GetVarType(data) 
  
  switch (typeID) 
  {
    //String
    case varOleStr :
      if (data != "") 
      {
        var separator = aqString.ListSeparator
        aqString.ListSeparator = "|"
        for (var index = 0; index < aqString.GetListLength(data); index++) 
        {
          res.push(aqString.GetListItem(data, index))
        }
        aqString.ListSeparator = separator
      }
      break
    //Also array
    case varDispatch :
      res = data
      break
  }
  //Array
  if ((typeID >= varArray) && (typeID <= varArray + varInt64))
  {
     res = data
  }
  return res
}

//Try to find the index of the given item from a string array
function IndexOf(targetArray,item) 
{
  for (var i = 0; i < targetArray.length; i++)
  {
    if ((i in targetArray) && (targetArray[i] == item)) return i
  }
  return -1
}

function GetItemsArrayFromString(itemNamesString) 
{
   //Separate string to array with '|'
   var ItemsArray = InputsToArray(itemNamesString)
   //Check whether there is any result or not
   if (itemNamesString.length == 0)
   {
      Log.Error("Provided Items is Empty")
      return null
   }
    else 
   {
      return ItemsArray
   }
}

function DateString2Array(dateString)
{
  var monthDict = {"01":"Jan","02":"Feb","03":"Mar","04":"Apr","05":"May","06":"Jun","07":"Jul","08":"Aug","09":"Sep","10":"Oct","11":"Nov","12":"Dec"}
  var res = dateString.split('-')
  res[0] = monthDict[res[0]]
  return res
}

// this function needs to be removed as soon as the TPopupDBTreeView object has been namemapped.
function DoubleClickPopupDBTreeView(itemPath) {
  var tree = Aliases.Everest.FindChild('WndClass', 'TPopupDBTreeView');
  tree.DblClickItem(itemPath);
}

function CombineToArraysInOne(Array1 , Array2)
{
  var array1 = InputsToArray(Array1);
  var array2 = InputsToArray(Array2);

  /* Check both array size and make sure they are equal in size*/
  if (array1.length != array2.length)
  {
    Log.Error("Property Name Array size Does not equal property value Array size");
  }
  
  var MultiArray = new Array(array1.length); 
  /* Loop on all array Elements*/
  for (index = 0; index < array1.length; index++)
  { 
    /* Create a Sub Array inside the array Element to hold the merged Items ( It is the same as a MultiDimenstional Array)*/
    MultiArray[index] = new Array(2);
    /* Store the first Element*/
    MultiArray[index][0] = array1[index];
    /* Store the Second Element*/
    MultiArray[index][1] = array2[index];
  }
  
  return MultiArray;
}

function GetBackgroundColor(Object, XStepSize, YStepSize) {
  // Colors array is to keep track of count of pixel having a distinct color 
  var colors, maxColor, maxColorCount, picObject, currentPix, x, y;
  colors = [];
  maxColor = 0;
  maxColorCount = 0;
  picObject = Object.Picture();
  for (x = 0; x < picObject.Size.Width; x += XStepSize) {
    for (y = 0; y < picObject.Size.Height; y += YStepSize) {
      // Get the color of this pixel 
      currentPix = picObject.Pixels(x, y);
      if (colors[currentPix] === null || colors[currentPix] === undefined) {
        colors[currentPix] = 0;
      }
      colors[currentPix]++;
      if (colors[currentPix] > maxColorCount) {
        maxColorCount = colors[currentPix];
        maxColor = currentPix;
      }
    }
  }
  return maxColor;
}

function InputsToDate(data) {
  var res = null;
  var typeID = GetVarType(data); 
  
  switch (typeID) {
    //String
    case varOleStr :
      try {
        res = aqConvert.StrToDateTime(data);
      } catch(e) {
        Log.Message("Failing to convert string to date");
      }
      break;
    case varDate:
      res = data;
      break;
  }
  return res;
}

/** @function
    @name GetComingDay
    @description get date of the special day in next week
    @param {String} day  The string of day.
    @param {String} format The datre format
    @return {Date} the special date with format
*/
function GetComingDay(day, format) {
    var dateIndex, currentDateIndex, date, today;
    today = aqDateTime.Today();
    currentDateIndex = aqDateTime.GetDayOfWeek(today);
    switch (day) {
    case "Monday":
        dateIndex = 0;
        break;
    case "Tuesday":
        dateIndex = 1;
        break;
    case "Wednesday":
        dateIndex = 2;
        break;
    case "Thursday":
        dateIndex = 3;
        break;
    case "Friday":
        dateIndex = 4;
        break;
    case "Saturday":
        dateIndex = 5;
        break;
    case "Sunday":
        dateIndex = 6;
        break;
    default:
        dateIndex = 0;
        break;
    }
    currentDateIndex = currentDateIndex === 1 ? 8 : currentDateIndex;
    date = aqDateTime.AddDays(today, 2 + 7 - currentDateIndex + dateIndex);
    return aqConvert.DateTimeToFormatStr(date, format);
}