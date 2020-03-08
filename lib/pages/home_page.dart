import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiechengwang_app/dao/home_dao.dart';
import 'package:xiechengwang_app/model/common_model.dart';
import 'package:xiechengwang_app/model/grid_nav_model.dart';
import 'package:xiechengwang_app/model/sales_box_model.dart';
import 'package:xiechengwang_app/pages/search_page.dart';
import 'package:xiechengwang_app/pages/speak_page.dart';
import 'package:xiechengwang_app/util/navigator_util.dart';
import 'package:xiechengwang_app/widget/grid_nav.dart';
import 'package:xiechengwang_app/widget/loading_container.dart';
import 'package:xiechengwang_app/widget/local_nav.dart';
import 'package:xiechengwang_app/widget/sales_box.dart';
import 'package:xiechengwang_app/widget/search_bar.dart';
import 'package:xiechengwang_app/widget/sub_nav.dart';
import 'package:xiechengwang_app/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
const String SEARCH_BAR_DEFAULT_TEXT = "网红打卡地 景点 酒店 美食";

class  HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  String resultString = "";
  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
    //关闭启动屏
    Future.delayed(Duration(milliseconds: 600),(){
      FlutterSplashScreen.hide();
    });

  }

  Future _handleRefresh() {
    return HomeDao.fetch().then((result) {
      setState(() {
        bannerList = result.bannerList;
        localNavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavList = result.subNavList;
        salesBoxModel = result.salesBox;
        _loading = false;
      });
    }).catchError((error) {
      print(error.toString());
      _loading = false;
    });

//    HomeModel model = await HomeDao.fetch();
//    setState(() {
//      resultString = json.encode(model);
//    });
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xfff2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: RefreshIndicator(
                    //下拉刷新
                    onRefresh: _handleRefresh,
                    child: NotificationListener(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                        return;
                      },
                      child: _listView,
                    ),
                  )),
              _appBar,
            ],
          ),
        ));
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _bannerView,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
//    return Opacity(
//      opacity: appBarAlpha,
//      child: Container(
//        height: 70,
//        decoration: BoxDecoration(color: Colors.white),
//        alignment: Alignment.center,
//        padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
//        child: Text("首页")
//        ,
//      ),
//    );
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, MediaQueryData.fromWindow(window).padding.top, 0, 0),
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.3
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        //阴影设置
        Container(
          height: appBarAlpha > 0.3 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        ),
      ],
    );
  }

  Widget get _bannerView {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              NavigatorUtil.push(context, WebView(
                  url: model.url,
                  title: model.title,
                  hideAppBar: model.hideAppBar));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(), //指示器
      ),
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT,));
  }


  _jumpToSpeak() {
    NavigatorUtil.push(context, SpeakPage());
  }

  @override
  bool get wantKeepAlive => true;
}
