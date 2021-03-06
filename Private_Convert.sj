
/**
 * Converts object to array
 * 
 * @param object object to convert
 * @result {array}
 */
function ObjectToArray(object)
{
  var res = [];
  var typeID = GetVarType(object); 
  
  switch (typeID) {
    //String
    case varOleStr :
      var separator = aqString.ListSeparator
      aqString.ListSeparator = "|"
      for (var index = 0; index < aqString.GetListLength(object); index++) 
      {
        res.push(aqString.GetListItem(object, index));
      }
      aqString.ListSeparator = separator;
      break;
    //Also array
    case varDispatch :
      res = object;
      break
    default:
      res.push(object.toString());
      break;
  }
  //Array
  if ((typeID >= varArray) && (typeID <= varArray + varInt64))
  {
     res = object;
  }
  return res;
}

/**
 * Converts 2 object to one array using object1 as list of indexes 
 *      and object2 as list of values
 * 
 * @param object1 Object with property names
 * @param object2 Object with values 
 * @result {array}
 */
function ObjectsToArray(object1, object2)
{
  var array1 = ObjectToArray(object1);
  var array2 = ObjectToArray(object2);

  /* Check both array size and make sure they are equal in size*/
  if (array1.length != array2.length)
  {
    Log.Error("Property Name Array size Does not equal property value Array size");
  }
  
  var res = new Array(array1.length); 
  for (index = 0; index < array1.length; index++)
  { 
    res[array1[index]] = array2[index];
  }
  
  return res;
}