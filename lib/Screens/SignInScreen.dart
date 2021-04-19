import 'package:TutorialApp/Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TutorialApp/Constants/constant_widgets.dart';
import 'package:TutorialApp/Constants/constants.dart';
import 'package:TutorialApp/Helpers/app_preference.dart';
import 'package:sizer/sizer.dart';

import 'SelectCategory.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController fNameController;
  TextEditingController lNameController;

  var isPassHide = true.obs;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.all(2.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [

              //   ],
              // ),
              SizedBox(height: 6.0.h),
              Center(
                child: Container(
                  height: 25.0.h,
                  width: 25.0.h,
                  child: Image.asset('assets/icons/education.png'),
                ),
              ),
              SizedBox(height: 8.0.h),
              text("Welcome Back!",
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0),
              SizedBox(height: 3.0.h),

              textFieldHeading(heading: 'Email'),
              customTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  icon: Icons.mail),
              SizedBox(height: 2.0.h),
              textFieldHeading(heading: 'Password'),
              Obx(
                () => customTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    // isSuffix: true,
                    obscureText: isPassHide.value,
                    icon: Icons.lock),
              ),
              SizedBox(height: 6.0.h),
              Center(
                child: Column(
                  children: [
                    customButton(
                        callBack: _btnSignUpClick,
                        height: 6.0.h,
                        width: 80.0.w,
                        borderRadius: 8,
                        btnText: "SIGN IN"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        text("New User?",
                            fontSize: 10.0, fontWeight: FontWeight.w500),
                        GestureDetector(
                          onTap: () =>
                              Get.off(SignUpScreen(), transition: transition),
                          child: text(" Sign up",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor),
                        ),
                        Spacer()
                      ],
                    )
                  ],
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  TextField customTextField(
      {TextEditingController controller,
      String hintText,
      bool isSuffix = false,
      IconData icon,
      bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: customTextStyleTextField(),
      decoration: passInputDecoration(
        callBack: () {
          isPassHide.value = !isPassHide.value;
        },
        hintText: hintText,
        isSuffix: isSuffix,
        prefixImage: icon,
        // suffixImage: isPassHide.value ? 'eye_open' : 'eye_close'
      ),

      // decoration: inputDecoration(
      //     hintText: hintText, prefixImage: 'assets/icons/$icon.png'),
    );
  }

  Text textFieldHeading({String heading}) {
    return text(heading,
        color: textHeadingColor, fontSize: 11.0, fontWeight: FontWeight.w600);
  }

  _validateField() {
    if (emailController.text.isEmpty) {
      errorSnackBar(content: "Please enter email address.");
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      errorSnackBar(content: "Please enter valid email address.");
    } else if (passwordController.text.isEmpty) {
      errorSnackBar(content: "Please enter password.");
    } else if (passwordController.text.length < 6) {
      errorSnackBar(content: "Password should have minimum 6 characters.");
    } else if (passwordController.text.length > 16) {
      errorSnackBar(content: "Password should have maximum 16 characters.");
    } else if (fNameController.text.isEmpty) {
      errorSnackBar(content: "Please enter first name.");
    } else if (fNameController.text.length < 3) {
      errorSnackBar(content: "First name should have minimum 3 characters.");
    } else if (fNameController.text.length > 15) {
      errorSnackBar(content: "First name should have maximum 15 characters.");
    } else if (lNameController.text.isEmpty) {
      errorSnackBar(content: "Please enter last name.");
    } else if (lNameController.text.length < 3) {
      errorSnackBar(content: "Last name should have minimum 3 characters.");
    } else if (lNameController.text.length > 15) {
      errorSnackBar(content: "Last name should have maximum 15 characters.");
    } else {
      return true;
    }
  }

  _btnSignUpClick() async {
    FocusScope.of(context).unfocus();
    // if (_validateField()) {
    //   LoginViewModel objLoginViewModel = LoginViewModel();
    //   var resp = await objLoginViewModel.loginApiCall({
    //     "email": emailController.text.trim(),
    //     "f_name": fNameController.text.trim(),
    //     "l_name": lNameController.text.trim(),
    //     "password": passwordController.text,
    //     "islogin": "false"
    //   });
    //   GetStorage().write(AppPreferencesHelper.pUser, resp.toJson());

    //   if (resp != null) {
    Get.offAll(SelectCategory(), transition: transition);
    //     print(GetStorage().read(AppPreferencesHelper.pUser));
    //   }
    //   print(emailController.text + passwordController.text);
    // }
  }
}
