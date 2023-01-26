import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:get/get.dart';
import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController animationController;
 
  // _loadResources() async {
  //  await Get.find<PopularProductController>().getPopularProductList();
  //  await Get.find<RecommendedProductController>().getRecommendedProductList();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadResources();
    animationController =  AnimationController(
      vsync: this, duration: const Duration(seconds: 2))..forward();
//animationController= animationController.forward();
    animation =   CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(
     const Duration(seconds: 4),
      () => Get.offNamed(RouteHelper.initial)
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(child: Image.asset("assets/image/logo part 1.png",width: Dimensions.spashImage,))),
          Center(child: Image.asset("assets/image/logo part 2.png",width: Dimensions.spashImage,))

        ],
      ),
    );
  }
  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}