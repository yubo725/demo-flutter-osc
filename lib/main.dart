import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/NewsListPage.dart';
import 'pages/TweetsListPage.dart';
import 'pages/DiscoveryPage.dart';
import 'pages/MyInfoPage.dart';
import 'pages/NewsDetailPage.dart';

void main() {
  runApp(new MyApp());
}

// MyApp是一个有状态的组件，因为页面标题，页面标题，页面底部Tab都会改变
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyOSCClientState();
}

class MyOSCClientState extends State<MyApp> {
  // 页面底部当前tab索引值
  int _tabIndex = 0;
  // TabItem的文本默认样式
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  // TabItem被选中时的文本样式
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));

  // 页面底部TabItem上的图标数组
  var tabImages;
  // 页面内容区域
  var _body;
  // 页面顶部的大标题
  var appBarTitles = ['资讯', '动弹', '发现', '我的'];

  Map<String, WidgetBuilder> _routes = new Map();

  // 传入图片路径，返回一个Image组件
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  // 数据初始化，包括TabIcon数据和页面内容数据
  void initData() {
    _routes['newsDetail'] = (BuildContext) {
      return new NewsDetailPage();
    };
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }
    // IndexedStack是一个可以根据index来显示不同内容的组件，可以实现点击TabItem切换页面的功能
    _body = new IndexedStack(
      children: <Widget>[
        new NewsListPage(),
        new TweetsListPage(),
        new DiscoveryPage(),
        new MyInfoPage()
      ],
      index: _tabIndex,
    );
  }

  // 根据索引值确定Tab是选中状态的样式还是非选中状态的样式
  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  // 根据索引值确定TabItem的icon是选中还是非选中
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  // 根据索引值返回页面顶部标题
  Text getTabTitle(int curIndex) {
    return new Text(
      appBarTitles[curIndex],
      style: getTabTextStyle(curIndex)
    );
  }

  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = new List();
    for (int i = 0; i < 4; i++) {
      list.add(new BottomNavigationBarItem(
        icon: getTabIcon(i),
        title: getTabTitle(i)
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      theme: new ThemeData(
        // 设置页面的主题色
        primaryColor: const Color(0xFF63CA6C)
      ),
      routes: _routes,
      home: new Scaffold(
        appBar: new AppBar(
          // 设置AppBar标题
          title: new Text(appBarTitles[_tabIndex],
          // 设置AppBar上文本的样式
          style: new TextStyle(color: Colors.white)),
          // 设置AppBar上图标的样式
          iconTheme: new IconThemeData(color: Colors.white)
        ),
        body: _body,
        // bottomNavigationBar属性为页面底部添加导航的Tab，CupertinoTabBar是Flutter提供的一个iOS风格的底部导航栏组件
        bottomNavigationBar: new CupertinoTabBar(
          items: getBottomNavItems(),
          currentIndex: _tabIndex,
          onTap: (index) {
            // 底部TabItem的点击事件处理，点击时改变当前选择的Tab的索引值，则页面会自动刷新
            setState((){
              _tabIndex = index;
            });
          },
        ),
        // drawer属性用于为当前页面添加一个侧滑菜单
        drawer: new Drawer(
          child: new Center(
            child: new Text("this is a drawer")
          ),
        ),
      ),
    );
  }
}

