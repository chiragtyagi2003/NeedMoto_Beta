// ///  *********************************************
// ///     NOTIFICATION EVENTS LISTENER
// ///  *********************************************
// ///  Notifications events are only delivered after call this method
// static Future<void> startListeningNotificationEvents() async {
// AwesomeNotifications()
//     .setListeners(onActionReceivedMethod: onActionReceivedMethod);
// }
//
//
//
// static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//
// // Retrieve the notification ID from the action
// final notificationId = receivedAction.payload?['notificationId'];
//
// // Retrieve the corresponding phone number from the mapping
// final phoneNumber = Request.instance.notificationIdToPhoneNumber[notificationId];
//
//
// if (receivedAction.buttonKeyPressed == 'REJECT_BUTTON') {
// // Handle Reject button action here
// // This code will be executed when the Reject button is clicked
// // You can perform any desired action or logic
// try {
// Request.instance.updateStatusField('rejected', phoneNumber);
// print('update field called');
// Get.to(RequestRejected(
// vehicleLocation: Request.instance.vehicleLocation,
// source: Request.instance.source,
// destination: Request.instance.destination,
// pickupDateTime: Request.instance.pickupDateTime,
// returnDateTime: Request.instance.returnDateTime,
// delivery: Request.instance.delivery,
// purpose: Request.instance.purpose,
// ownerName: Request.instance.ownerName,
// ownerPhoneNumber: Request.instance.ownerPhoneNumber,
// type: Request.instance.type,
// vehicleNumber: Request.instance.vehiclePlateNumber,
// vehicleName: Request.instance.vehicleName,
// seats: Request.instance.seats,
// rentalPrice: Request.instance.rentalPrice,
//
// ));
// } on Exception catch (e) {
// print(e.toString());
// // TODO
// }
// } else if (receivedAction.buttonKeyPressed == 'ACCEPT_BUTTON') {
// // Handle Accept button action here
// // This code will be executed when the Accept button is clicked
// // You can perform any desired action or logic
// try{
//
// // convert notificationID to string to apply split function
// final phoneNumberFromAccept =  phoneNumber;
// print('Request accepted from $phoneNumberFromAccept');
// Request.instance.updateStatusField('accepted', phoneNumberFromAccept);
// print('update field called');
// Get.to(RequestAccepted(
// vehicleLocation: Request.instance.vehicleLocation,
// source: Request.instance.source,
// destination: Request.instance.destination,
// pickupDateTime: Request.instance.pickupDateTime,
// returnDateTime: Request.instance.returnDateTime,
// delivery: Request.instance.delivery,
// purpose: Request.instance.purpose,
// ownerName: Request.instance.ownerName,
// ownerPhoneNumber: Request.instance.ownerPhoneNumber,
// type: Request.instance.type,
// vehicleNumber: Request.instance.vehiclePlateNumber,
// vehicleName: Request.instance.vehicleName,
// seats: Request.instance.seats,
// rentalPrice: Request.instance.rentalPrice,
// ));
// } on Exception catch (e) {
// print(e.toString());
// // TODO
// }
// }
//
// // For background actions, you can add additional logic or tasks to execute
// if (receivedAction.actionType == ActionType.SilentAction ||
// receivedAction.actionType == ActionType.SilentBackgroundAction) {
// print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
// //await executeLongTaskInBackground();
// } else {
// // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
// //   '/notification-page',
// //       (route) =>
// //   (route.settings.name != '/notification-page') || route.isFirst,
// //   arguments: receivedAction,
// // );
// }
// }

// Future<List<String>> getOwnerIds(String vehicleName) async {
//   try {
//     final QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
//         .collection('vehicles')
//         .get();
//
//     final List<String> ownerIds = vehicleSnapshot.docs
//         .where((doc) => doc['vehicleName'] == vehicleName)
//         .map((doc) => doc['ownerID'].toString())
//         .toList();
//
//     return ownerIds;
//   } catch (e) {
//     print('Error retrieving owner IDs: $e');
//     return [];
//   }
// }

// Future<void> getDeviceTokens(String vehicleName) async {
//   try {
//     // final QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
//     //     .collection('owners')
//     //     .where('vehicleName', isEqualTo: vehicleName)
//     //     .get();
//     //
//     // final List<String> deviceTokens = vehicleSnapshot.docs
//     //     .map((doc) => doc['device_token'].toString())
//     //     .toList();
//
//     final QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
//         .collection('vehicles')
//         .get();
//
//     final List<String> deviceTokens = vehicleSnapshot.docs
//         .where((doc) => doc['vehicleName'] == vehicleName)
//         .map((doc) => doc['device_token'].toString())
//         .toList();
//
//     print('DeviceTokens: $deviceTokens');
//
//     for (String deviceToken in deviceTokens) {
//       await sendNotificationToDevice(deviceToken);
//     }
//   } catch (e) {
//     print('Error retrieving device tokens: $e');
//   }
// }

