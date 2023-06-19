import 'package:get/get.dart';


class DropdownController extends GetxController {
  var selectedItem = ''.obs;
  List<String> options = ['Select seat','2','4','6'];

  void setValue(String value){
    selectedItem.value = value;
  }

  var selectType = ''.obs;
  List<String> option = ['Home Delivery','Pick up'];

  void setvalue(String value){
    selectType.value = value;
  }
}