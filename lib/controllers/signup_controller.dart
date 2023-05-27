import 'package:get/get.dart';

class SignupController extends GetxController {
  final email = RxString('');
  final password = RxString('');
  final showSpinner = RxBool(false);
}
