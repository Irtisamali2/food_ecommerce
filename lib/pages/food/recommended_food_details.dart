import 'package:flutter/material.dart';
import 'package:food_ecommerce/controller/popular_product_controller.dart';
import 'package:food_ecommerce/controller/recommended_product_controller.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_icon.dart';
import 'package:food_ecommerce/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../../controller/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  RecommendedFoodDetails({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: AppIcon(
                    icon: Icons.remove,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    sizeforicon: Dimensions.iconSize24,
                  ),
                ),
                BigText(
                  text: "\$ ${product.price!} " +
                      " X " +
                      " ${controller.inCartItem} ",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    sizeforicon: Dimensions.iconSize24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomheightbar100 + 20,
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSize24 + 4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height15,
                          bottom: Dimensions.height15,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: BigText (
                        text: "\$10 | Add to cart",
                        color: Colors.white,
                        size: Dimensions.font20 - 2,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ]),
          ),
        ]);
      }),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {

                       if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                     }
                     else{
                      Get.toNamed(RouteHelper.GetInitial());
                     }
                    },// Navigator.pop(context),
                    child: AppIcon(icon: Icons.clear)),
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
                        AppIcon(icon: Icons.shopping_cart_checkout_outlined),
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
            //primary: true,
            backgroundColor: AppColors.yellowColor,
            pinned: true,
            // floating: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                )),
              ),
            ),
            //pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.Upload_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandableTextWidget(text: product.description)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
