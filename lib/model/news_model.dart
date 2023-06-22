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
    tags = json['tags'];
    source = json['source_info']['name'];
    img = json['source_info']['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['imageurl'] = imageUrl;
    data['title'] = title;
    data['body'] = body;
    data['tags'] = tags;
    data['source_info']['name'] = source;
    data['source_info']['img'] = img;

    return data;
  }
}
