///旅拍类别模型
class TravelModel {
  int totalCount;
  List<TravelItem> resultList;

  TravelModel({this.totalCount, this.resultList});

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(totalCount: json["totalCount"],
      resultList: List.of(json["resultList"]).map((
          i) => TravelItem.fromJson(i)).toList(),);
  }

}
class TravelItem{

  int type;
  Article article;

  TravelItem({this.type, this.article});

  factory TravelItem.fromJson(Map<String, dynamic> json) {
    return TravelItem(type: json["type"],
      article: Article.fromJson(json["article"]),);
  }

}
class Article{
  int articleId;
  String articleType;
  int productType;
  int sourceType;
  String articleTitle;
  Author author;
  List<Images> images;
  bool hasVideo;
  int readCount;
  int likeCount;
  int commentCount;
  List<Urls> urls;
  List<Topics> topics;
  List<Pois> pois;
  String publishTime;
  String publishTimeDisplay;
  String shootTime;
  String shootTimeDisplay;
  int level;
  String distanceText;
  bool isLike;
  int collectCount;
  int articleStatus;
  String poiName;

  Article({this.articleId, this.articleType, this.productType, this.sourceType,
      this.articleTitle, this.author, this.images, this.hasVideo,
      this.readCount, this.likeCount, this.commentCount, this.urls,
      this.topics, this.pois, this.publishTime, this.publishTimeDisplay,
      this.shootTime, this.shootTimeDisplay, this.level, this.distanceText,
      this.isLike, this.collectCount, this.articleStatus, this.poiName});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(articleId: json["articleId"],
      articleType: json["articleType"],
      productType: json["productType"],
      sourceType: json["sourceType"],
      articleTitle: json["articleTitle"],
      author: Author.fromJson(json["author"]),
      images: List.of(json["images"]).map((
          i) => Images.fromJson(i)).toList(),
      hasVideo: json["hasVideo"],
      readCount: json["readCount"],
      likeCount: json["likeCount"],
      commentCount: json["commentCount"],
      urls: List.of(json["urls"]).map((
          i) => Urls.fromJson(i)).toList(),
      topics: List.of(json["topics"]).map((
          i) => Topics.fromJson(i)).toList(),
      pois: List.of(json["pois"]).map((
          i) => Pois.fromJson(i)).toList(),
      publishTime: json["publishTime"],
      publishTimeDisplay: json["publishTimeDisplay"],
      shootTime: json["shootTime"],
      shootTimeDisplay: json["shootTimeDisplay"],
      level: json["level"],
      distanceText: json["distanceText"],
      isLike: json["isLike"],
      collectCount: json["collectCount"],
      articleStatus: json["articleStatus"],
      poiName: json["poiName"],);
  }


}
class Author{
  int authorId;
  String nickName;
  String clientAuth;
  String jumpUrl;
  CoverImage coverImage;
  int identityType;
  String tag;

  Author({this.authorId, this.nickName, this.clientAuth, this.jumpUrl,
      this.coverImage, this.identityType, this.tag});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(authorId: json["authorId"],
      nickName: json["nickName"],
      clientAuth: json["clientAuth"],
      jumpUrl: json["jumpUrl"],
      coverImage: CoverImage.fromJson(json["coverImage"]),
      identityType: json["identityType"],
      tag: json["tag"],);
  }


}

class Images{
  int imageId;
  String dynamicUrl;
  String originalUrl;
  double width;
  double height;
  int mediaType;
  bool isWaterMarked;

  Images({this.imageId, this.dynamicUrl, this.originalUrl, this.width,
      this.height, this.mediaType, this.isWaterMarked});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(imageId:json["imageId"],
      dynamicUrl: json["dynamicUrl"],
      originalUrl: json["originalUrl"],
      width: json["width"],
      height: json["height"],
      mediaType: json["mediaType"],
      isWaterMarked: json["isWaterMarked"],);
  }

}
class CoverImage{
  String dynamicUrl;
  String originalUrl;

  CoverImage({this.dynamicUrl, this.originalUrl});

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      dynamicUrl: json["dynamicUrl"], originalUrl: json["originalUrl"],);
  }

}

class Urls{
  String version;
  String appUrl;
  String h5Url;
  String wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(version: json["version"],
      appUrl: json["appUrl"],
      h5Url: json["h5Url"],
      wxUrl: json["wxUrl"],);
  }

}

class Topics{
  int topicId;
  String topicName;
  int level;

  Topics({this.topicId, this.topicName, this.level});

  factory Topics.fromJson(Map<String, dynamic> json) {
    return Topics(topicId: json["topicId"],
      topicName: json["topicName"],
      level: json["level"],);
  }

}
class Pois{
  int poiType;
  int poiId;
  String poiName;
  int businessId;
  int districtId;
  PoiExt poiExt;
  int source;
  int isMain;
  bool isInChina;
  String countryName;

  Pois({this.poiType, this.poiId, this.poiName, this.businessId, this.districtId,
      this.poiExt, this.source, this.isMain, this.isInChina, this.countryName});

  factory Pois.fromJson(Map<String, dynamic> json) {
    return Pois(poiType: json["poiType"],
      poiId: json["poiId"],
      poiName: json["poiName"],
      businessId: json["businessId"],
      districtId:json["districtId"],
      poiExt: PoiExt.fromJson(json["poiExt"]),
      source: json["source"],
      isMain: json["isMain"],
      isInChina: json["isInChina"],
      countryName: json["countryName"],);
  }



}

class PoiExt{
  String h5Url;
  String appUrl;

  PoiExt({this.h5Url, this.appUrl});

  factory PoiExt.fromJson(Map<String, dynamic> json) {
    return PoiExt(h5Url: json["h5Url"], appUrl: json["appUrl"],);
  }



}