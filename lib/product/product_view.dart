import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_database/constrains/api_link.dart';
import 'package:mysql_database/product/product_modal.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_database/product/resuable_row.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<ProductModal> dataList = [];

  Future<List<ProductModal>> showData() async {
    final response = await http.get(Uri.parse('${api + showAll}'));
    var data;
    if (response.statusCode == 200) {
      dataList = [];
      data = jsonDecode(response.body.toString());
      for (Map i in data) {
        dataList.add(ProductModal.fromJson(i));

      }
      return dataList;
    } else {
      throw Exception("No found data");
    }
  }

  Future<String> _deleteData(String id) async {
    var map = Map<String, dynamic>();
    map['Id'] = '$id';
    final response =
        await http.post(Uri.parse('${api + deleteData}'), body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Something wrong';
    }
  }

  void refreshData() {
    setState(() {
      showData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product View"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                refreshData();
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: 30,
              ))
        ],
      ),
      body: FutureBuilder<List<ProductModal>>(
        future: showData(),
        builder: (context, AsyncSnapshot<List<ProductModal>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.lightGreen,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ResuableRow(
                              title: "Id",
                              value: dataList[index].id.toString()),
                          ResuableRow(
                              title: "Product Name",
                              value: dataList[index].productName.toString()),
                          ResuableRow(
                              title: "Price",
                              value: dataList[index].price.toString()),
                          ResuableRow(
                              title: "Quentity",
                              value: dataList[index].quentity.toString()),
                          ResuableRow(
                              title: "Details",
                              value: dataList[index].details.toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context,dataList[index]);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return  CupertinoAlertDialog(
                                            title: Padding(
                                              padding: EdgeInsets.only(right: 100),
                                              child: Text(
                                                "Warning!!",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            content: Text(
                                              "Are you want to delete data??",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 15,),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  _deleteData(dataList[index]
                                                      .id
                                                      .toString());
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );

                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Loading.......',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

}
