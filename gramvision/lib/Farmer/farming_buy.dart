import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import 'itemCart.dart';

class Farming_Buy extends StatefulWidget {
  @override
  _Farming_BuyState createState() => _Farming_BuyState();
}

class _Farming_BuyState extends State<Farming_Buy> {
  @override
  final refer = FirebaseDatabase.instance;
  List<dynamic> lists = [];
  String valueText;
  String codeDialog;
  int intvalueText=-1;

  Future<void> _displayTextInputDialog(BuildContext context, dynamic item) async {
    TextEditingController _textFieldController = TextEditingController();
    final ref = refer.reference().child("Cart");
    final ref2 = refer.reference().child("cartsize");
    int cartsize;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Buy'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                  intvalueText=int.parse(valueText);
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter Qty (Max Qty: ${item.right["qty"]})"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('+Cart'),
                onPressed: () async {
                  // if (intvalueText<=item.right["qty"])
                    await ref2.once().then(
                        (DataSnapshot data) {
                          // print(data.value);
                          setState(() {
                            print(data.value);
                            Map<dynamic, dynamic> cs = data.value;
                            cartsize = cs["cartsize"];
                          });
                        },
                      );
                      cartsize++;
                      ref2.set({
                        "cartsize": cartsize,
                      });
                      String s = "cartitem$cartsize";
                      ref.child(s).set({
                        "name": item.right["name"],
                        "qty": intvalueText.toString(),
                        "price": item.right["price"],
                        "total": (intvalueText*(int.parse(item.right["price"]))).toString(),
                      });
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }


  Widget build(BuildContext context) {
    final ref = refer.reference().child("SellNewItem");

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ItemLIST'),
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
                        return 
                        Row(
                          children: [
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
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        _displayTextInputDialog(context, lists[index]);
                                      }, 
                                      child: Text("buy")),
                                  ],
                                ),
                                
                              ],
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
                  child: Text("ViewCart"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Item_Cart()),
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