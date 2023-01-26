import 'package:flutter/material.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height20*5, 
      width: Dimensions.height20*5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.height20*5),
        color: AppColors.mainColor
      ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.white,),
    );
  }
}