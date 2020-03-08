import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiechengwang_app/model/search_model.dart';


class SearchDao{
  static Future<SearchModel> fetch(String url,String keyword) async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      //fix中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    }else{
      throw Exception("Failed to Search");
    }
  }
}