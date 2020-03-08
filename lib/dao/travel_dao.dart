import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiechengwang_app/model/travel_model.dart';

// ignore: non_constant_identifier_names
var Params = {
    "districtId": -1,
    "groupChannelCode": "tourphoto_global1",
    "type": null,
    "lat": -180,
    "lon": -180,
    "locatedDistrictId": 2,
    "pagePara": {
      "pageIndex": 1,
      "pageSize": 10,
      "sortType": 9,
      "sortDirection": 0
    },
    "imageCutType": 1,
    "head": {
      "cid": "09031014111431397988",
      "ctok": "",
      "cver": "1.0",
      "lang": "01",
      "sid": "8888",
      "syscode": "09",
      "auth": null,
      "extension": [
        {
          "name": "protocal",
          "value": "https"
        }
      ]
    },
    "contentType": "json"

};
class TravelDao{
  static Future<TravelModel> fetch(String url,String groupChannelCode,int pageIndex,int pageSize) async{
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;

    final response = await http.post(url,body: jsonEncode(Params));
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();//fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    }else{
      throw Exception("Failed to load travel");
    }
  }
}