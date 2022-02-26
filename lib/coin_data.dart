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

  Future<double> getcoinDataBTC(String curren) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$curren?apikey=6810B43C-6D87-48C8-90D4-E1C23D291314');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double rate = jsonResponse['rate'];
      return rate;
    }
    return 0;
  }

  Future<double> getcoinDataETH(String curren) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/ETH/$curren?apikey=6810B43C-6D87-48C8-90D4-E1C23D291314');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double rate = jsonResponse['rate'];
      return rate;
    }
    return 0;
  }

  Future<double> getcoinDataLTC(String curren) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/LTC/$curren?apikey={apikey}');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double rate = jsonResponse['rate'];
      return rate;
    }
    return 0;
  }
}
