import 'package:get/get.dart';

class Controller extends GetxController {
  var currentIndex = 0.obs;
  void changePage(int index) {
    currentIndex.value = index;
  }

  RxInt payment = 4000.obs;
  RxInt reading = 665.obs;
  RxDouble time = 23.5.obs;
  RxString type = 'Petrol'.obs;
  RxString message = 'Vehicle is ready to pickup'.obs;
}
