import 'package:flutter/material.dart';
import 'package:gramvision/Homepage/Carousel.dart';
import 'package:gramvision/Homepage/side_drawer.dart';
import 'package:gramvision/Login/HomePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool checkLogIn = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leadingWidth: 450,
        title: Text('Page title'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              //color: Colors.pink,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              iconSize: 30.0,
            ),
          ),
        ],
        leading: IconButton(
          icon: Image.asset('assets/images/logo.png'),
          onPressed: () {},
        ),
      ),
      drawer: SideDrawer(),
      body: Container(
        child: Column(
          children: [
            Carousel(), // calling carousel class
            Column(
              // column  1.farmers
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 352.0,
                    height: 52.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'FARMERS ',
                          style: TextStyle(
                            fontSize: 35,
                            // fontFamily:,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  // sell

                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.storefront),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.auto_stories),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(62, 0, 0, 0),
                      child: Text(
                        'SELL',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(67, 0, 0, 0),
                      child: Text(
                        'BUY',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(62, 0, 0, 0),
                      child: Text(
                        'READ',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 352.0,
                    height: 52.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'COMPLAINTS ',
                          style: TextStyle(
                            fontSize: 35,
                            // fontFamily:,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  // sell

                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.article_outlined),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.pending_outlined),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.gavel_outlined),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.check_circle_outlined),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                      child: Text(
                        'FILE',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                      child: Text(
                        'PROGRSS',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                      child: Text(
                        'APPEAL',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        'RESOLVED',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 352.0,
                    height: 52.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'SERVICES',
                          style: TextStyle(
                            fontSize: 35,
                            // fontFamily:,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  // sell

                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.work_outlined),
                        color: Colors.pink,
                        onPressed: () {},
                        iconSize: 35.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        'VACANCY',
                        style: TextStyle(
                          fontSize: 12,
                          // fontFamily:,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
