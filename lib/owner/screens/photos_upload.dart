import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:need_moto/owner/controller/owner_image_controller.dart';



class UploadPhotos extends StatefulWidget {
  const UploadPhotos({super.key});

  @override
  State<UploadPhotos> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotos> {

  final ImagePicker _imagePicker = ImagePicker();
  RxList<File> multiImages = <File>[].obs; // Use RxList<File> from GetX
  // final ImageController _imageController = Get.find<ImageController>();

  // multiImagePicker() async {
  //   final List<XFile> pickedImage = await _imagePicker.pickMultiImage();
  //   if (pickedImage != null) {
  //     pickedImage.forEach((e) {
  //       multiImages.add(File(e.path));
  //     });
  //     setState(() {});
  //   }
  // }
  // void handleUpload() async {
  //   await _imageController.uploadImagesToFirebase(multiImages);
  // }


  OwnerImageController _imageController = Get.find<OwnerImageController>(); // Get the instance of ImageController

  // multiImagePicker() async {
  //   final List<XFile>? pickedImages = await _imagePicker.pickMultiImage();
  //   if (pickedImages != null) {
  //     multiImages.addAll(pickedImages.map((e) => File(e.path)));
  //     _imageController.updateImages(multiImages.toList()); // Update images using ImageController
  //   }
  // }

  Future<void> multiImagePicker() async {
    final List<XFile>? pickedImages = await _imagePicker.pickMultiImage();
    if (pickedImages != null) {
      List<File> files = pickedImages.map((e) => File(e.path)).toList();
      multiImages.addAll(files);
      _imageController.updateImages(multiImages.toList());
    }
  }

@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      // children: [
      //   Text(
      //     "Upload minimum 6 photos fo vehicle\ninside and outside photo size should be more than 2mb",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      //   ),
      //   SizedBox(height: 10),
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //     child: multiImages.length == 0
      //         ? addphotos()
      //         : GridView.count(
      //             crossAxisCount: 3,
      //             mainAxisSpacing: 15,
      //             crossAxisSpacing: 15,
      //             shrinkWrap: true,
      //             children: multiImages
      //                 .map((e) => Image.file(
      //                       File(e.path),
      //                       fit: BoxFit.cover,
      //                     ))
      //                 .toList(),
      //           ),
      //   ),
      //   multiImages.length > 0 && multiImages.length <= 9
      //       ? addphotos()
      //       : Container(),
      // ]),
        children: [
        Text(
          "Upload minimum 6 photos for the vehicle\nInside and outside photos should be more than 2MB",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Obx(() {
              final List<File>? images = _imageController.images.value;
              return images != null && images.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  shrinkWrap: true,
                  children: images.map((e) => Image.file(e,fit: BoxFit.cover,)).toList(),
                  )
                  : addphotos();
              }),
          ),
          Obx(() {
            final int imageCount = _imageController.images.value?.length ?? 0;
            return imageCount > 0 && imageCount <= 9 ? addphotos() : Container();
            }),
          ],
        ),
    );
  }

  Widget addphotos() {
    return InkWell(
        onTap: () {
          multiImagePicker();
        },
        child: Center(
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black12,
            size: 100,
          ),
        ));
  }
}
