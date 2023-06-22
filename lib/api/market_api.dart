import 'dart:convert';
import 'package:http/http.dart' as http;

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
