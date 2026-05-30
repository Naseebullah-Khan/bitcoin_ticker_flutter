import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = dotenv.get('COIN_API_URL');
final apiKey = dotenv.get('COIN_API_KEY');

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = ["BTC", "ETH", "LTC"];

class CoinData {
  final String currency;
  final Map<String, dynamic> prices = {};

  CoinData({required this.currency});

   Future<void> requestData() async {

    final Uri uri = Uri.https(
      apiUrl,
      '/v1/cryptocurrency/listings/latest',
      {"limit": "100", 'convert': currency},
    );

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "X-CMC_PRO_API_KEY": apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> coins = data['data'];

      for (var coin in coins) {
        final symbol = coin['symbol'] as String;
        if (cryptoList.contains(symbol)) {
          final quote = coin['quote'][currency];
          final price = quote['price'] as double;
          prices[symbol] = price.toInt();
        }
      }
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to load coins dats');
    }
  }
}
