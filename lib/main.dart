import 'package:flutter/material.dart';
import 'package:gym/model/images_model.dart';
import 'package:gym/services/repository.dart';
import 'package:gym/view/homescreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
    await Hive.initFlutter();
  Hive.registerAdapter(ImageModelAdapter());
  await BoxRepository.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.teal.shade900,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
