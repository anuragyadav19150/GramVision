import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'avl_jobs.dart';

class New_Vacancy extends StatefulWidget {

  @override
  _New_VacancyState createState() => _New_VacancyState();
}

class _New_VacancyState extends State<New_Vacancy> {
  
  String _post;
  String _institutionname;
  String _experience;

  final refer = FirebaseDatabase.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPost() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Post'),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Post is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _post = value;
      },
    );
  }

  Widget _buildInstitute() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Institute'),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Institute is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _institutionname = value;
      },
    );
  }

  Widget _buildExp() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Min Experience '),
      maxLength: 50,
      //keyboardType: TextInputType.number,
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
    
    final ref = refer.reference().child("NewVacancy");
    final ref2 = refer.reference().child("vacancyIndex");

    int vacancyIndex;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('NEW Vacancy'),
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
                _buildPost(),
                _buildInstitute(),
                _buildExp(),
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
                          vacancyIndex = cs["vacancyIndex"];
                        });
                      },
                    );
                    vacancyIndex++;
                    ref2.set({
                      "vacancyIndex": vacancyIndex,
                    });
                    String s = "Vacancy$vacancyIndex";
                    ref.child(s).set({
                      "post": _post,
                      "at": _institutionname,
                      "exp": _experience,
                      "applied": "false",
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Avl_jobs()),
                    );

                    //Send to API
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