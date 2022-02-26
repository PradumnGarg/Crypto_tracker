import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  var curren = 'USD';

  Future<double> getcoinData(String curren) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$curren?{api key}');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double rate = jsonResponse['rate'];
      return rate;
    }
    return 0;
  }
}
