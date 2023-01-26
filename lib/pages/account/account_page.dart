import 'package:flutter/material.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/account_widget.dart';
import 'package:food_ecommerce/widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText(text: "Profile",size: 24,color: Colors.white,)),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          
          children: [
          //profile icon
          AppIcon(icon: Icons.person ,backgroundColor: AppColors.mainColor,
          iconColor: Colors.white,
          iconSize: Dimensions.height45*3,
          sizeforicon: Dimensions.height30*2,
          ),
          SizedBox(height: Dimensions.height20,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                            //name
              AccountWidget(appIcon:  AppIcon(icon: Icons.person ,backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height10*4,
              sizeforicon: Dimensions.height10*2,
              ), bigText: BigText(text: "Irtisam Ali",)),
              SizedBox(height: Dimensions.height20,),
              //phone
                AccountWidget(appIcon:  AppIcon(icon: Icons.phone ,backgroundColor: AppColors.yellowColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height10*4,
              sizeforicon: Dimensions.height10*2,
              ), bigText: BigText(text: "+92 310 4779075",)),
              SizedBox(height: Dimensions.height20,),
              //email
                AccountWidget(appIcon:  AppIcon(icon: Icons.email ,backgroundColor: AppColors.yellowColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height10*4,
              sizeforicon: Dimensions.height10*2,
              ), bigText: BigText(text: "irtisam.ali@gmail.com",)),
              SizedBox(height: Dimensions.height20,),
              //address
                AccountWidget(appIcon:  AppIcon(icon: Icons.location_on ,backgroundColor: AppColors.yellowColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height10*4,
              sizeforicon: Dimensions.height10*2,
              ), bigText: BigText(text: "Chiniot - Pakistan",)),
              SizedBox(height: Dimensions.height20,),
                //message
                AccountWidget(appIcon:  AppIcon(icon: Icons.message ,backgroundColor: Colors.red,
              iconColor: Colors.white,
              iconSize: Dimensions.height10*4,
              sizeforicon: Dimensions.height10*2,
              ), bigText: BigText(text: "No Explanations",)),
              SizedBox(height: Dimensions.height20,),
                ],
              ),
            ),
          )
       
        ]),
      ),
    );
  }
}