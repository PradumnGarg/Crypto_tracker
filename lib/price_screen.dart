// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bitcoin_tracker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedItem = "USD";

  String rate = "";

  void getRate(String curren) async {
    CoinData coindata1 = CoinData();

    var rate1 = await coindata1.getcoinData(curren);
    var rateint = rate1.toInt();

    setState(() {
      rate = rateint.toString();
    });
  }

  DropdownButton<String> dropdown() {
    List<DropdownMenuItem<String>> dropdownlist = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownlist.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedItem,
        // ignore: prefer_const_literals_to_create_immutables
        items: dropdownlist,
        onChanged: (value) {
          getRate(value.toString());
          setState(() {
            selectedItem = value!;
          });
        });
  }

  CupertinoPicker cupertinoslider() {
    List<Text> dropdownlist = [];

    for (String currency in currenciesList) {
      var newText = Text(currency);
      dropdownlist.add(newText);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedindex) {
          setState(() {
            selectedItem = currenciesList[selectedindex];
          });

          getRate(selectedItem);
          print(selectedindex);
        },
        children: dropdownlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate  $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              // ignore: prefer_const_literals_to_create_immutables
              child: Platform.isIOS ? cupertinoslider() : dropdown()),
        ],
      ),
    );
  }
}
