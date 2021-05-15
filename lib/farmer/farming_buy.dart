import 'package:flutter/material.dart';

class Farming_Buy extends StatefulWidget {
  @override
  _Farming_BuyState createState() => _Farming_BuyState();
}

class _Farming_BuyState extends State<Farming_Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ItemLIST'),
        ),
      ),
      body: ListView(
        children: [
          DataTable(
            columns: [
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Image',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Price',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Buy',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Num1')),
                DataCell(Text('Image1')),
                DataCell(Text('Qt1')),
                DataCell(Text('Unit1')),
                DataCell(ElevatedButton(onPressed: null, child: Text('BUY'))),
              ]),
              DataRow(cells: [
                DataCell(Text('Num2')),
                DataCell(Text('Image2')),
                DataCell(Text('Qt2')),
                DataCell(Text('Unit2')),
                DataCell(ElevatedButton(onPressed: null, child: Text('BUY'))),
              ]),
              DataRow(cells: [
                DataCell(Text('Num3')),
                DataCell(Text('Image3')),
                DataCell(Text('Qt3')),
                DataCell(Text('Unit3')),
                DataCell(ElevatedButton(onPressed: null, child: Text('BUY'))),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
