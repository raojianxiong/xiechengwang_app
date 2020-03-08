class TravelTabModel {
  String url;
  List<TravelTab> tabs;

  TravelTabModel({this.url, this.tabs});


  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    return TravelTabModel(url: json["url"],
      tabs: List.of(json["tabs"]).map((
          i) => TravelTab.fromJson(i)).toList(),);
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
