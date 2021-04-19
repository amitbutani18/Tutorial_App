import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// Text Widget
Text text(String text,
    {Color color = colorBlack,
    FontWeight fontWeight = FontWeight.normal,
    // String fontFamily = 'OpenSans',
    double fontSize = 16.0,
    double letterSpacing = 0.0,
    TextAlign textAlign = TextAlign.center,
    TextDecoration decoration = TextDecoration.none}) {
  return Text(
    text,
    textAlign: textAlign,
    style: GoogleFonts.roboto(
        textStyle: TextStyle(
      decoration: decoration,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize.sp,
      letterSpacing: letterSpacing,
    )),
  );
}

// Error SnackBar
errorSnackBar({@required String content, Color textColor = colorWhite}) {
  return Get.snackbar('Error', content,
      backgroundColor: Colors.red.withOpacity(0.7), colorText: textColor);
}

// Success SnackBar
successSnackBar({@required String content, Color textColor = colorBlack}) {
  return Get.snackbar('Success', content,
      backgroundColor: Colors.green[100].withOpacity(0.8),
      colorText: textColor);
}

// Button
GestureDetector customButton(
    {@required Function callBack,
    @required double height,
    @required double width,
    @required String btnText,
    double borderRadius = 100.0,
    FontWeight fontWeight = FontWeight.w700,
    Color color = primaryColor,
    Color textColor = colorWhite,
    double textSize = 12.0}) {
  return GestureDetector(
    onTap: callBack,
    child: Container(
      height: height,
      width: width,
      decoration: new BoxDecoration(
        border: Border.all(color: textColor == colorWhite ? color : textColor),
        borderRadius: BorderRadius.circular(borderRadius),
        // boxShadow: [
        //   BoxShadow(
        //       color: shadowColor,
        //       offset: Offset(0, 1),
        //       blurRadius: 10,
        //       spreadRadius: 4),
        // ],
        gradient: new LinearGradient(
            colors: [
              color,
              color,
            ],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: text(btnText,
            fontSize: textSize,
            letterSpacing: 1.0,
            fontWeight: fontWeight,
            color: textColor),
      ),
    ),
  );
}

InputDecoration passInputDecoration(
    {String hintText,
    IconData prefixImage,
    String suffixImage,
    Function callBack,
    bool isSuffix = false,
    Color underLineColor = underLineColor}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 12.0.sp, color: textPrimaryColor),
    isDense: true,
    prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
    // suffixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
    // suffixIcon: isSuffix
    //     ? GestureDetector(
    //         onTap: callBack,
    //         child: Padding(
    //           padding: const EdgeInsets.only(right: 10),
    //           child: Image.asset(
    //             // isPassHide.value
    //             //     ? 'assets/icons/eye_open.png'
    //             // : '
    //             'assets/icons/$suffixImage.png',
    //           ),
    //         ),
    //       )
    //     : text(''),
    prefixIcon: Icon(prefixImage, color: textPrimaryColor),
    prefixStyle: TextStyle(color: textPrimaryColor),
    // Padding(
    //   padding: const EdgeInsets.only(right: 10),
    //   child: Image.asset(
    //     'assets/icons/$prefixImage.png',
    //   ),
    // ),
    // contentPadding: EdgeInsets.only(top: 8, bottom: 8, right: 80),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
  );
}

// Input Decoration
InputDecoration inputDecoration(
    {String hintText,
    String prefixImage,
    Function callBack,
    bool suffix = false,
    Color underLineColor = underLineColor}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 10.0.sp, color: textPrimaryColor),
    isDense: true,
    prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
    suffixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
    suffixIcon: suffix
        ? GestureDetector(
            onTap: callBack,
            child: text('Change',
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF881B),
                decoration: TextDecoration.underline),
          )
        : text(''),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Image.asset(
        prefixImage,
      ),
    ),
    contentPadding: EdgeInsets.only(top: 8, bottom: 8, right: 0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: underLineColor),
    ),
  );
}

// TextStyle For TextField
TextStyle customTextStyleTextField({Color textColor = textHeadingColor}) {
  return TextStyle(
      color: textColor, fontWeight: FontWeight.w400, fontSize: 12.0.sp);
}

// My Shadow
BoxShadow customBoxShadow() {
  return BoxShadow(
      color: Colors.grey[200],
      offset: Offset(0, 1),
      blurRadius: 5,
      spreadRadius: 2);
}

// Container Decoration
BoxDecoration customBoxDecoration({
  Color color = Colors.white,
  double borderRadius = 10.0,
  bool isBoxShadow = true,
  bool isBorderEnable = false,
  bool isimageBg = false,
  String bgImage,
  bool bottomLeftCircularBorder = true,
  bool bottomRightCircularBorder = true,
  bool topLeftCircularBorder = true,
  bool topRightCircularBorder = true,
}) {
  return BoxDecoration(
    color: color,
    boxShadow: isBoxShadow ? [customBoxShadow()] : [],
    image: isimageBg
        ? DecorationImage(
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //     Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: NetworkImage(
              bgImage,
            ),
          )
        : null,
    border: isBorderEnable
        ? Border.all(color: Color(0xffECF0F4), width: 1)
        : Border.fromBorderSide(BorderSide.none),
    borderRadius: BorderRadius.only(
        bottomLeft:
            Radius.circular(bottomLeftCircularBorder ? borderRadius : 0.0),
        bottomRight:
            Radius.circular(bottomRightCircularBorder ? borderRadius : 0.0),
        topLeft: Radius.circular(topLeftCircularBorder ? borderRadius : 0.0),
        topRight: Radius.circular(topRightCircularBorder ? borderRadius : 0.0)),
  );
}

// Calendar ThemeData
ThemeData customThemeData({@required BuildContext context}) {
  return ThemeData.light().copyWith(
      buttonColor: primaryColor,
      buttonTheme: ButtonThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
            ),
      ),
      accentColor: primaryColor,
      primaryColor: primaryColor);
}

// Custom Icon
customIcon(
    {String icon,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    double height = 28.0,
    double width = 28.0}) {
  return Container(
    padding: padding,
    height: height.h,
    width: width.h,
    child: Image.asset('assets/icons/$icon'),
  );
}

/// use in `CreateGameScreen` for dialog box heading
class DialogHeading extends StatelessWidget {
  const DialogHeading({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 3.0.w),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        text(title,
            color: colorWhite, fontSize: 10.0, fontWeight: FontWeight.w500),
        GestureDetector(
            onTap: () => Get.back(),
            child: Container(
                height: 2.0.h,
                width: 2.0.h,
                child: customIcon(icon: "close.png")))
      ]),
    );
  }
}

/// Add player icon use in create game screen
class AddPlayerButton extends StatelessWidget {
  const AddPlayerButton({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Container(
              height: 8.0.h,
              width: 8.0.h,
              child: customIcon(icon: 'add_circle.png')),
          SizedBox(height: 1.0.h),
          text(tag,
              fontSize: 9.0,
              color: textPrimaryColor,
              fontWeight: FontWeight.w600)
        ],
      ),
    );
  }
}
