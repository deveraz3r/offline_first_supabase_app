import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:offline_first_todo/views/home_view.dart';
import 'data/brick/brick_repository.dart';
import 'package:sqflite/sqflite.dart' show databaseFactory;

void main() async {
  await dotenv.load(fileName: ".env");
  await BrickRepository.configure(databaseFactory);
  // .initialize() does not need to be invoked within main()
  // It can be invoked from within a state manager or within
  // an initState()
  await BrickRepository().initialize();

  runApp(const MyApp());
}
