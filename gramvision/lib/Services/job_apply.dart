import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'avl_jobs.dart';

class Job_Apply extends StatefulWidget {
  dynamic vacancy;
  String vacancyidx;
  Job_Apply(dynamic vacancy) : this.vacancy = vacancy;

  @override
  _Job_ApplyState createState() => _Job_ApplyState(vacancy);
}

class _Job_ApplyState extends State<Job_Apply> {
  String _name;
  String _email;
  String _age;
  String _experience;

  final refer = FirebaseDatabase.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic vacancy;
  _Job_ApplyState(dynamic vacancy): this.vacancy=vacancy;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      maxLength: 50,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _age = value;
      },
    );
  }

  Widget _buildExp() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Experience (yrs)'),
      maxLength: 50,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Exp is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _experience = value;
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    final ref = refer.reference().child("JobsApplied");
    final ref2 = refer.reference().child("jobindex");
    final ref3=refer.reference().child("NewVacancy");

    int jobindex;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('NEW ITEM'),
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
                _buildEmail(),
                _buildAge(),
                _buildExp(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Submit ${vacancy.left}',
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
                          jobindex = cs["jobindex"];
                        });
                      },
                    );
                    jobindex++;
                    ref2.set({
                      "jobindex": jobindex,
                    });
                    String s = "job$jobindex";
                    ref.child(s).set({
                      "vacancyidx": vacancy.left,
                      "name": _name,
                      "email": _email,
                      "age": _age,
                      "exp": _experience,
                    });

                    ref3.child(vacancy.left).set({
                      "post": vacancy.right["post"],
                      "at": vacancy.right["at"],
                      "exp": vacancy.right["exp"],
                      "applied": "true",
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Avl_jobs()),
                    );
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


class Pair {
  Pair(this.left, this.right);

  final dynamic left;
  final dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}