import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tokoonline2/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tokoonline2/app/utils/api.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //TODO: Implement LoginController


final _getConnect = GetConnect();
TextEditingController emailController = TextEditingController();
TextEditingController PasswordController = TextEditingController();
final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    PasswordController.dispose();
  }

  @override
  void loginNow() async{
    var client = http.Client();
    var response;

    response = await client.post(
      Uri.https('demo-elearning.smkassalaambandung.sch.id','api/login'),
      body:{
        'email':emailController.text,
        'password': PasswordController.text,
      },
    );
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String,dynamic>;
    if(decodedResponse['success'] == true){
      authToken.write('token',decodedResponse['access_token']);
      Get.offAllNamed('/home');
    } else{
      Get.snackbar('error',decodedResponse['message'],
      icon: const Icon(Icons.error),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      forwardAnimationCurve: Curves.bounceIn,
      margin: const EdgeInsets.only(top: 10,left: 5,right: 5));
    }
    // final response = await _getConnect.post(BaseUrl.auth, {
    //   'email' : emailController.text,
    //   'password' : PasswordController.text,
    // });

    // if (response.body['success'] == true) {
    //   authToken.write('token', response.body['access_token']);
    //   Get.offAll( () =>  DashboardView());
    // } else{
    //   Get.snackbar(
    //     'Error',
    //     response.body['message'].toString(),
    //     icon: const Icon(Icons.error),
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     forwardAnimationCurve: Curves.bounceIn,
    //     margin: const EdgeInsets.only(
    //       top: 10,
    //       left: 5,
    //       right: 5,
    //     ),
    //   );
    // }
  }

}
