// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bitcoin_tracker/coin_data.dart';
import 'package:bitcoin_tracker/currencycard.dart';
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
  String rateE = "";
  String rateL = "";

  void getRate(String curren) async {
    CoinData coindata1 = CoinData();

    var rate1 = await coindata1.getcoinDataBTC(curren);
    var rateint = rate1.toInt();

    var rate2 = await coindata1.getcoinDataETH(curren);
    var rate2int = rate2.toInt();

    var rate3 = await coindata1.getcoinDataLTC(curren);
    var rate3int = rate3.toInt();

    setState(() {
      rate = rateint.toString();
      rateE = rate2int.toString();
      rateL = rate3int.toString();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getnewCard('BTC', rate, selectedItem),
          SizedBox(
            height: 20,
          ),
          getnewCard('ETH', rateE, selectedItem),
          SizedBox(
            height: 20,
          ),
          getnewCard('LTC', rateL, selectedItem),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Platform.isIOS ? cupertinoslider() : dropdown()),
            ),
          ),
        ],
      ),
    );
  }
}
