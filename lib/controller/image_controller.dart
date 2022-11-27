import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym/model/images_model.dart';
import 'package:gym/model/member_model.dart';
import 'package:gym/services/repository.dart';
import 'package:hive/hive.dart';

class ImagesController extends GetxController {
  final Box _observableBox = BoxRepository.getBox();

  Box get observableBox => _observableBox;

  //gets count of notes
  int get notesCount => _observableBox.length;

  createImage({required ImageModel image}) {
    _observableBox.add(image);
    print('save success');
    update();
  }

  getImage(MemberModel menber) {
    developer.log(_observableBox.values.toList().toString(),
        name: 'Vales of box');
    var list = _observableBox.values.toList();
    dynamic image = list.firstWhere(
      (element) => element.id == menber.mobile.toString(),
    );
    base64string.value = image.image ?? '';
  }

  updateImage({required int index, required ImageModel image}) {
    _observableBox.putAt(index, image);
    update();
  }

  deleteImage({required int index}) {
    _observableBox.deleteAt(index);
    update();
  }

  var base64string = ''.obs;
  var index = 0.obs;
  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      developer.log(file.path, name: 'my.app.category');
      File imagefile = File(file.path); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64string.value =
          base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
    } else {
      developer.log("No file selected");
    }
  }
}
