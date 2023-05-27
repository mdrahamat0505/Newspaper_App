import 'package:get/get.dart';
import 'package:newspaper_app/controllers/news_controller.dart';
import 'package:newspaper_app/controllers/login_controller.dart';
import 'package:newspaper_app/controllers/signup_controller.dart';

class Base {
  final newsC = Get.put(NewsController());
  final loginC = Get.put(LoginController());
  final signupC = Get.put(SignupController());
}
