
import 'package:xiechengwang_app/model/common_model.dart';
import 'package:xiechengwang_app/model/config_mdoel.dart';
import 'package:xiechengwang_app/model/sales_box_model.dart';

import 'grid_nav_model.dart';

class HomeModel{

  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav,
      this.subNavList, this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(config: ConfigModel.fromJson(json["config"]),
      bannerList: List.of(json["bannerList"]).map((
          i) => CommonModel.fromJson(i)).toList(),
      localNavList: List.of(json["localNavList"]).map((
          i) => CommonModel.fromJson(i)).toList(),
      gridNav: GridNavModel.fromJson(json["gridNav"]),
      subNavList: List.of(json["subNavList"]).map((
          i) => CommonModel.fromJson(i)).toList(),
      salesBox: SalesBoxModel.fromJson(json["salesBox"]),);
  }

  Map<String, dynamic> toJson() {
    return {
      "config": this.config,
      "bannerList": jsonEncode(this.bannerList),
      "localNavList": jsonEncode(this.localNavList),
      "gridNav": this.gridNav,
      "subNavList": jsonEncode(this.subNavList),
      "salesBox": this.salesBox,
    };
  }
  static List jsonEncode(List<CommonModel> list){
    List jsonList = List();
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }


}