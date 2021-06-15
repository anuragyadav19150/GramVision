import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:panchayat/main.dart';

class Complaint_Resolved extends StatefulWidget {
  // Complaint_View({this.app});
  // final Firebase app;

  @override
  _Complaint_ResolvedState createState() => _Complaint_ResolvedState();
}

class _Complaint_ResolvedState extends State<Complaint_Resolved> {
  final refer = FirebaseDatabase.instance;
  List<dynamic> lists = [];
  int x = 5;
  List<String> resolveTextHolder = ["Resolve", "Resolved"];

  // void changeResolveText() {
  //   setState(() {
  //     if (resolveTextHolder == "Resolve") {
  //       resolveTextHolder = "Resolved";
  //     } else {
  //       resolveTextHolder = "Resolve";
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("Complaints");
    // final ref2 = refer.reference();
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Resolved Complaints'),
          ),
        ),
        body: FutureBuilder(
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
                    if (lists[index].right["resolved"] == "1") {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ListTile(
                            //   title: Text("Complaint ID: " + lists[index].left),
                            //   trailing: Icon(Icons.add_box),
                            // ),
                            // Text(lists.length.toString()),
                            // RichText(
                            //     text: TextSpan(
                            //       text: "Complaint ID: ",
                            //       style: TextStyle(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //       children: <TextSpan>[
                            //         TextSpan(
                            //           text: lists[index].left.toString(),
                            //           style: TextStyle(
                            //             fontSize: 20,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),

                            Text(
                              "Complaint ID: " + lists[index].left,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Complaint filed by : " +
                                  lists[index].right["name"],
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Complaint Description :\n" +
                                  lists[index].right["complaint"],
                              style: TextStyle(fontSize: 20),
                            ),
                            ButtonBar(
                              children: [
                                FlatButton(
                                  child: Text(resolveTextHolder[int.parse(
                                      lists[index].right["resolved"])]),
                                  onPressed: () {
                                    setState(
                                      () {
                                        lists[index].right["resolved"] =
                                            lists[index].right["resolved"] ==
                                                    "0"
                                                ? "1"
                                                : "0";
                                        ref.child(lists[index].left).set({
                                          "name": lists[index].right["name"],
                                          "complaint":
                                              lists[index].right["complaint"],
                                          "resolved":
                                              lists[index].right["resolved"],
                                          "upvotes":
                                              lists[index].right["resolved"],
                                          "downvotes":
                                              lists[index].right["downvotes"],
                                        });
                                      },
                                    );
                                    // changeResolveText();
                                  },
                                ),
                              ],
                            ),
                            // Text("Age: " + lists[index]["age"]),
                            // Text("Type: " + lists[index]["type"]),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 0,
                      );
                    }
                  },
                );
              }
              return CircularProgressIndicator();
            }));
  }
}

class Pair {
  Pair(this.left, this.right);

  final dynamic left;
  final dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}
