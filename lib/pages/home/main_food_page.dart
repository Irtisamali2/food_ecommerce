import 'package:flutter/material.dart';
import 'package:food_ecommerce/pages/home/food_page_body.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    print("current height is" + MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(onRefresh:_loadResources ,child:  Column(
      children:  [
        //Showing the Header
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height40, bottom: Dimensions.height10),
          padding: EdgeInsets.only(
              right: Dimensions.width20, left: Dimensions.width20),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(
                    text: "Pakistan",
                    color: AppColors.mainColor,
                  ),
                  Row(
                    children: [
                      SmallText(
                        text: "Pakistan",
                        color: Colors.black54,
                      ),
                      const Icon(Icons.arrow_drop_down_rounded)
                    ],
                  )
                ],
              ),
              Container(
                width: Dimensions.height45,
                height: Dimensions.height45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimensions.iconSize24,
                ),
              )
            ],
          )),
        ),
        //Showing the Body
        const Expanded(child: SingleChildScrollView(child: FoodPageBody())),
      ],
    ),);
  }
}
