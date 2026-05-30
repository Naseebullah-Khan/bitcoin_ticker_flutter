import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "dart:io" show Platform;

import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:bitcoin_ticker_flutter/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "AUD";
  Map<String, dynamic> values = {"BTC": '?', "ETH": '?', 'LTC': '?'};

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      list.add(DropdownMenuItem(value: currency, child: Text(currency)));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: list,
      onChanged: (currency) {
        setState(() {
          selectedCurrency = currency!;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> list = [];

    for (String currency in currenciesList) {
      list.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedCurrencyIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedCurrencyIndex];
          getData();
        });
      },
      children: list,
    );
  }

  void getData() async {
    var data = CoinData(currency: selectedCurrency);
    await data.requestData();
    setState(() {
      values = data.prices;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Widget> getCryptoCards() {
    List<Widget> list = [];
    for (var value in values.keys) {
      list.add(
        CryptoCard(
          value: values[value],
          currency: selectedCurrency,
          crypto: value,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
