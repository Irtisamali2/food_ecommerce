import 'package:food_ecommerce/models/signup_body_model.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/apiClient.dart';

class AuthRepo{
  final ApiClient apiClinet;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClinet, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody)async{
   return await apiClinet.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());


  }
Future<String> getUSerToken() async {
  return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
}
    Future<Response> login(String email, String password )async{
   return await apiClinet.postData(AppConstants.LOGIN_URI, {"email":email, "password":password});


  }
      //token create on register and save locally then when login it 
    //send back to server, if server find token then it authenticated
    Future<bool> saveUserToken(String token) async {
      apiClinet.token=token;  
      apiClinet.updateHeader(token);
      return await sharedPreferences.setString(AppConstants.TOKEN, token);
    }
    Future<void> saveUserNumberAndPassword(String number, String password) async {
      try{
         await sharedPreferences.setString(AppConstants.PHONE, number);
         await sharedPreferences.setString(AppConstants.PASSWORD, password);
      }
      catch(e){
        throw e;
      }
    }
}