// Future<void> getDeviceTokens(String vehicleName) async {
//   try {
//
//     print('sendNotifications called');
//     //   // Get the owner IDs of the vehicles with the specified name.
//       final ownerIds = await getOwnerIds(vehicleName);
//       print('fetching owner Ids');
//       print(ownerIds);
//
//     final QuerySnapshot ownersSnapshot = await FirebaseFirestore.instance
//         .collection('owners')
//         .where(FieldPath.documentId, whereIn: ownerIds)
//         .get();
//
//     final List<String> deviceTokens = ownersSnapshot.docs
//         .map((doc) => doc['device_token'].toString())
//         .toList();
//
//     print('DeviceTokens: $deviceTokens');
//
//     for (String deviceToken in deviceTokens) {
//             await sendNotificationToDevice(deviceToken);
//           }
//
//   } catch (e) {
//     print('Error retrieving phone numbers: $e');
//   }
// }

// Future<void> sendNotifications(String vehicleName) async {
//   print('sendNotifications called');
//   // Get the owner IDs of the vehicles with the specified name.
//   final ownerIds = await getOwnerIds(vehicleName);
//   print('fetching owner Ids');
//   print(ownerIds);
//
//   // Get the phone numbers of the owners.
//   //final phonenumbers = await getPhoneNumbers(ownerIds);
//   print('fetching phone numbers');
//   print(phonenumbers);
//
//   // Send notifications to the owners.
//   for (var phonenumber in phonenumbers) {
//     print('Sending notification to $phonenumber');
//     await _sendNotification(phonenumber, vehicleName);
//     print('notification sent to $phonenumber');
//   }
// }

// Future<void> _sendNotification(String phoneNumber, String vehicleName) async {
//   try {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Channel',
//           channelDescription: 'This is the basic channel for app notifications.',
//           defaultColor: Color(0xFF9D50DD),
//           ledColor: Colors.white,
//         ),
//       ],
//     );
//
//     // final notificationId = '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(pow(2, 31) - 1)}';
//     // final notificationId = '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(pow(2, 31).toInt() - 1)}';
//     final notificationId = '${Random().nextInt(pow(2, 31).toInt() - 1)}';
//
//
//     print('Creating notification for $phoneNumber');
//
//     // Store the mapping between notification ID and phone number
//     Request.instance.notificationIdToPhoneNumber[notificationId] = phoneNumber;
//     // print(Request.instance.notificationIdToPhoneNumber);
//     print('Mapping: ${Request.instance.notificationIdToPhoneNumber}');
//
//
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         // convert notification id to int as id accepts only int param
//         id: int.parse(notificationId), // -1 is replaced by a random number
//         channelKey: 'basic_channel',
//         title: 'Vehicle Request',
//         body: "Request has been made!",
//         // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//         // largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//         //'asset://assets/images/balloons-in-sky.jpg',
//         // notificationLayout: NotificationLayout.BigPicture,
//        // payload: {'phoneNumber': phoneNumber},
//         payload: {'notificationId': notificationId, 'phoneNumber': phoneNumber},
//
//       ),
//       actionButtons: [
//         // NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//         NotificationActionButton(
//             key: 'REJECT_BUTTON',
//             label: 'Reject',
//             actionType: ActionType.SilentAction,
//             isDangerousOption: true,
//             color: Colors.red,
//
//         ),
//         NotificationActionButton(
//           key: 'ACCEPT_BUTTON',
//           label: 'Accept',
//           actionType: ActionType.SilentAction,
//           color: Colors.green,
//         )
//       ],
//
//         schedule: NotificationCalendar.fromDate(
//             date: DateTime.now().add(const Duration(seconds: 10))));
//
// } catch (e) {
//     print('Error sending notification: $e');
//     // Handle the error accordingly
//   }
// }


// Send notification to device using device token
// Future<void> sendNotificationToDevice(String deviceToken) async {
//   // await Firebase.initializeApp();
//
//   // Load the private key from the JSON file in the config folder
//   // Load the private key from the JSON file in the config folder
//   var credentials = FirebaseAdmin.instance.certFromPath('keys.json');
//   // Initialize the Firebase Admin SDK with the credentials
//   await FirebaseAdmin.instance.initializeApp(
//     AppOptions(
//       credential: credentials,
//     ),
//   );


//   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
//   final headers = {
//     'Content-Type': 'application/json',
//     // 'Authorization': '', // Replace with your server key
//   };
//
//   final message = {
//     'notification': {
//       'title': 'Vehicle Request',
//       'body': 'Request has been made!',
//     },
//     'to': deviceToken,
//   };
//
//   final response = await http.post(url, headers: headers, body: jsonEncode(message));
//
//   if (response.statusCode == 200) {
//     print('Notification sent successfully.');
//   } else {
//     print('Failed to send notification. Error: ${response.reasonPhrase}');
//   }
// }