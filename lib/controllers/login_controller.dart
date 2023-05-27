import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = RxString('');
  final password = RxString('');
  final showSpinner = RxBool(false);
}
