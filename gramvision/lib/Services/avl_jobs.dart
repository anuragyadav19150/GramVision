import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'farming_sell_newitem.dart';
import 'job_apply.dart';
import 'new_vacancy.dart';

class Avl_jobs extends StatefulWidget {
  // const Avl_jobs({ Key? key }) : super(key: key);

  @override
  _Avl_jobsState createState() => _Avl_jobsState();
}

class _Avl_jobsState extends State<Avl_jobs> {
  final refer = FirebaseDatabase.instance;
  List<dynamic> lists = [];

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("NewVacancy");
    //vacancyIndex
    return Scaffold(
      appBar: AppBar(
        title: Text("Availabe Jobs"),
      ),
      body: SingleChildScrollView(
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
                      return SizedBox(
                        child: Card(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Post: ",
                                    //textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["post"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "At: ",
                                    //textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["at"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Experience: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(lists[index].right["exp"]),
                                ],
                              ),
                              if (lists[index].right["applied"]!="true")
                              ElevatedButton(
                                child: Text("APPLY"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Job_Apply(lists[index])),
                                  );
                                },
                              )
                              else
                              ElevatedButton(
                                child: Text("APPLIED"),
                                onPressed: () {
                                  print("Applied already");
                                },
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
                  child: Text("Add Vacancy"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => New_Vacancy()),
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
