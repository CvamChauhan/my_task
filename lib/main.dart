import 'package:flutter/material.dart';
import 'package:my_task1/screens/add_employee.dart';
import 'package:my_task1/screens/data_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(AddEmployeeAdapter());
  await Hive.initFlutter();
  Box box = await Hive.openBox<AddEmployee>('box');

  runApp(
    const MaterialApp(home: DataScreen()),
  );
}
