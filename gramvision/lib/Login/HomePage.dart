import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gramvision/sharedData/sharedPref.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  Stream usersStream;
  String myName, myProfilePic, myUserName, myEmail, status;
  bool isSearching = false;

  Future<String> getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    //status = await SharedPreferenceHelper().getUserstaus();

    return myProfilePic;
    //setState(() {});
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    this.getMyInfoFromSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            leadingWidth: 450,
            title: Text('PROFILE')),
        body: Container(
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    // onSearchBtnClick(),
                    //if (isSearching) searchUsersList(),
                    // FutureBuilder(
                    //   future: getMyInfoFromSharedPreference(),
                    //   builder: (context, snapshot) {
                    //     return ListTile(
                    //         //title: Text(),
                    //         );
                    //   },
                    // ),
                    // doo(),
                    SizedBox(height: 40.0),
                    Container(
                      height: 100,
                      child: Image.network(myProfilePic),
                      //fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                      text: myName,
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 60, 10),
                      child: Container(
                        child: Text(
                          'Name : ' + myName,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 60, 10),
                      child: Container(
                        child: Text(
                          'UserName : ' + myUserName,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Container(
                        child: Text(
                          'Email : ' + myEmail,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 60, 10),
                      onPressed: signOut,
                      child: Text('Signout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
        ));
  }
}
