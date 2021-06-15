import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gramvision/Farmer/farming_buy.dart';
// import 'package:panchayat/farming_buy.dart';

class Item_Cart extends StatefulWidget {

  @override
  _Item_CartState createState() => _Item_CartState();
}

class _Item_CartState extends State<Item_Cart> {
  
  final refer = FirebaseDatabase.instance;
  List<dynamic> lists = [];

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("Cart");

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('CartItems'),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: ref.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (lists.isNotEmpty) {
                    lists.clear();
                  }
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach(
                    (key, values) {
                      lists.add(Pair(key, values));
                    },
                  );
                  return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "ItemName: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["name"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Qty: ",
                                    //textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["qty"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "TotalPrice: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["total"]),
                                ],
                              ),
                  
                            ],
                          ),
                        ),
                      );
                      
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("CHECKOUT"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Farming_Buy()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pair {
  Pair(this.left, this.right);

  final dynamic left;
  final dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}