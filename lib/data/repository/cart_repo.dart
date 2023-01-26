import 'dart:convert';

import 'package:food_ecommerce/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
//sharedPreferences store data in String format
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  // when send data to server or storage you need to convert object to map or string
  void addToCartList(List<CartModel> cartList) {
    //for removing from memory
    //  sharedPreferences.remove(AppConstants.CART_LIST);
    //  sharedPreferences.remove(AppConstants.CART_History_List);
    //  sharedPreferences.remove(AppConstants.CART_LIST);

    
    var time = DateTime.now().toString();
    cart = [];

    // Convert objects to string because shared preferences only accept strings
    // from object to string or map
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    cartList.forEach((element) { 
      print("time before checkout id:" + element.id.toString() + "time :" +element.time.toString());

    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print("add to card items been added :" +
    //     sharedPreferences.getStringList(AppConstants.CART_LIST).toString());
  }

  // when get data from server or storage you need to convert map or String to object

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    List<CartModel> cartList = [];

    carts.forEach((element) {
      //from String/map to Object
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.CART_History_List)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_History_List)!;
    }
    List<CartModel> cartListHistory = [];

    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
      
    });
    return cartListHistory;
  }

  void addtoCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.CART_History_List)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_History_List)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("History list: " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_History_List, cartHistory);
    //getCartHistory();
    print("length of cart history : " + getCartHistory().length.toString());
    // getCartHistory().forEach((element) {
    //   print("the time for order is " +element.time.toString());
    //  });

     for(int j = 0; j < getCartHistory().length; j++ ){
      print("the time for order is : "+getCartHistory()[j].time.toString() + " id is "+getCartHistory()[j].id.toString());
     }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
