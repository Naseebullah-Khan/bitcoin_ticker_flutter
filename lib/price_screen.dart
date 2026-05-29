import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = "USD";

  void songLyrics() {
    for (int i = 99; i > 0; i--) {
      debugPrint(
        "${i == 0 ? "No more" : i} ${i == 1 ? "bottle" : "bottles"} of beer on the wall, ${i == 0 ? "no more" : i} ${i == 1 ? "bottle" : "bottles"} of beer.",
      );
      debugPrint(
        "Take one down and pass it around, ${i - 1 == 0 ? "no more" : i - 1} ${i - 1 == 1 ? "bottle" : "bottles"} of beer on the wall.",
      );
    }
  }

  void checkNumbers(List<int> myNumbers) {
    List<int> winningNumbers = [12, 6, 34, 22, 41, 9];
    int matchingNumbers = 0;
    for (int number in myNumbers) {
      if (winningNumbers.contains(number)) {
        matchingNumbers += 1;
      }
    }
    debugPrint(
      "You have $matchingNumbers matching ${matchingNumbers < 2 ? "number" : "numbers"}.",
    );
  }

  void whoIsWinning() {
    List<int> ticket1 = [45, 2, 9, 18, 12, 33];
    List<int> ticket2 = [41, 17, 26, 32, 7, 35];

    checkNumbers(ticket1);
  }

  @override
  void initState() {
    super.initState();
    // songLyrics();
    whoIsWinning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
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
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedCurrency,
              items: currenciesList.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
