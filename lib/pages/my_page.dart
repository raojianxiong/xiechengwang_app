import 'package:flutter/material.dart';
import 'package:xiechengwang_app/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    // TODO: implement createState
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WebView(
        url: "https://m.ctrip.com/webapp/myctrip/",
        hideAppBar: true,
        backForbid: true,
        statusBarColor: "4c5bca",
      ),
    );
  }

}
