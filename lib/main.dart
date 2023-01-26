import 'package:flutter/material.dart';
import 'package:food_ecommerce/controller/cart_controller.dart';
import 'package:food_ecommerce/controller/popular_product_controller.dart';
import 'package:food_ecommerce/controller/recommended_product_controller.dart';
import 'package:food_ecommerce/pages/auth/sign_in_page.dart';
import 'package:food_ecommerce/pages/auth/sign_up_page.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //make sure correctly intialize
  await dep.init(); // wait until load it
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
        //Get.find<CartController>;

    Get.find<CartController>().getCartData();
    Duration(seconds: 5);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:  SignInPage(),

      initialRoute: RouteHelper.getSplashPage() ,
      getPages: RouteHelper.routes,
    );
  }
}
