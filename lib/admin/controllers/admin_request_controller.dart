import 'package:get/get.dart';

class AdminRequestController extends GetxController {
  RxList<String> carnames = ['Audi', 'Ferrari', 'Mercedes-Benz', 'Hyundai'].obs;
  RxList<String> model = ['A4', 'F40', 'S-class', 'i20'].obs;
  RxList<String> carnumber =
      ['TS28BZ1122', 'TS28BZ2234', 'TS28BZ5124', 'TS28BZ6632'].obs;

  RxList<String> customernames = ['Suresh', 'Ramesh', 'Mahesh', 'Ragesh'].obs;
  RxList<int> timeinhrs = [20, 34, 46, 25].obs;
  RxList<int> distanceinkm = [750, 640, 640, 750].obs;
  RxList<String> sources =
      ['Hyderabad', 'Bengaluru', 'Ongole', 'Tirupathi'].obs;
  RxList<String> destination =
      ['Tirupathi', 'Ongole', 'Bengaluru', 'Hyderabad'].obs;
}