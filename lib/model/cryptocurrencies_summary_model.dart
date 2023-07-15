class AboutItemModel {
  String? symbol;
  String? description;
  String? website;

  AboutItemModel({
    this.symbol,
    this.description,
    this.website,
  });

  AboutItemModel.fromJson(Map<String, dynamic> json) {
    print(json['Data']['SYMBOL']);
    symbol = json['Data']['SYMBOL'] ?? 'N/A';
    description = json['Data']['ASSET_DESCRIPTION_SNIPPET'] ?? 'N/A';
    website = json['Data']['WEBSITE_URL'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['Data']['SYMBOL'] = symbol;
    data['Data']['ASSET_DESCRIPTION_SNIPPET'] = description;
    data['Data']['WEBSITE_URL'] = website;
    return data;
  }

  AboutItemModel.fromMap(Map<String, dynamic> map) {
    symbol = map['SYMBOL'];
    description = map['ASSET_DESCRIPTION_SNIPPET'];
    website = map['WEBSITE_URL'];
  }

  Map<String, dynamic> toMap() {
    return {
      'SYMBOL': symbol,
      'ASSET_DESCRIPTION_SNIPPET': description,
      'WEBSITE_URL': website,
    };
  }
}
