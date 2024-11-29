import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../feature/client/main_client/presentation/manager/main_nav_client_controller.dart';
import '../utils/injections.dart';


class CheckProvider extends ChangeNotifier {





  XFile? selectedImage;
  Uint8List? selImg;
  Future<void> uploadRequestPhoto(BuildContext context) async {
    EasyLoading.show();
    ImagePicker imagePicker = ImagePicker();
    if(selectedImage == null){
      EasyLoading.dismiss();
    }
    // XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    selImg = await  selectedImage!.readAsBytes();
    notifyListeners();
    print('Image File is ${selectedImage?.path}');
    EasyLoading.dismiss();
  }
  void removeImage() {
    selectedImage = null;
    notifyListeners();

  }




  String requestPhoto = '';
  Future<void> uploadRequestAndImage(BuildContext context) async {
    EasyLoading.show();
    Reference reference = FirebaseStorage.instance.ref()
        .child('RequestPhotos')
        .child(DateTime.now().toString());
    try {
      Reference upload = reference;
      await upload.putFile(File(selectedImage!.path));
      requestPhoto = await upload.getDownloadURL();
      await sl<MainNavClientController>().insertRequestController(context, requestPhoto).whenComplete(()=> EasyLoading.dismiss());
      selectedImage = null;
      notifyListeners();
    }
    catch (e) {
      print('error is $e');
      EasyLoading.dismiss();
    }

  }


}
