import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_database/student/student_view.dart';

import 'data.dart';

class StudentInformation extends StatefulWidget {
  const StudentInformation({Key? key}) : super(key: key);

  @override
  _StudentInformationState createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _roll = TextEditingController();
  final _technology = TextEditingController();

  Future<String> addData(String id, String name, String phone, String email,
      String roll, String technology) async {
    var map = Map<String, dynamic>();
    map['Id'] = '$id';
    map['Name'] = '$name';
    map['Phone'] = '$phone';
    map['Email'] = '$email';
    map['Roll'] = '$roll';
    map['Technology'] = '$technology';

    final response = await http.post(
        Uri.parse("https://mysql-test-site.000webhostapp.com/studentData.php"),
        body: map);
    if (response.statusCode == 200) {
      print(response.body.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body.toString())));
      return response.body;
    } else {
      return 'error';
    }
  }

  Future<String> updateData(String id, String name, String phone, String email,
      String roll, String technology) async {
    var map = Map<String, dynamic>();
    map['Id'] = '$id';
    map['Name'] = '$name';
    map['Phone'] = '$phone';
    map['Email'] = '$email';
    map['Roll'] = '$roll';
    map['Technology'] = '$technology';

    final response = await http.post(
        Uri.parse(
            "https://mysql-test-site.000webhostapp.com/updateStudent.php"),
        body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Somthing wrong";
    }
  }

  void clearData() {
    _id.clear();
    _name.clear();
    _phone.clear();
    _email.clear();
    _roll.clear();
    _technology.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student information'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _id,
                  decoration: InputDecoration(
                    labelText: 'Enter Id',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Enter name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _phone,
                  decoration: InputDecoration(
                    labelText: 'Enter phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: 'Enter email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _roll,
                  decoration: InputDecoration(
                    labelText: 'Enter Roll',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _technology,
                  decoration: InputDecoration(
                    labelText: 'Enter Technology',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          addData(_id.text, _name.text, _phone.text,
                              _email.text, _roll.text, _technology.text);
                          clearData();
                        },
                        child: Text('Add')),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          updateData(_id.text, _name.text, _phone.text,
                              _email.text, _roll.text, _technology.text);
                          clearData();
                        },
                        child: Text('Update')),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          clearData();
                        },
                        child: Text('Clear')),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: Text('view')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Data data;
    data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentView()),
    );

    _id.text=data.id!;
    _name.text=data.name!;
    _phone.text=data.phone!;
    _email.text=data.email!;
    _roll.text=data.roll!;
    _technology.text=data.technology!;
  }
}
