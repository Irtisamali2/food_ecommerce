import 'package:flutter/material.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;  
  ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firsthalf;
  late String seconfHalf;

  bool hiddenTest = true;

  double textHeight= Dimensions.screenHeight/4.0;
  @override
  void initState(){
    super.initState();
      print("current text height"+textHeight.toString());

    if(widget.text.length>textHeight){
      firsthalf=widget.text.substring(0,textHeight.toInt());
      seconfHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firsthalf=widget.text;
      seconfHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {

    return Container(

      child: seconfHalf.isEmpty?SmallText(text: firsthalf,size: Dimensions.font20-4,color: AppColors.paraColor,): 
      Column(
        
        children: [
          SmallText(text: hiddenTest?("$firsthalf..."):(firsthalf+seconfHalf),size: Dimensions.font20-4,color: AppColors.paraColor,),
          InkWell(
            onTap: () {
              setState(() {
                hiddenTest=!hiddenTest;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Show more",color: AppColors.mainColor,),
                Icon(hiddenTest? Icons.arrow_drop_down : Icons.arrow_drop_up,color: AppColors.mainColor),

              ],
            ),
          )

      ],),
    );
  }
}