import 'package:get/get.dart';

class AdminBookingController extends GetxController {
  RxList<String> carnames = ['Audi', 'Ferrari', 'Mercedes-Benz', 'Hyundai'].obs;
  RxList<String> model = ['A4', 'F40', 'S-class', 'i20'].obs;
  RxList<String> carnumber =
      ['TS28BZ1122', 'TS28BZ2234', 'TS28BZ5124', 'TS28BZ6632'].obs;
  RxList<String> ownernames = ['Ragesh', 'Rajesh', 'Suresh', 'Ramesh'].obs;
  RxList<String> phnos =
      ['+919874563211', '+919632145870', '+919852364177', '+919456871023'].obs;

  RxList<String> customernames = ['Suresh', 'Ramesh', 'Mahesh', 'Ragesh'].obs;
  RxList<int> timeinhrs = [20, 34, 46, 25].obs;
  RxList<int> distanceinkm = [750, 640, 640, 750].obs;
  RxList<String> sources =
      ['Hyderabad', 'Bengaluru', 'Ongole', 'Tirupathi'].obs;
  RxList<String> destination =
      ['Tirupathi', 'Ongole', 'Bengaluru', 'Hyderabad'].obs;
}
