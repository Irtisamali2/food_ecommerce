import 'package:flutter/material.dart';
import 'package:food_ecommerce/utils/dimensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({Key? key,  this.color=Colors.black, required this.text,this.size=0,this.overflow=TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      
        text,overflow:overflow,
        style: TextStyle(color: color,
        fontSize:size==0? Dimensions.font20:size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400),
    );
  }
}