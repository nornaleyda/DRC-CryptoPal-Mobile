class NewsItemModel {
  int? id;
  String? imageUrl;
  String? title;
  String? body;
  String? tags;
  String? source;
  String? img;

  NewsItemModel({
    this.id,
    this.imageUrl,
    this.title,
    this.body,
    this.tags,
    this.source,
    this.img,
  });

  NewsItemModel.fromJson(Map<String, dynamic> json) {
    id = json[id];
    imageUrl = json['imageurl'];
    title = json['title'];
    body = json['body'];
    tags = _extractFirstThreeTags(json['tags']);
    source = json['source_info']['name'];
    img = json['source_info']['img'];
  }

  String _extractFirstThreeTags(String? tags) {
    if (tags == null || tags.trim().isEmpty) {
      return 'N/A';
    }

    final List<String> tagList = tags.split('|');
    final int endIndex = tagList.length > 3 ? 3 : tagList.length;

    return tagList.sublist(0, endIndex).join('|');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['imageurl'] = imageUrl;
    data['title'] = title;
    data['body'] = body;
    data['tags'] = tags;
    data['source_info'] = {'name': source, 'img': img};

    return data;
  }
}
