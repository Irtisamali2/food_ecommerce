import 'package:food_ecommerce/pages/cart/cart_page.dart';
import 'package:food_ecommerce/pages/food/popular_food_detail.dart';
import 'package:food_ecommerce/pages/food/recommended_food_details.dart';
import 'package:food_ecommerce/pages/home/main_food_page.dart';
import 'package:food_ecommerce/splash/spash_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage="/cart-Page";
  static const String splashPAge="/splash-Page";
  static const String mainFoodPage= "/main-foodpage";


  static String GetInitial() => '$initial';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedrFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage()=> '$splashPAge';
  static String getMainFoodPage()=> '$mainFoodPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: mainFoodPage, page: () => MainFoodPage()),

    
    GetPage(
        name: popularFood,
        transition: Transition.fadeIn,
        page: () {
          var pageId=Get.parameters['pageId'];
          var page=Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        } ),

    GetPage(
        name: recommendedFood,
        transition: Transition.fadeIn,
        page: (){  
          var pageId=Get.parameters['pageId'];
          var page=Get.parameters['page'];

          return RecommendedFoodDetails(pageId: int.parse(pageId!),page:page!);}),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn
    ),
    
    GetPage(name: splashPAge, page: (){
      return SplashScreen();
    },
    transition: Transition.fadeIn
    )
  ];
}
