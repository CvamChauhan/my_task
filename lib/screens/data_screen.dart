import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task1/screens/sign_in_screen.dart';
import 'add_employee.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List _employeeData = [];
  late Box<AddEmployee> box;
  void readJson() async {
    final String response =
        await rootBundle.loadString('assets/EmployeeData.json');
    _employeeData = await json.decode(response)[0]['users'];
    if (box.isEmpty) {
      for (int i = 0; i < _employeeData.length; i++) {
        AddEmployee newEmp = AddEmployee(name: _employeeData[i]['name']);
        box.add(newEmp);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box<AddEmployee>('box');
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade600,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Employees Data',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 40, bottom: 30),
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ValueListenableBuilder<Box<AddEmployee>>(
                valueListenable: box.listenable(),
                builder: (context, Box<AddEmployee> box, child) {
                  List<int> keys = box.keys.cast<int>().toList();
                  return ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () {
                            Alert(
                                    buttons: [],
                                    context: context,
                                    title: box.getAt(index)!.isSignIn
                                        ? "Employee Details"
                                        : "Please Sign-In",
                                    desc: box.getAt(index)!.isSignIn
                                        ? 'Name: ${box.getAt(index)!.name}'
                                            '\nAge: ${box.getAt(index)!.age} '
                                            '\nGender: ${box.getAt(index)!.gender}'
                                        : '')
                                .show();
                          },
                          focusColor: Colors.grey.shade400,
                          leading: Text(box.getAt(index)!.name,
                              style: const TextStyle(fontSize: 20)),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow.shade400),
                            onPressed: () async {
                              box.getAt(index)!.isSignIn
                                  ? box.getAt(index)!.toggle()
                                  : await showModalBottomSheet(
                                      backgroundColor: const Color(0xff757575),
                                      context: context,
                                      builder: (context) =>
                                          SignInScreen(index: index),
                                    );
                              setState(() {});
                            },
                            child: box.getAt(index)!.isSignIn
                                ? const Text("Sign-Out",
                                    style: TextStyle(color: Colors.black))
                                : const Text("Sign-In",
                                    style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
