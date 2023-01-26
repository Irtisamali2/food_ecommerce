import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
late String token; //token for server
final String appBaseUrl; //server Url
late Map<String, String> _mainHeaders; //main headers <key, Pair>

  ApiClient({required this.appBaseUrl}){
    baseUrl=appBaseUrl;
    timeout= const Duration(seconds: 30);
//map initialize
token=AppConstants.TOKEN;
    _mainHeaders={
'Content-type':'application/json; charset=utf-8',
'Authorization': 'Bearer $token', //to post requestv -- bearer is a type
    };
  }
void updateHeader(String token){
   _mainHeaders={
'Content-type':'application/json; charset=utf-8',
'Authorization': 'Bearer $token', //to post requestv -- bearer is a type
    };
}
Future<Response> getData(String uri) async {
  try{
  Response response=  await get(uri);
  return response;
  }catch(e){
    return Response(statusCode: 1,statusText: e.toString());
  }
}

Future<Response> postData(String uri, dynamic body)async{
  try{
   Response response= await post(uri, body,headers: _mainHeaders);
   return response;
  }catch(e){
    print(e.toString());
    return Response(statusCode: 1, statusText: e.toString());

  }
}
}