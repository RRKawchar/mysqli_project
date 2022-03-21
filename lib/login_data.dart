import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginData extends StatefulWidget {
  const LoginData({Key? key}) : super(key: key);

  @override
  _LoginDataState createState() => _LoginDataState();
}

class _LoginDataState extends State<LoginData> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<String> addData(String name, String email, String password) async {
    var map = Map<String, dynamic>();
    map['Name'] = '$name';
    map['Email'] = '$email';
    map['Password'] = '$password';
    final response = await http.post(
        Uri.parse("https://mysql-test-site.000webhostapp.com/addData.php"),body:map);
    if (response.statusCode == 200) {
      print('Hello'+response.body);
      return response.body;
    } else {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Database"),
        elevation: 16,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                  labelText: 'Enter name', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  labelText: 'Enter email', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                  labelText: 'Enter Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  addData(_name.text, _email.text, _password.text);
                },
                child: Text('Add')
            )
          ],
        ),
      )),
    );
  }
}
