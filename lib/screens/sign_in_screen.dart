import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'add_employee.dart';

class SignInScreen extends StatefulWidget {
  final int index;
  SignInScreen({required this.index});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late int index;
  late String age, gender;
  late Box<AddEmployee> box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<AddEmployee>('box');
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            box.getAt(index)!.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          box.getAt(index)!.isSignIn
              ? Text(box.getAt(index)!.age)
              : TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter Age',
                  ),
                  cursorColor: Colors.black,
                ),
          const SizedBox(
            height: 10,
          ),
          box.getAt(index)!.isSignIn
              ? Text(box.getAt(index)!.gender)
              : TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter Gender (male/female)',
                  ),
                  cursorColor: Colors.black,
                ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              AddEmployee newEmp = AddEmployee(
                  name: box.getAt(index)!.name, age: age, gender: gender);
              box.putAt(index, newEmp);
              box.getAt(index)!.toggle();
              await Alert(
                      buttons: [],
                      context: context,
                      title: "Employee Details",
                      desc: 'Name: ${box.getAt(index)!.name}'
                          '\nAge: ${box.getAt(index)!.age} '
                          '\nGender: ${box.getAt(index)!.gender}')
                  .show();
              Navigator.pop(context);
            },
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.yellow),
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
