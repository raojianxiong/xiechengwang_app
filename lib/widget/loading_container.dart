
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//加载进度条
class LoadingContainer extends StatelessWidget{
  final Widget child;
  final bool isLoading;
  final bool cover;//是否放在顶层

  const LoadingContainer({Key key,@required this.child, @required this.isLoading, this.cover = false}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !cover ? !isLoading ?child : _loadingView : Stack(
      children: <Widget>[
        child,
        isLoading ?_loadingView : null,
      ],
    );
  }

  Widget  get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}