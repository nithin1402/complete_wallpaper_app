
import 'dart:convert';
import 'dart:io';

import 'package:complete_wallpaper_app/data/remote/app_exceptions.dart';
import 'package:http/http.dart' as httpClient;

class ApiHelper{

  Future<dynamic> getApi({required String url}) async{
    var uri = Uri.parse(url);

    try{
      var res = await httpClient.get(uri,headers: {
        "Authorization" : "rVzFm8Z3MCNseYT1pjM0MtsQfQ8QDvzG0WZl4icJGGPBkMZ9TtiT8ki3"
      });
      return returnJsonResponse(res);
    } on SocketException catch(e){
      throw (FetchDataException(errorMsg: "No Internet!"));
    }
  }
  
  dynamic returnJsonResponse(httpClient.Response response){
    switch (response.statusCode){
      case 200:
        {
          var mData = jsonDecode(response.body);
          return mData;
        }
        
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(errorMsg: response.body.toString());
      case 500:
        default:
          throw FetchDataException(errorMsg: "Error occurred while communication with server with statuscode: ${response.body.toString()}");
    }
  }

}