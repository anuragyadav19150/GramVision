import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:panchayat/main.dart';
import 'package:fluttericon/entypo_icons.dart';

class Complaint_View extends StatefulWidget {
  // Complaint_View({this.app});
  // final Firebase app;

  @override
  _Complaint_ViewState createState() => _Complaint_ViewState();
}

class _Complaint_ViewState extends State<Complaint_View> {
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
          child: Text('Ongoing Complaints'),
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
                if (lists[index].right["resolved"] == "0") {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Complaint ID: " + lists[index].left,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Complaint filed by : " + lists[index].right["name"],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Complaint Description :\n" +
                              lists[index].right["complaint"],
                          style: TextStyle(fontSize: 20),
                        ),
                        ButtonBar(
                          children: [
                            IconButton(
                              icon: Icon(
                                Entypo.thumbs_up,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    int upvotes = int.parse(
                                        lists[index].right["upvotes"]);
                                    upvotes++;
                                    ref.child(lists[index].left).set(
                                      {
                                        "name": lists[index].right["name"],
                                        "complaint":
                                            lists[index].right["complaint"],
                                        "resolved":
                                            lists[index].right["resolved"],
                                        "upvotes": upvotes.toString(),
                                        "downvotes":
                                            lists[index].right["downvotes"],
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            Text(
                              lists[index].right["upvotes"],
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              icon: Icon(
                                Entypo.thumbs_down,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    int downvotes = int.parse(
                                        lists[index].right["downvotes"]);
                                    downvotes++;
                                    ref.child(lists[index].left).set(
                                      {
                                        "name": lists[index].right["name"],
                                        "complaint":
                                            lists[index].right["complaint"],
                                        "resolved":
                                            lists[index].right["resolved"],
                                        "upvotes":
                                            lists[index].right["upvotes"],
                                        "downvotes": downvotes.toString(),
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            Text(
                              lists[index].right["downvotes"],
                            ),
                            SizedBox(width: 90),
                            FlatButton(
                              child: Text(
                                resolveTextHolder[
                                    int.parse(lists[index].right["resolved"])],
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    lists[index].right["resolved"] =
                                        lists[index].right["resolved"] == "0"
                                            ? "1"
                                            : "0";
                                    ref.child(lists[index].left).set(
                                      {
                                        "name": lists[index].right["name"],
                                        "complaint":
                                            lists[index].right["complaint"],
                                        "resolved":
                                            lists[index].right["resolved"],
                                        "upvote": lists[index].right["upvotes"],
                                        "downvote":
                                            lists[index].right["downvotes"],
                                      },
                                    );
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
        },
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
