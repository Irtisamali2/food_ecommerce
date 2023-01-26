import 'package:flutter/material.dart';
import 'package:food_ecommerce/controller/cart_controller.dart';
import 'package:food_ecommerce/pages/cart/cart_page.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/app_column.dart';
import 'package:food_ecommerce/widgets/app_icon.dart';
import 'package:food_ecommerce/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/Big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final  int pageId;
  final  String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var productcontroller=Get.find<PopularProductController>();
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    print("page id is: " + product.toString());
    print("product name is: " + product.name.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularfooddetailimg,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.Upload_URL +
                          product.img!))),
            ),
          ),
          // top bar icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                     // Navigator.pop(context);
                     if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                     }
                     else{
                      Get.toNamed(RouteHelper.GetInitial());
                     }
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      //Get.to(()=>CartPage());
                      //if (controller.totalItems > 0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      //}
                    },
                    child: Stack(
                      children: [
                       const  AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  iconSize: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        controller.totalItems >= 1
                            ? Positioned(
                                top: 4,
                                right: 4,
                                child: BigText(
                                  text: controller.totalItems.toString(),
                                  size: 12,
                                ))
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          // introduction
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularfooddetailimg - 20,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                      text: product.description!,
                    )))
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (productcontroller) {
        return Container(
          height: Dimensions.bottomheightbar100,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2)),
              color: AppColors.buttonBackground),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(children: [
                GestureDetector(
                    onTap: () {
                      productcontroller.setQuantity(false);
                    },
                    child: Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    )),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                BigText(text: productcontroller.inCartItem.toString()),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                GestureDetector(
                    onTap: (() {
                      productcontroller.setQuantity(true);
                    }),
                    child: Icon(Icons.add, color: AppColors.signColor))
              ]),
            ),
            GestureDetector(
              onTap: () {
                productcontroller.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: BigText(
                  text: "\$ ${product.price!} | Add to cart",
                  color: Colors.white,
                  size: Dimensions.font20 - 2,
                ),
              ),
            )
          ]),
        );
      }),
    );
  }
}
