import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panchayat/main.dart';

class Complaint_Appeal extends StatefulWidget {
  // Complaint_Appeal({this.app});
  // final Firebase app;

  @override
  _Complaint_AppealState createState() => _Complaint_AppealState();
}

class _Complaint_AppealState extends State<Complaint_Appeal> {
  String _name;
  String _address;
  String _contact;
  String _others;
  String _complaint;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final refer = FirebaseDatabase.instance;
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final othersController = TextEditingController();
  final complaintController = TextEditingController();

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

  Widget _buildAddress() {
    return TextFormField(
      controller: addressController,
      decoration: InputDecoration(labelText: 'Enter your Address'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is required';
        }

        return null;
      },
      onSaved: (String value) {
        _address = value;
      },
    );
  }

  Widget _buildContact() {
    return TextFormField(
      controller: contactController,
      decoration: InputDecoration(labelText: 'Enter your contact number'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Contact no. is required';
        }

        return null;
      },
      onSaved: (String value) {
        _contact = value;
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

  Widget _buildOthers() {
    return TextFormField(
      controller: othersController,
      decoration: InputDecoration(
          labelText:
              'Enter the details of other persons involved in this complaint'),
      maxLength: 100,
      validator: (String value) {
        // if (value.isEmpty) {
        //   return 'Details is required';
        // }

        return null;
      },
      onSaved: (String value) {
        _others = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ref = refer.reference();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Appeal'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildAddress(),
                _buildContact(),
                _buildComplaint(),
                _buildOthers(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();

                    String s = _name;
                    //jugaad: replace _name below with some string like "nddjkdvjn" and it will work
                    ref.child("svvf").set({
                      "contact": _contact,
                      "address": _address,
                      "others": _others,
                      "complaint": _complaint,
                    });
                    //using below mentioned method I can push the data in firebase
                    // ref.child("Fd").push().set(value)
                    print("I am done");
                    // ref
                    //     .child(_name)
                    //     .push()
                    //     .child("contact")
                    //     .set(_contact)
                    //     .asStream();

                    nameController.clear();
                    addressController.clear();
                    contactController.clear();
                    othersController.clear();
                    complaintController.clear();

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
