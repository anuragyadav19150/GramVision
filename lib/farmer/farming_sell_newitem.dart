import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panchyat/farmer/farming_sell.dart';

class Farming_Sell_NewItem extends StatefulWidget {
  @override
  _Farming_Sell_NewItemState createState() => _Farming_Sell_NewItemState();
}

// ignore: camel_case_types
class _Farming_Sell_NewItemState extends State<Farming_Sell_NewItem> {
  String _name;
  String _qty;
  String _price;
  PickedFile _imagefile;

  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildbottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text('Choose Image'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imagefile = pickedFile;
    });
  }

  Widget _buildImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _imagefile == null
                ? AssetImage("assets/images/17.jpg")
                : FileImage(
                    File(_imagefile.path),
                  ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => _buildbottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
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

  Widget _buildqty() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Quantity'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Qty is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _qty = value;
      },
    );
  }

  Widget _buildprice() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price per unit'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _price = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                _buildImage(),
                _buildName(),
                _buildqty(),
                _buildprice(),
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

                    // print(_name);
                    // print(_qty);
                    // print(_price);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Farming_Sell()),
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
