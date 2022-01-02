import 'package:hive/hive.dart';

part 'add_employee.g.dart';

@HiveType(typeId: 0)
class AddEmployee {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String gender;
  @HiveField(3)
  bool isSignIn = false;

  AddEmployee({required this.name, this.age = '', this.gender = ''});

  void toggle() {
    isSignIn = !isSignIn;
  }
}
