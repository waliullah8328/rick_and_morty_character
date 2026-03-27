import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'feature/home_section/home/model/home_model.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ResultAdapter());
  Hive.registerAdapter(LocationAdapter());

  await Hive.openBox<Result>('characters');
  await Hive.openBox<int>('favorites');
  runApp(ProviderScope(child: MyApp ()));
}


