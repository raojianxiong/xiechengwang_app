//搜索模型
class SearchModel {
  String keyword;
  final List<SearchItem> data;

  SearchModel({this.data,this.keyword});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      data: List.of(json["data"])
          .map((i) => SearchItem.fromJson(i))
          .toList(),
    );
  }
}

class SearchItem {
  final String word; //xxx酒店
  final String type; //hotel
  final String price; //实时计价
  final String zonename; //虹桥
  final String districtname; //上海
  final String url;
  final String star;

  SearchItem(
      {this.word,
      this.type,
      this.price,
      this.zonename,
      this.districtname,
      this.url,this.star});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json["word"],
      type: json["type"],
      price: json["price"],
      zonename: json["zonename"],
      districtname: json["districtname"],
      url: json["url"],
      star: json["star"]
    );
  }
}
