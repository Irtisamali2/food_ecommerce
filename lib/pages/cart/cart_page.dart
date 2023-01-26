import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/base/no_data_page.dart';
import 'package:food_ecommerce/controller/popular_product_controller.dart';
import 'package:food_ecommerce/controller/recommended_product_controller.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_icon.dart';
import 'package:food_ecommerce/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //header
        Positioned(
          top: Dimensions.height10 * 5,
          right: Dimensions.width20 * 2,
          left: Dimensions.width20 * 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  sizeforicon: Dimensions.iconSize24,
                ),
              ),
              SizedBox(
                width: Dimensions.width20 * 5,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(RouteHelper.GetInitial()),
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  sizeforicon: Dimensions.iconSize24,
                ),
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                sizeforicon: Dimensions.iconSize24,
              )
            ],
          ),
        ),
       //body
       GetBuilder<CartController>(builder: (_cartController){
        return _cartController.getItems.length>0? Positioned(
          top: Dimensions.height20 * 5,
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: 0,
          child: Container(
            // margin: EdgeInsets.only(top: Dimensions.height15),
            //  color: Colors.red,
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartcontroller) {
                    var _cartlist= cartcontroller.getItems;
                    return ListView.builder(
                        //padding: EdgeInsets.zero,
                        itemCount: _cartlist.length,
                        itemBuilder: (_, index) {
                          return Container(
                              height: 100,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex= Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(_cartlist[index].product!);

                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }
                                      else{
                                        var recommendedIndex= Get.find<RecommendedProductController>()
                                      .recommendedProductList
                                      .indexOf(_cartlist[index].product!);
                                      if(recommendedIndex<0){
                                         Get.snackbar("History Product", "Product is not availble for history product",
                                         backgroundColor: AppColors.mainColor,
                                         colorText: Colors.white);  
                                      }
                                      else{
                                     Get.toNamed(RouteHelper.getRecommendedrFood(recommendedIndex,"cartpage"));

                                      }
                                      }
                                      
                                      
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      width: Dimensions.height20 * 5,
                                      height: Dimensions.height20 * 5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.Upload_URL +
                                                    cartcontroller
                                                        .getItems[index].img!,
                                              )),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartcontroller
                                                .getItems[index].name!,
                                            color: Colors.black,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    "\$ ${cartcontroller.getItems[index].price!}",
                                                color: Colors.red,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),
                                                child: Row(children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        //  productcontroller.setQuantity(false);
                                                          cartcontroller.addItem(_cartlist[index].product!, -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      )),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  BigText(
                                                      text: cartcontroller
                                                          .getItems[index]
                                                          .quantity!
                                                          .toString()),
                                                  // BigText(text: productcontroller.inCartItem.toString()),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                      onTap: (() {
                                                        // productcontroller.setQuantity(true);
                                                         cartcontroller.addItem(_cartlist[index].product!, 1);

                                                      }),
                                                      child: Icon(Icons.add,
                                                          color: AppColors
                                                              .signColor))
                                                ]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        });
                  },
                )),
          ),
        )
      : NoDataPage(text: "Your cart is empty");
       })
       ]),
   
    bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartcontroller) {
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
              cartcontroller.getItems.length>0?Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                BigText(text: "\$"+cartcontroller.totalAmount.toString() ),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
              
              ]),
            ),
            GestureDetector(
              onTap: () {
               // productcontroller.addItem(product);
               
               print("tapped");
               cartcontroller.addToHistory();
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: "Check out",
                  color: Colors.white,
                  size: Dimensions.font20 - 2,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
              ),
            )
          ]) : Container()
        );
      }),
   
    );
  }
}
