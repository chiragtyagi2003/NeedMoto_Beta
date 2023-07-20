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
  final OwnerImageController _imageController =
      Get.find<OwnerImageController>(); // Get the instance of ImageController

  Future<void> multiImagePicker() async {
    final List<XFile> pickedImages = await _imagePicker.pickMultiImage();
    List<File> files = pickedImages.map((e) => File(e.path)).toList();
    multiImages.addAll(files);
    _imageController.updateImages(multiImages.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Upload minimum 6 photos for the vehicle\nInside and outside photos should be more than 2MB",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Obx(() {
            final List<File> images = _imageController.images.value;
            return images.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    shrinkWrap: true,
                    children: images
                        .map((e) => Image.file(
                              e,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  )
                : addPhotos();
          }),
        ),
        Obx(() {
          final int imageCount = _imageController.images.value.length;
          return imageCount > 0 && imageCount <= 9 ? addPhotos() : Container();
        }),
      ],
    );
  }

  Widget addPhotos() {
    return InkWell(
      onTap: () {
        multiImagePicker();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.15,
        child: const Center(
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black12,
            size: 100,
          ),
        ),
      ),
    );
  }
}
