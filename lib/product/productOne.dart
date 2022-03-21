import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_database/constrains/api_link.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_database/product/product_modal.dart';
import 'package:mysql_database/product/product_view.dart';

class ProductOne extends StatefulWidget {
  const ProductOne({Key? key}) : super(key: key);

  @override
  _ProductOneState createState() => _ProductOneState();
}

class _ProductOneState extends State<ProductOne> {
  final _pid = TextEditingController();
  final _pname = TextEditingController();
  final _pprice = TextEditingController();
  final _pquentity = TextEditingController();
  final _pdetails = TextEditingController();

  Future<String> addProduct(String pid, String pname, String pprice,
      String pquentity, String pdetails) async {
    var map = Map<String, dynamic>();
    map['Id'] = '$pid';
    map['productName'] = '$pname';
    map['Price'] = '$pprice';
    map['Quentity'] = '$pquentity';
    map['Details'] = '$pdetails';

    final response = await http.post(Uri.parse('${api + addData}'), body: map);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: response.body.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response.body.toString());
      return response.body;
    } else {
      return 'Error';
    }
  }
  Future<String> updateData(String id,String name,String price,String quentity,String detail)async{
    var map=Map<String,dynamic>();
    map['Id']='$id';
    map['productName ']='$name';
    map['Price ']='$price';
    map['Quentity ']='$quentity';
    map['Details ']='$detail';

    final response=await http.post(Uri.parse("${api+productUpdate}"),body: map);

    if(response.statusCode==200){
      print(response.body);
      return response.body;
    }else{
      return 'Something wrong';
    }

  }

  void clearData() {
    _pid.clear();
    _pname.clear();
    _pprice.clear();
    _pquentity.clear();
    _pdetails.clear();
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
        title: Text('Product Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
                controller: _pid,
                decoration: InputDecoration(
                    hintText: 'Enter product Id',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: _pname,
                decoration: InputDecoration(
                    hintText: 'Enter Product name',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: _pprice,
                decoration: InputDecoration(
                    hintText: 'Enter Product price',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: _pquentity,
                decoration: InputDecoration(
                    hintText: 'Enter Product quentity',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: _pdetails,
                decoration: InputDecoration(
                    hintText: 'Enter Product details',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      addProduct(_pid.text, _pname.text, _pprice.text,
                          _pquentity.text, _pdetails.text);
                      clearData();
                    },
                    child: Text(
                      'Insert',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                    onPressed: () {
                      updateData(_pid.text, _pname.text, _pprice.text, _pquentity.text, _pdetails.text);
                    },
                    child: Text(
                      'Update',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Delete',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      clearData();
                    },
                    child: Text(
                      'Clear',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 5,
                ),
                OutlinedButton.icon(
                    onPressed: () {
                      _navigateAndDisplayData(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                    label: Text(
                      "View",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
  void _navigateAndDisplayData(BuildContext context)async{
    ProductModal data;
    data=await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductView()));

    _pid.text=data.id!;
    _pname.text=data.productName!;
    _pprice.text=data.price!;
    _pquentity.text=data.quentity!;
    _pdetails.text=data.details!;


  }
}
