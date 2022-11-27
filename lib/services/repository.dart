import 'package:gym/model/images_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


class BoxRepository {
  static const String boxName = "gym_image";

  static openBox() async => await Hive.openBox<ImageModel>(boxName);

  static Box getBox() => Hive.box<ImageModel>(boxName);

  static closeBox() async => await Hive.box(boxName).close();

}