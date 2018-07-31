import 'package:flutter/material.dart';

// 发现 页面
class DiscoveryPage extends StatelessWidget {

  // 标记一个长条分割线（区域开始的那条分割线）
  static const String TAG_START = "startDivider";
  // 标记一个长条分割线（区域结束的那条分割线）
  static const String TAG_END = "endDivider";
  // 标记一个短的分割线
  static const String TAG_CENTER = "centerDivider";
  // 标记两条长分割线中间的空白区域
  static const String TAG_BLANK = "blankDivider";

  // 菜单图标的大小
  static const double IMAGE_ICON_WIDTH = 30.0;
  // 菜单后面箭头的大小
  static const double ARROW_ICON_WIDTH = 16.0;

  // 菜单图片资源
  final imagePaths = [
    "images/ic_discover_softwares.png",
    "images/ic_discover_git.png",
    "images/ic_discover_gist.png",
    "images/ic_discover_scan.png",
    "images/ic_discover_shake.png",
    "images/ic_discover_nearby.png",
    "images/ic_discover_pos.png",
  ];
  // 菜单文本
  final titles = [
    "开源软件", "码云推荐", "代码片段", "扫一扫", "摇一摇", "码云封面人物", "线下活动"
  ];
  // 菜单右箭头
  final rightArrowIcon = new Image.asset('images/ic_arrow_right.png', width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH,);
  // 菜单文本样式
  final titleTextStyle = new TextStyle(fontSize: 16.0);
  // 列表数据，这里的数组中装的可以是字符串，也可以是ListItem对象
  List listData = [];

  DiscoveryPage() {
    initData();
  }

  initData() {
    // 菜单块的开始
    listData.add(TAG_START);
    for (int i = 0; i < 3; i++) {
      // 菜单
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 2) {
        // 末尾分割线
        listData.add(TAG_END);
      } else {
        // 中间分割线
        listData.add(TAG_CENTER);
      }
    }
    // 空白分割线
    listData.add(TAG_BLANK);
    // 菜单块的开始
    listData.add(TAG_START);
    for (int i = 3; i < 5; i++) {
      // 菜单
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 4) {
        // 末尾分割线
        listData.add(TAG_END);
      } else {
        // 中间分割线
        listData.add(TAG_CENTER);
      }
    }
    // 空白分割线
    listData.add(TAG_BLANK);
    // 菜单块的开始
    listData.add(TAG_START);
    for (int i = 5; i < 7; i++) {
      // 菜单
      listData.add(new ListItem(title: titles[i], icon: imagePaths[i]));
      if (i == 6) {
        // 末尾分割线
        listData.add(TAG_END);
      } else {
        // 中间分割线
        listData.add(TAG_CENTER);
      }
    }
  }

  Widget getIconImage(path) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: new Image.asset(path, width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH),
    );
  }

  renderRow(BuildContext ctx, int i) {
    var item = listData[i];
    if (item is String) {
      switch (item) {
        case TAG_START:
          // 分割线（开始）
          return new Divider(height: 1.0,);
          break;
        case TAG_END:
          // 分割线（结束）
          return new Divider(height: 1.0,);
          break;
          // 分割线（中间）
        case TAG_CENTER:
          return new Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: new Divider(height: 1.0,),
          );
          break;
          // 空白区域（上一个分割线结束和下一个分割线开始中间的部分）
        case TAG_BLANK:
          return new Container(
            height: 20.0,
          );
          break;
      }
    } else if (item is ListItem) {
      // 菜单项
      var listItemContent =  new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            getIconImage(item.icon),
            new Expanded(
                child: new Text(item.title, style: titleTextStyle,)
            ),
            rightArrowIcon
          ],
        ),
      );
      return new InkWell(
        onTap: () {
        },
        child: listItemContent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => renderRow(context, i),
      ),
    );
  }
}

// 菜单项的数据封装
class ListItem {
  String icon;
  String title;
  ListItem({this.icon, this.title});
}