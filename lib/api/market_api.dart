import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAbout {
  static Future<dynamic> fetchAbout(String cryptoName) async {
    final apiUrl = Uri.parse(
        'https://data-api.cryptocompare.com/asset/v1/data/by/symbol?asset_symbol=$cryptoName');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      return json;
    } else {
      throw Exception(
          'Failed to fetch crypto data. Status code: ${response.statusCode}');
    }
  }
}

class ApiManager {
  Future<Map<String, dynamic>> getCryptoData({int limit = 100}) async {
    final url =
        'https://min-api.cryptocompare.com/data/top/mktcapfull?limit=$limit&tsym=USD&fda6a333ee629fa55a6d3911ec7f34981aecffa364b98731255a23e72127ac4e';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      return json;
    } else {
      throw Exception(
          'Failed to fetch crypto data. Status code: ${response.statusCode}');
    }
  }
}

class ApiNews {
  int currentPage = 1;
  final String baseUrl =
      'https://min-api.cryptocompare.com/data/v2/news/?lang=EN';

  Future<Map<String, dynamic>> getNewsData() async {
    final url = '$baseUrl&page=$currentPage';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final decodedJson = jsonDecode(body);
      return decodedJson;
    } else {
      throw Exception(
          'Failed to fetch news data. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getMoreNewsData() async {
    currentPage++;

    final url = '$baseUrl&page=$currentPage';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final decodedJson = jsonDecode(body);
      return decodedJson;
    } else {
      throw Exception(
          'Failed to fetch more news data. Status code: ${response.statusCode}');
    }
  }
}
