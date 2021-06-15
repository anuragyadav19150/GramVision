import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gramvision/Farmer/farming_sell_newitem.dart';
// import 'package:panchayat/farming_sell_newitem.dart';

class Farming_Sell extends StatefulWidget {
  @override
  _Farming_SellState createState() => _Farming_SellState();
}

class _Farming_SellState extends State<Farming_Sell> {

  final refer = FirebaseDatabase.instance;
  List<dynamic> lists = [];

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("SellNewItem");
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('AVL FOR SALE'),
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
                      //if (lists[index].right["name"] == "0") {
                        return 
                        Row(
                          children: [
                            Column(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/1.jpg"),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "NAME: ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      //Text("Corn/Maze"),
                                      Text(lists[index].right["name"]),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "PRICE(/KG): ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(lists[index].right["price"]),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Max Avl(KG): ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(lists[index].right["qty"]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
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
                  child: Text("+"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Farming_Sell_NewItem()),
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