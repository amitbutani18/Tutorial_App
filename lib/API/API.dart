import 'dart:io';
// import 'package:MyFirstApp/Widgets/custom_snackbar.dart';
import 'package:TutorialApp/Screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TutorialApp/Constants/constant_widgets.dart';
import 'package:TutorialApp/Constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_exception.dart';
import '../Helpers/app_preference.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const String authorization_token =
    'eyJ0eXA1iOi0JKV1QiL8CJhb5GciTWvLUzI1NiJ9IiRk2YXRh8Ig';
const String appSecretKey = 'Mn2fKZG4M1170jDlVn6lOFTN6OE27f6UO99n9QDV';
const String authorization = 'Basic YWRtaW46MTIzNA==';
const String contentType = 'application/x-www-form-urlencoded';
const String jsonContentType = 'application/json';

class ApiBaseHelper {
  final String _baseUrl = "https://smartclick4you.com/tutorials/v1/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, var parameters,
      {String objcontentType = contentType,
      bool isShow = false,
      bool isShowDialog = true}) async {
    print('Api Post, url $url');
    print(GetStorage().read(AppPreferencesHelper.pAppSecretKey));
    var responseJson;
    try {
      if (isShowDialog) EasyLoading.show(maskType: EasyLoadingMaskType.black);
      Map<String, String> header = {
        "Authorization": authorization,
        "App-Secret-Key":
            //"YQ47j2hG9V795kBkk1SUUS0bf8E8dIhb9H38l9QB",
            url == "login"
                ? appSecretKey
                : GetStorage().read(AppPreferencesHelper.pAppSecretKey) != null
                    ? GetStorage().read(AppPreferencesHelper.pAppSecretKey)
                    : appSecretKey,
        "Authorization-Token":
            "eyJ0eXA1iOi0JKV1QiL8CJhb5GciTWvLUzI1NiJ9IiRk2YXRh8Ig", //authorization_token,
        "Content-Type": objcontentType
      };
      print('header- ${header.toString()}');
      print('URL- ${_baseUrl + url}');
      final response = await http.post(_baseUrl + url,
          headers: header,
          encoding: Encoding.getByName("utf-8"),
          body: parameters);
      printInfo(info: response.body);
      Map<dynamic, dynamic> map = _returnResponse(response);
      if (map['status'] == true) {
        if (map['rest_key'] != null) {
          GetStorage()
              .write(AppPreferencesHelper.pAppSecretKey, map['rest_key']);
        }
        printInfo(info: GetStorage().read(AppPreferencesHelper.pAppSecretKey));
        return map['data'];
      } else {
        if (isShow) errorSnackBar(content: map['msg']);
      }
    } on SocketException {
      print('No net');
      errorSnackBar(content: 'No Internet');
      if (isShowDialog) EasyLoading.dismiss();
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return responseJson;
  }

  Future<dynamic> postOtp(String url, Map parameters,
      {String defAppSecretKey = appSecretKey, bool isShow = false}) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      // EasyLoading().userInteractions = false;
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      Map<String, String> header = {
        "Authorization": authorization,
        "App-Secret-Key": defAppSecretKey,
        "Authorization-Token": authorization_token,
        "Content-Type": "application/x-www-form-urlencoded"
      };
      print('header- ${header.toString()}');
      print('URL- ${_baseUrl + url}');
      final response = await http.post(_baseUrl + url,
          headers: header,
          encoding: Encoding.getByName("utf-8"),
          body: parameters);
      // printInfo(info: response.body);
      Map<dynamic, dynamic> map = _returnResponse(response);
      if (map['status'] == true) {
        return map['msg'];
      } else {
        if (isShow) errorSnackBar(content: map['msg']);
      }
    } on SocketException {
      print('No net');
      errorSnackBar(content: 'No Internet');
      EasyLoading.dismiss();
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return responseJson;
  }

  //gajera@gmail.com
  //123456

  dynamic _returnResponse(http.Response response, {bool isShow = false}) {
    EasyLoading.dismiss();
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        if (isShow) errorSnackBar(content: response.body.toString());
        throw BadRequestException(response.body.toString());
      case 401:
        // errorSnackBar(content: response.body.toString());
        GetStorage().erase();
        Get.offAll(SignInScreen(), transition: transition);
        throw BadRequestException(response.body.toString());
      case 403:
        Get.offAll(SignInScreen(), transition: transition);
        print("Hello");
        errorSnackBar(content: response.body.toString());
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        Get.snackbar("Server Error", "${response.statusCode}",
            backgroundColor: Colors.red.withOpacity(0.7));
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
