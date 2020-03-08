import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xiechengwang_app/dao/search_dao.dart';
import 'package:xiechengwang_app/model/search_model.dart';
import 'package:xiechengwang_app/pages/speak_page.dart';
import 'package:xiechengwang_app/util/navigator_util.dart';
import 'package:xiechengwang_app/widget/search_bar.dart';
import 'package:xiechengwang_app/widget/webview.dart';

//首页接口的searchUrl返回了该接口
const URL =
    "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=";

const TYPES = [
  'channelgroup',
  'channellgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPage createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  String keyword;
  SearchModel searchModel;

  @override
  void initState() {
    if(widget.keyword != null){
      _onTextChange(widget.keyword);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              flex: 1,
              //顶部会有空白 用MediaQuery.removePadding
              child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  _onTextChange(String text) {
    //发起请求
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + keyword;
    SearchDao.fetch(url, keyword).then((model) {
      if (model.keyword == keyword) {
        //解决快速请求展示结果不是最后一次搜索结果的问题
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) {
      return null;
    }
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, WebView(url: item.url, title: "详情"));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item.type)),
              ),
            ),
            Column(
              children: <Widget>[
                Container(width: 300, child: _title(item)),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 300,
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).padding.top),
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              speakClick: _jumpToSpeak,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }

  _typeImage(String type) {
    if (type == null) {
      return "images/type_travelgroup.png";
    }
    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return "images/type_$path.png";
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? "") + " " + (item.zonename ?? ""),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: item.price ?? "",
            style: TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(
            text: ' ' + (item.star ?? ''),
            style: TextStyle(fontSize: 12, color: Colors.grey))
      ]),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) {
      return spans;
    }

    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    // wordwoc split w [,ord,c]
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }

  _jumpToSpeak() {
    NavigatorUtil.push(context, SpeakPage());
  }
}
