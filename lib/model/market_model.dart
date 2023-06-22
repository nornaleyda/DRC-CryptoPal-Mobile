class CryptoItemModel {
  String? name;
  String? symbol;
  num? price;
  num? change;
  num? percent;
  String? imageUrl;

  CryptoItemModel(
      {this.name,
      this.symbol,
      this.price,
      this.change,
      this.percent,
      this.imageUrl});

  CryptoItemModel.fromJson(Map<String, dynamic> json) {
    name = json['CoinInfo']?['FullName'] ?? 'N/A';
    symbol = json['CoinInfo']?['Name'] ?? 'N/A';
    price = json['RAW']?['USD']?['PRICE'] ?? 0.0;
    change = json['RAW']?['USD']?['CHANGE24HOUR'] ?? 0.0;
    percent = json['RAW']?['USD']?['CHANGEPCT24HOUR'] ?? 0.0;
    imageUrl = json['CoinInfo']['ImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['CoinInfo']['FullName'] = name;
    data['CoinInfo']['Name'] = symbol;
    data['RAW']['USD']['PRICE'] = price;
    data['RAW']['USD']['CHANGE24HOUR'] = change;
    data['RAW']['USD']['CHANGEPCT24HOUR'] = percent;
    data['CoinInfo']['ImageUrl'] = imageUrl;

    return data;
  }
}
