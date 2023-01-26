import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;

  SmallText({Key? key,  this.color=const Color(0xFFccc7c5), required this.text,this.size=12,this.height=1.2,this.overflow=TextOverflow.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
    
        text,
       // maxLines: 1,
       overflow: overflow,
        style: TextStyle(color: color,
        height: height,
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400),
    );
  }
}