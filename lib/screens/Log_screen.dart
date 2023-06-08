
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/LogController.dart';
import '../controllers/Request_Controller.dart';
import 'RequestAccepted.dart';
import 'Request_Pending.dart';
import 'Request_Rejected.dart';
//
// class LogScreen extends StatelessWidget {
//   final logController = Get.put(LogController());
//   final requestController = Get.put(RequestController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Request Log',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Expanded(child: GetBuilder<LogController>(builder: (controller) {
//             return ListView.builder(
//               itemCount: logController.productData.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: EdgeInsets.all(5),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (logController.productData[index].request ==
//                           'Request Accepted') {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => RequestAccepted())));
//                       }
//                       if (logController.productData[index].request ==
//                           'Request Rejected') {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => RequestRejected())));
//                       }
//                       if (logController.productData[index].request ==
//                           'Request Pending') {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => RequestPending())));
//                       }
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: Theme.of(context).primaryColor, width: 0),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       elevation: 5,
//                       child: Column(
//                         children: [
//                           Padding(padding: EdgeInsets.all(10)),
//                           Container(
//                             width: 350,
//                             height: 25,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   logController.productData[index].request,
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 30,
//                                   padding: EdgeInsets.all(0),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15)),
//                                   child: Image.asset(logController
//                                       .productData[index].reqImage),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 350,
//                             height: 20,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Seats: ${logController.productData[index].seats}',
//                                   style: TextStyle(fontSize: 17),
//                                 ),
//                                 Text(
//                                   'Pickup: ${logController.productData[index].pickup}',
//                                   style: TextStyle(fontSize: 17),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 350,
//                             height: 25,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Delivery: ${logController.productData[index].delivery}',
//                                   style: TextStyle(fontSize: 17),
//                                 ),
//                                 Text(
//                                   'Drop: ${logController.productData[index].drop}',
//                                   style: TextStyle(fontSize: 17),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 200,
//                             height: 30,
//                             child: TextButton(
//                               onPressed: () {
//                                 requestController.change();
//                               },
//                               child: Text('click'),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }))
//         ],
//       ),
//     );
//   }
//
//   method1() {
//     if (logController.request == 'Request Accepted') {
//       return RequestAccepted();
//     } else if (logController.request == 'Request Rejected') {
//       return RequestRejected();
//     } else {
//       return RequestPending();
//     }
//   }
// }


class LogScreen extends StatelessWidget {
  final logController = Get.put(LogController());
  final requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        title: Text(
          'Request Log',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: GetBuilder<LogController>(builder: (controller) {
              return ListView.builder(
                itemCount: logController.productData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        if (logController.productData[index].request ==
                            'Request Accepted') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RequestAccepted())));
                        }
                        if (logController.productData[index].request ==
                            'Request Rejected') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RequestRejected())));
                        }
                        if (logController.productData[index].request ==
                            'Request Pending') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RequestPending())));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      logController.productData[index].request,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Image.asset(logController
                                          .productData[index].reqImage),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Seats:',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${logController.productData[index].seats}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Delivery:',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${logController.productData[index].delivery}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   'Delivery: ${logController.productData[index].delivery}',
                                      //   style: TextStyle(fontSize: 17),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pickup Date:',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${logController.productData[index].pickup}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   'Pickup: ${logController.productData[index].pickup}',
                                      //   style: TextStyle(fontSize: 17),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Drop date:',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${logController.productData[index].drop}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                      // Text(
                                      //   'Drop: ${logController.productData[index].drop}',
                                      //   style: TextStyle(fontSize: 17),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: logController
                                                    .productData[index]
                                                    .request ==
                                                'Request Accepted'
                                            ? Colors.green
                                            : Colors.red),
                                    onPressed: () {
                                      requestController.change();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'More Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ))
                                // Container(
                                //   width: 200,
                                //   height: 30,
                                //   child: TextButton(
                                //     onPressed: () {
                                //       requestController.change();
                                //     },
                                //     child: Text('click'),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }))
          ],
        ),
      ),
    );
  }

  method1() {
    if (logController.request == 'Request Accepted') {
      return RequestAccepted();
    } else if (logController.request == 'Request Rejected') {
      return RequestRejected();
    } else {
      return RequestPending();
    }
  }
}