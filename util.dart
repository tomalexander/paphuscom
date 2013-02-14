library util;

import 'dart:html';

/** 
 * Asynchronously call the server and pass the string of the output to the callback function
 *
 * @param address The address to call
 * @param url_data url encoded variables
 * @param callback The function to pass the string to when the data is returned
 */
void get_string(String address, String url_data, callback)
{
  HttpRequest request = new HttpRequest();
  
  request.on.load.add((Event event) {
    callback(request.responseText);
  });
  
  // POST the data to the server
  request.open("POST", address, true);
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  request.send(url_data); // perform the async POST
}

/** 
 * Synchronously call the server and return the string from the output
 *
 * @param address The address to call
 * @param url_data url encoded variables
 *
 * @return The output from the call to the server
 */
String get_string_synchronous(String address, String url_data)
{
  HttpRequest request = new HttpRequest();
  
  // POST the data to the server
  request.open("POST", address, false);
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  request.send(url_data); // perform the sync POST
  return request.responseText;
}

String get_cookie(String name)
{
  List<String> cookies = document.cookie.split(";");
  for (int i = 0; i < cookies.length; ++i)
    {
      List<String> split = cookies[i].split("=");
      if (split[0] == name)
        {
          return split[1];
        }
    }
  return null;
}