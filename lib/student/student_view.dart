import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysql_database/student/data.dart';
import 'package:http/http.dart'as http;

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {

  List<Data> dataList=[];

  Future<List<Data>> showData()async{
    final response=await http.get(Uri.parse("https://mysql-test-site.000webhostapp.com/studentShow.php"));
    var data;
    if(response.statusCode==200){
      dataList=[];
      data=jsonDecode(response.body.toString());
      for(Map i in data){
        dataList.add(Data.fromJson(i));
      }
      print(dataList[0].email);
      return dataList;
    }
    else{
      throw Exception('No data found');
    }
  }

  Future<String> deleteData(String id)async{
    var map=Map<String,dynamic>();
    map['Id']='$id';
    final response=await http.post(Uri.parse("https://mysql-test-site.000webhostapp.com/studentDelete.php"),body: map);
    if(response.statusCode==200){
      return response.body;
    }else{
      return 'Somethine wrong';
    }
  }
  void refreshData(){
    setState(() {
      showData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Data'),
      ),
      body: FutureBuilder<List<Data>>(
        future: showData(),
        builder: (context,AsyncSnapshot<List<Data>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(dataList[index].name.toString()),
                  subtitle: Text(dataList[index].technology.toString()),
                  leading: Text(dataList[index].id.toString()),
                  trailing: IconButton(
                    onPressed: (){
                      deleteData(dataList[index].id.toString());
                      refreshData();
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: (){
                       Navigator.pop(context,dataList[index]);
                  },
                );
              },
            );

          }
          else{
            return Center(child: CircularProgressIndicator(
              color: Colors.purple,
              ));
          }
        },
      )
    );
  }
}
