import 'package:flutter/material.dart';
import 'package:xiechengwang_app/pages/home_page.dart';
import 'package:xiechengwang_app/pages/my_page.dart';
import 'package:xiechengwang_app/pages/search_page.dart';
import 'package:xiechengwang_app/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<StatefulWidget> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage()],
        //禁止滑动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _bottomNavigationBar("首页",Icons.home,0),
          _bottomNavigationBar("搜索",Icons.search,1),
          _bottomNavigationBar("旅拍",Icons.camera_alt,2),
          _bottomNavigationBar("我的",Icons.account_circle,3),
        ],
      ),
    );
  }

  _bottomNavigationBar(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor,),
        activeIcon: Icon(icon, color: _activeColor,),
        title:Text(title,style: TextStyle(color: _currentIndex !=index ? _defaultColor:_activeColor),),
    );
  }
}
