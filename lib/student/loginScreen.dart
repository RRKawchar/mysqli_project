import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email=TextEditingController();
  final _name=TextEditingController();

  Future<void> login(String name, String email)async{
    var map = Map<String, dynamic>();
    map['Name'] = '$name';
    map['Email'] = '$email';
    final response=await http.put(Uri.parse("https://mysql-test-site.000webhostapp.com/loginScreen.php"),body: map);
    var data;
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());
      print(data);
      return data;
    }
    else{
      throw Exception('No data found');
    }
  }

  /*
  <?php
$c=mysqli_connect("localhost","id18593936_riyaz123","D!u7eiXPxjd1sWEr","id18593936_practice1");
$name=$_POST['Name'];
$email=$_POST['Email'];
$sq="SELECT * FROM `student_information` WHERE `name`='$name' AND `email`='$email'";
$u=array();
$result=mysqli_query($c,$sq);
$num_row=mysqli_num_rows($result);
if($num_row>0){
    while($row=mysqli_fetch_assoc($result)){
        $u[]=$row;
    }
}
echo json_encode($u);

?>
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Enter email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: (){
                    login(_name.text,_email.text);
                  },
                  child: Text("Log In")
              )
            ],
          ),
        ),
      )
    );
  }

}
