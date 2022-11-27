import 'package:hive_flutter/hive_flutter.dart';

part 'images_model.g.dart';

@HiveType(typeId: 0)
class ImageModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? image;

  ImageModel({this.id,this.image});
}
