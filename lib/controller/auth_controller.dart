import 'package:food_ecommerce/data/api/apiClient.dart';
import 'package:food_ecommerce/models/response_model.dart';
import 'package:food_ecommerce/models/signup_body_model.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration (SignUpBody signUpBody)async{
    _isLoading=true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.registration(signUpBody);
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print(response.body);
      
    }else{
            responseModel = ResponseModel(false, response.statusText!);

    }
    _isLoading=false;
    update();
    return responseModel;


  }
   Future<ResponseModel> login (String email, String password)async{
    print("Getting Token");
    authRepo.getUSerToken();
    print(authRepo.getUSerToken().toString());
    _isLoading=true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.login(email, password);
    if(response.statusCode==200){
      print("Backend Token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
      print(response.body);
      
    }else{
            responseModel = ResponseModel(false, response.statusText!);

    }
    _isLoading=false;
    update();
    return responseModel;


  }

      void saveUserNumberAndPassword(String number, String password) async {
        authRepo.saveUserNumberAndPassword(number, password);

    }
}