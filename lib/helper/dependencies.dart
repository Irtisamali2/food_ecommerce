import 'package:food_ecommerce/controller/auth_controller.dart';
import 'package:food_ecommerce/controller/cart_controller.dart';
import 'package:food_ecommerce/controller/popular_product_controller.dart';
import 'package:food_ecommerce/data/api/apiClient.dart';
import 'package:food_ecommerce/data/repository/auth_repo.dart';
import 'package:food_ecommerce/data/repository/cart_repo.dart';
import 'package:food_ecommerce/data/repository/popular_product_repo.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
  final sharedPreference =  await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreference);

  //ApiClient
 Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

 //Repository
 Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => AuthRepo(sharedPreferences:Get.find(), apiClinet: Get.find()));



 //Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));




}