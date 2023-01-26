import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/base/customer_loader.dart';
import 'package:food_ecommerce/base/show_custom_snackbar.dart';
import 'package:food_ecommerce/controller/auth_controller.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:food_ecommerce/utils/dimensions.dart';
import 'package:food_ecommerce/widgets/Big_text.dart';
import 'package:food_ecommerce/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/signup_body_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =  TextEditingController();
    var passwordController =  TextEditingController();
    var nameController =  TextEditingController();
    var phoneController =  TextEditingController();

    var signUpImages =[
      "t.png",
      "f.png",
      "g.png"
    ];
        void _registration(AuthController authController){
      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String email= emailController.text.trim();
      String password= passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone",title: "Phone Number");
      }else if(email.isEmpty){
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
        SignUpBody signUpBody= SignUpBody(name: name, 
        email: email, 
        phone: phone, 
        password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            showCustomSnackBar("Success registration",title: "Login with same credentials",color: Colors.green);
          }
          else{
        showCustomSnackBar(status.message);

          }
        });
      }
     
    }

    return  Scaffold(
      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (_authcontroller){
        return !_authcontroller.isLoading ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top:  Dimensions.screenHeight*0.05 ),
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: Dimensions.screenHeight*0.25,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: 
                AssetImage("assets/image/logo part 1.png"),),
              ),
              
      
              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController, hintText: "Password", icon: Icons.key,isObsecure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: nameController, hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
      
              AppTextField(textController: phoneController, hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
                onTap: (){
                _registration(_authcontroller);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Dimensions.screenwidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(borderRadius: 
                  BorderRadius.circular(Dimensions.height20),
                  color: AppColors.mainColor
                  ),
                  child: BigText(text: "Sign up",color: Colors.white,
                  
                  size: Dimensions.font20+Dimensions.font20/2,),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20
                  )
                ),
              ),
              //signup options
              SizedBox(height: Dimensions.screenHeight *0.05,),
               RichText(
                text: TextSpan(
                  text: "Sign up using the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20/1.3
                  )
                ),
              ),
      
              Wrap(
                children:List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius20,
                    backgroundImage: AssetImage("assets/image/"+signUpImages[index]),
                  ),
                )),
              )
            ],
          ),
        ),
      )
    : Center(child: CustomLoader());
      },)
      );


  }
}