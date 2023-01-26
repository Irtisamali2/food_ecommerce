import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo}); 

  List<dynamic> _recommendedProductList=[];
   bool _isLoading = false;
  bool get isLoaded=> _isLoading;

  //to access in the ui
List<dynamic> get recommendedProductList => _recommendedProductList;
  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    
    //200 is successful
    if(response.statusCode==200){
      print("Got Products");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoading=true;
      //print(_popularProductList);
      
      update();// more like setstate(){}
    }else{
      
    }
  }
}