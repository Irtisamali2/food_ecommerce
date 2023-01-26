import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_ecommerce/base/no_data_page.dart';
import 'package:food_ecommerce/controller/cart_controller.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_icon.dart';
import 'package:food_ecommerce/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    // var cartitem= Get.find<CartController>().getCartHistoryList();
    //added for descending order
    //  var CartHistoryList = cartitem.reversed;
    Map<String, int> cartItemsPerOrder = Map();
    // List<CartModel> getCartHistoryList=[];
    // CartHistoryList.forEach((element) {
    //   getCartHistoryList.add(element);
    // });
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartitemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartitemsPerOrderToList();

    var listCounter = 0;

   
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
         DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss")
         .parse(getCartHistoryList[listCounter].time!);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
       outputDate = outputFormat.format(inputDate);
      }
    
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.bottomheightbar100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: AppColors.mainColor,
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        //listview render just 1 time while listview.builder render dynamically
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                Container(
                                  height: Dimensions.bottomheightbar100 + 20,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                 
                                      timeWidget(listCounter),
                                      //  ((){
                                      // DateTime parseDate=  DateFormat("yyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                                      // var inputDate = DateTime.parse(parseDate.toString());
                                      // var outputFormat =  DateFormat("MM/dd/yyyy hh:mm a");
                                      // var outputDate = outputFormat.format(inputDate);
                                      //     return BigText(text:outputDate);
                                      //  }()) ,
                                      // BigText(text: getCartHistoryList[listCounter].time!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .width10 /
                                                                2),
                                                        height: Dimensions
                                                                .height40 *
                                                            2,
                                                        width: Dimensions
                                                                .height40 *
                                                            2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .radius15 /
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstants
                                                                        .BASE_URL +
                                                                    AppConstants
                                                                        .Upload_URL +
                                                                    getCartHistoryList[
                                                                            listCounter -
                                                                                1]
                                                                        .img!))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            height:
                                                Dimensions.bottomheightbar100 -
                                                    20,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      " Items",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    // List<CartModel> moreOrder=[];
                                                    Map<int, CartModel>
                                                        moreOrder = Map();
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      // print(" cart list is"+ getCartHistoryList[j].id.toString());
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        // moreOrder.add(getCartHistoryList[j]);
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                        //print("My Order time is "+orderTime[i]);
                                                      }
                                                    }
                                                    // moreOrder.forEach((element) {
                                                    //   moreOrder2.putIfAbsent(element.id!, () => element);
                                                    // });
                                                    Get.find<CartController>()
                                                            .setITemsforCartHistory =
                                                        moreOrder;
                                                    Get.find<CartController>()
                                                        .addtoCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                    //print("Doing test: "+getCartHistoryList[i].time.toString());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                3),
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 1)),
                                                    child: SmallText(
                                                      text: "One More",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: NoDataPage(
                      text: "You didn't buy anything so far !",
                      imgPath: "assets/image/empty_box.png",
                    ));
          })
        ],
      ),
    );
  }
}
