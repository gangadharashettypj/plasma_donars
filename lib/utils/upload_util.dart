/*
 * @Author GS
 */
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:plasma_donars/resources/colors.dart';

enum UploadType {
  string,
  file,
  clear,
}

class UploadUtil {
  static Future<String> uploadImage(
      {Function(Image, Uint8List) onImagePick,
      String folderPath = 'random'}) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    PlatformFile file1 = result.files.first;
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: file1.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: MyColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile == null) return null;
    onImagePick?.call(
        Image.file(File(croppedFile.path)), croppedFile.readAsBytesSync());
    firebase_storage.UploadTask task = _uploadFile(
        croppedFile,
        DateTime.now().millisecondsSinceEpoch.toString() + file1.name,
        folderPath);

    firebase_storage.TaskSnapshot snapshot = await task.whenComplete(() {});
    return snapshot.ref.getDownloadURL();
  }

  static firebase_storage.UploadTask _uploadFile(
      File file, String name, String folderPath) {
    if (file == null) {
      return null;
    }

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child(folderPath)
        .child(name);
    return ref.putFile(File(file.path));
  }
}
