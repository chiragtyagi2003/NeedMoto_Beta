import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/owner_file_controller.dart';
import '../controller/owner_tile_document_controller.dart';

class KycUploadDocumentTile extends StatelessWidget {
  final String fileName;
  final TileDocumentController tileDocController;
  final OwnerFileController fileController;

  KycUploadDocumentTile({required this.fileName, required this.fileController})
      : tileDocController = Get.put(TileDocumentController(), tag: fileName);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 2.0),
          child: GestureDetector(
            onTap: () async {
              // Your file picker logic here
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'png'],
                );

                if (result != null) {
                  File file = File(result.files.single.path!);
                  String extension = result.files.single.extension!;
                  String name = result.files.single.name;
                  double fileSizeInKB = file.lengthSync() / 1024;
                  print(fileSizeInKB);
                  String size = fileSizeInKB < 1000
                      ? '${fileSizeInKB.toStringAsFixed(2)} KB'
                      : '${(fileSizeInKB / 1024).toStringAsFixed(2)} MB';
                  if (fileSizeInKB < 300 || fileSizeInKB > 2000) {
                    // Show error message
                    tileDocController.updateErrorMessage(
                        'File size must be between 300KB and 2MB.');
                  } else {
                    // Update tile information
                    tileDocController.updateFileName('$name - $size');
                    tileDocController.updateFileExtension(extension);
                    double progess_percentage = (fileSizeInKB / 2000);
                    print(progess_percentage);
                    tileDocController
                        .updateProgressBarValue(progess_percentage);
                    tileDocController.updateErrorMessage(null);

                    //upload file
                    fileController.addFile(file);
                    // Do something with the file here
                  }
                } else {
                  // User canceled the picker
                }
              } on Exception catch (e) {
                Fluttertoast.showToast(
                  msg: "Error.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey[600],
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              }
            },
            child: Row(
              children: [
                Icon(
                  tileDocController.fileExtension.value == 'pdf'
                      ? Icons.picture_as_pdf_rounded
                      : tileDocController.fileExtension.value == 'jpg' ||
                              tileDocController.fileExtension.value == 'png'
                          ? Icons.photo_size_select_actual_rounded
                          : Icons.insert_drive_file_rounded,
                  size: 40.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tileDocController.fileName.value.isNotEmpty
                            ? tileDocController.fileName.value
                            : fileName,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      LinearProgressIndicator(
                        value: tileDocController.progressBar.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      Obx(() => Text(
                            tileDocController.errorMessage.value ?? '',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
