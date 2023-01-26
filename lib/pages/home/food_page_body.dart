import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/controller/popular_product_controller.dart';
import 'package:food_ecommerce/controller/recommended_product_controller.dart';
import 'package:food_ecommerce/models/products_model.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_column.dart';
import 'package:food_ecommerce/widgets/icon_and_text_widget.dart';
import 'package:food_ecommerce/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _currentheight = Dimensions.pageViewController;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        print("Current Page value" + _currentPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (popularProduct) {
      return 
      popularProduct.popularProductList.length <= 0
          ?
           Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(bottom: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, //,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.black12,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                //slider section
                GetBuilder<PopularProductController>(
                  builder: (popularProducts) {
                    return Container(
                      height: Dimensions.pageView,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: ((context, index) {
                          return _buildPageItem(
                              index, popularProducts.popularProductList[index]);
                        }),
                      ),
                    );
                  },
                ),
                //dot indicator section
                GetBuilder<PopularProductController>(builder: (popularProduct) {
                  return DotsIndicator(
                    dotsCount: popularProduct.popularProductList.isEmpty
                        ? 1
                        : popularProduct.popularProductList.length,
                    position: _currentPageValue,
                    decorator: DotsDecorator(
                      activeColor: AppColors.mainColor,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  );
                }),

                //Popular Text
                SizedBox(
                  height: Dimensions.height30,
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width30),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(text: "Recommended"),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        BigText(
                          text: ".",
                          color: Colors.black26,
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "Food Pairing"),
                      ]),
                ),
                GetBuilder<RecommendedProductController>(
                    builder: (recommendedProduct) {
                  return recommendedProduct.isLoaded
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              recommendedProduct.recommendedProductList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                               onTap: (){
                          Get.toNamed(RouteHelper.getRecommendedrFood(index,"home"));
                               },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    bottom: Dimensions.height10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Dimensions.listViewImgSize120,
                                      height: Dimensions.listViewImgSize120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white38,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.Upload_URL +
                                                      recommendedProduct
                                                          .recommendedProductList[
                                                              index]
                                                          .img!),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomRight: Radius.circular(
                                                    Dimensions.radius20)),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.width10,
                                              right: Dimensions.width10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BigText(
                                                  text: recommendedProduct
                                                      .recommendedProductList[
                                                          index]
                                                      .name!),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              SmallText(
                                                  text:
                                                      recommendedProduct.recommendedProductList[index].description!,overflow: TextOverflow.ellipsis,),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconAndTextEdget(
                                                      icon: Icons.circle_sharp,
                                                      text: "Normal",
                                                      iconColor:
                                                          AppColors.iconColor1),
                                                  IconAndTextEdget(
                                                      icon: Icons.location_on,
                                                      text: "1.7km",
                                                      iconColor:
                                                          AppColors.mainColor),
                                                  IconAndTextEdget(
                                                      icon: Icons
                                                          .access_time_rounded,
                                                      text: "32min",
                                                      iconColor:
                                                          AppColors.iconColor2)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor),
                        );
                }),
              ],
            );
    });
  }

  Widget _buildPageItem(int index, ProductModel popularProductList) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _currentheight * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _currentheight * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _currentheight * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _currentheight * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          //image section
          GestureDetector(
             onTap: (){
                          Get.toNamed(RouteHelper.getPopularFood(index,"home"));
                        },
            child: Container(
              height: Dimensions.pageViewController,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.Upload_URL +
                          popularProductList.img!))),
            ),
          ),
          //text section

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextController,
              margin: EdgeInsets.only(
                  left: Dimensions.width40,
                  right: Dimensions.width40,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15, left: 15, right: 15),
                  child: AppColumn(text: popularProductList.name!)),
            ),
          ),
        ],
      ),
    );
  }
}
