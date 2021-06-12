import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:panchayat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Complaint_File extends StatefulWidget {
  Complaint_File({Key key}) : super(key: key);

  @override
  _Complaint_FileState createState() => _Complaint_FileState();
}

class _Complaint_FileState extends State<Complaint_File> {
  String _name, _complaint;
  // int complaintSize = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final refer = FirebaseDatabase.instance;
  final nameController = TextEditingController();
  final complaintController = TextEditingController();

  // void setSize() {
  //   refer.reference().child("Complaints").child("Size")
  // }

  Widget _buildName() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(labelText: 'Enter your name'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildComplaint() {
    return TextFormField(
      controller: complaintController,
      decoration: InputDecoration(labelText: 'Describe Your Complaint'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        }

        return null;
      },
      onSaved: (String value) {
        _complaint = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("Complaints");
    final ref2 = refer.reference().child("ComplaintSize");
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('File A Complaint'),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildComplaint(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    await ref2.once().then(
                      (DataSnapshot data) {
                        // print(data.value);
                        setState(() {
                          print(data.value);
                          Map<dynamic, dynamic> cs = data.value;
                          complaintSize = cs["ComplaintSize"];
                        });
                      },
                    );
                    print("ComplaintSize : " + complaintSize.toString());
                    complaintSize++;
                    ref2.set({
                      "ComplaintSize": complaintSize,
                    });
                    String s = "Complaint$complaintSize";
                    ref.child(s).set({
                      "name": _name,
                      "complaint": _complaint,
                      "resolved": "0",
                      "upvotes": "0",
                      "downvotes": "0",
                    });
                    // x++;
                    complaintController.clear();
                    nameController.clear();

                    print(_complaint);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
