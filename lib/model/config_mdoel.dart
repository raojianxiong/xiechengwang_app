
class ConfigModel{

  final String searchUrl;

  ConfigModel(this.searchUrl);

  factory ConfigModel.fromJson(Map<String,dynamic> json){
    return ConfigModel(json['searchUrl']);
  }

  Map<String, dynamic> toJson() {
    return {"searchUrl": this.searchUrl,};
  }


}