import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/base/customer_loader.dart';
import 'package:food_ecommerce/pages/auth/sign_up_page.dart';
import 'package:food_ecommerce/routes/route_helper.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =  TextEditingController();
    var passwordController =  TextEditingController();
      void login(AuthController authController){
      String email= emailController.text.trim();
      String password= passwordController.text.trim();

   if(email.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email address");
      }
      else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than sex characters",title: "Password");
      }
      else{
       // showCustomSnackBar("All went well",title: "Perfect",color: Colors.green);
  
        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getCartPage());
          }
          else{
        showCustomSnackBar(status.message);

          }
        });
      }
     
    }



    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: ((signincontroller) {
        return !signincontroller.isLoading? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top:  Dimensions.screenHeight*0.05 ),
          width: double.maxFinite,
          child: Column(
            children: [
              //app logo
              SizedBox(
                height: Dimensions.screenHeight*0.25,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: 
                AssetImage("assets/image/logo part 1.png"),),
              ),
              // welcome
              Container(
                //width: double.maxFinite,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",
                    style: TextStyle(fontSize: Dimensions.font20*3
                    +Dimensions.font20/2,
                    fontWeight: FontWeight.bold),),
                    Text("Sign into your account",
                    style: TextStyle(fontSize: Dimensions.font20,
                    color: Colors.grey[500]
                    
                    ),),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              // email
              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height10,),
              //password
              AppTextField(textController: passwordController, hintText: "Password", icon: Icons.key,isObsecure: true,),
              SizedBox(height: Dimensions.height20,),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    
                    text: TextSpan(
                     // recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                      )
                    ),
                  ),
                SizedBox(width: Dimensions.height20,)
                ],
              ),
             SizedBox(height: Dimensions.screenHeight *0.07,),

              GestureDetector(
                onTap: (){
                  login(signincontroller);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Dimensions.screenwidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(borderRadius: 
                  BorderRadius.circular(Dimensions.height20),
                  color: AppColors.mainColor
                  ),
                  child: BigText(text: "Sign in",color: Colors.white,
                  
                  size: Dimensions.font20+Dimensions.font20/2,),
                ),
              ),
             // SizedBox(height: Dimensions.height10,),
             
              //signup options
              SizedBox(height: Dimensions.screenHeight *0.05,),
               RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20/1.3
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                  text: "Create",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Dimensions.font20/1.3
                  ),
                    )
                  ]
                ),
              ),
      
          
            ],
          ),
        ),
      ) : Center(child: CustomLoader(),);
   
      }),) );
  }
}