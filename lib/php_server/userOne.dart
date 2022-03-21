import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:mysql_database/product/productOne.dart';

class UserOne extends StatefulWidget {
  const UserOne({Key? key}) : super(key: key);

  @override
  _UserOneState createState() => _UserOneState();
}

class _UserOneState extends State<UserOne> {
  final _email=TextEditingController();
  final _pass=TextEditingController();

  Future loginUi()async{
    var url="https://mysql-test-site.000webhostapp.com/loginTwo.php";
    var response=await http.post(Uri.parse(url),body: {
      "Email":_email.text,
      "Password":_pass.text
    });
    var data=json.decode(response.body);
     print(response.body);
    if(data=="Success"){

      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOne()));
    }else{
      Fluttertoast.showToast(
          msg: "Email & Password Incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(

      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Icon(Icons.account_circle,size: 200,),
            signIn(),
            SizedBox(height: 20,),
             GestureDetector(
               child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                              color: Colors.black, fontSize: 18),
                             children: <TextSpan>[
                              TextSpan(text: ' Sign up',
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 18,fontWeight: FontWeight.bold),

                            )
                          ]
                      ),
                    ),
                  )
            ),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
               },
             )
          ],
        ),
      ),

    );
  }
  Widget signIn() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Email",
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
              hintText: "Enter Password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          MaterialButton(
            onPressed: () {
              loginUi();
            },
            child:Text(
              "Log In",
              style: GoogleFonts.varelaRound(fontSize: 20.0, color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _name=TextEditingController();
  final _email=TextEditingController();
  final _password=TextEditingController();


  Future<String> registarUi(String name,String email,String password)async{
    var map=Map<String, dynamic>();
    map["Name"]='$name';
    map["Email"]='$email';
    map["Password"]='$password';

    final response=await http.post(Uri.parse("https://mysql-test-site.000webhostapp.com/signUp.php"),body: map);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: response.body.toString());
      print(response.body);
      return response.body;
    }
    return "Failed";
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Icon(Icons.account_circle,size: 200,),
            signUpUi(),
            SizedBox(height: 20,),
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already create account!!',
                          style: TextStyle(
                              color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(text: ' Log In',
                              style: TextStyle(
                                  color: Colors.purple, fontSize: 18,fontWeight: FontWeight.bold),

                            )
                          ]
                      ),
                    ),
                  )
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserOne()));
              },
            )
          ],
        ),
      ),

    );
  }
  Widget signUpUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Name",
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
              hintText: "Enter Email",
              prefixIcon: Icon(Icons.account_box),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          MaterialButton(
            onPressed: () {
              registarUi(_name.text, _email.text, _password.text);
            },
            child:Text(
              "Sign Up",
              style: GoogleFonts.varelaRound(fontSize: 20.0, color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

