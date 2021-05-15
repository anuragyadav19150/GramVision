import 'package:flutter/material.dart';
import 'package:panchyat/farmer/farming_sell_newitem.dart';

class Farming_Sell extends StatefulWidget {
  @override
  _Farming_SellState createState() => _Farming_SellState();
}

class _Farming_SellState extends State<Farming_Sell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('AVL FOR SALE'),
        ),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
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
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Num1')),
                  DataCell(Text('Image1')),
                  DataCell(Text('Qt1')),
                  DataCell(Text('Unit1')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Num2')),
                  DataCell(Text('Image2')),
                  DataCell(Text('Qt2')),
                  DataCell(Text('Unit2')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Num3')),
                  DataCell(Text('Image3')),
                  DataCell(Text('Qt3')),
                  DataCell(Text('Unit3')),
                ]),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text("+"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Farming_Sell_NewItem()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
