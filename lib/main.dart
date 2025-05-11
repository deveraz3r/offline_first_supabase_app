import 'package:flutter/material.dart';
import 'package:offline_first_todo/home_screen.dart';
import './brick/repository.dart';
import 'package:sqflite/sqflite.dart' show databaseFactory;

void main() async {
  await Repository.configure(databaseFactory);
  // .initialize() does not need to be invoked within main()
  // It can be invoked from within a state manager or within
  // an initState()
  await Repository().initialize();

  runApp(const MyApp());
}
