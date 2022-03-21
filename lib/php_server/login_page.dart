import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool signin = true;
  bool processing = false;
  @override
  void dispose() {
    // TODO: implement dispose
    processing;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
            ),
            boxUi()
          ],
        ),
      ),
    );
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else {
      setState(() {
        signin = true;
      });
    }
  }

  Future<String> signUpUser(String name,String email,String pass)async{
    var map=Map<String,dynamic>();
    map["Name"]="$name";
    map["Email"]="$email";
    map["Password"]="$pass";
    final response=await http.post(Uri.parse("https://mysql-test-site.000webhostapp.com/signUp.php"),body: map);
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: response.body.toString());
        return response.body;
      }else{
        return "Somthing wrong";
      }
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                  onPressed: () {
                    changeState();
                  },
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.varelaRound(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: signin == true ? Colors.blue : Colors.grey),
                  )),
              FlatButton(
                  onPressed: () {
                    changeState();
                  },
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.varelaRound(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: signin != true ? Colors.blue : Colors.grey),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          signin == true ? signInUi() : signUpUi(),
        ],
      ),
    );
  }

  Widget signInUi() {
    return Column(
      children: [
        TextField(
          controller: _email,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email",
            prefixIcon: Icon(Icons.account_box),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _pass,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "password",
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        MaterialButton(
            onPressed: () {},
            child:Text(
                    "Sign In",
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.blue),
                  ))
      ],
    );
  }

  Widget signUpUi() {
    return Column(
      children: [
        TextField(
          controller: _name,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Name",
            prefixIcon: Icon(Icons.account_box),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _email,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email",
            prefixIcon: Icon(Icons.account_box),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _pass,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "password",
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        MaterialButton(
          onPressed: () {
            signUpUser(_name.text, _email.text, _pass.text);
          },
          child:Text(
            "Sign Up",
            style: GoogleFonts.varelaRound(fontSize: 18.0, color: Colors.blue),
          ),
        )
      ],
    );
  }
}
