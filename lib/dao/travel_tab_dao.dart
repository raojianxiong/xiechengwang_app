import 'dart:convert';

import 'package:xiechengwang_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TAB_URL = "https://www.devio.org/io/flutter_app/json/travel_page.json";

class TravelTabDao{
  static Future<TravelTabModel> fetch() async{
    final response = await http.get(TAB_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();//fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    }else{
      throw Exception("Failed to load travel_page.json");
    }
  }
}