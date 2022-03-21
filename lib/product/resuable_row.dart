import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResuableRow extends StatelessWidget {
  String title,value;
   ResuableRow({Key? key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Text(value,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
