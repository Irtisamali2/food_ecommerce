import 'package:flutter/material.dart';
import 'package:food_ecommerce/controller/cart_controller.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;


  PopularProductController({required this.popularProductRepo}); 

  List<ProductModel> _popularProductList=[];
  bool _isLoading = false;
  bool get isLoaded=> _isLoading;
  int _quantity =0;
  int get quantity=> _quantity;
  int _inCartItem=0;
  int get inCartItem=> _inCartItem+_quantity;
  late CartController _cart;


  //to access in the ui
List<ProductModel> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    
    //200 is successful
    if(response.statusCode==200){
      print("Got Products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoading=true;
      //print(_popularProductList);
      
      update();// more like setstate(){}
    }else{
      
    }
  }

void setQuantity(bool isIncrement) {
  if(isIncrement){
    _quantity=quantityCheck(_quantity+1);
    print("increment ${_quantity}");
  }else{
    _quantity=quantityCheck(_quantity-1);
  }


update();
}

  int quantityCheck(int quantity){
    if(_inCartItem+ quantity<0){
      Get.snackbar("Item Count", "You Can't Reduce More",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
    if(_inCartItem>0){
      _quantity=-_inCartItem;
      return _quantity;
    }
        return 0;
    }
    else if(_inCartItem+ quantity>20){
       Get.snackbar("Item Count", "You Can't Add More",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);

        return 20;
    }
    else{
      
      return quantity;
    }
    
    
  }

  void initProduct(CartController cart , ProductModel product){
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
    print("check to see exist or not :" + exist.toString());
    if(exist){
      _inCartItem=_cart.getQuantity(product);
    }
    //if exists 
    //get frim storage _inCartItems


  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItem=_cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("the id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
    });

    update();

  }
    int get totalItems =>_cart.totalItems;
    List<CartModel> get getItems{
      return _cart.getItems;
    }
}