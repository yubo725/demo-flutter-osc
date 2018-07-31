import 'package:flutter/material.dart';

// 动弹列表页面
class TweetsListPage extends StatelessWidget {

  // 热门动弹数据
  List hotTweetsList = [];
  // 普通动弹数据
  List normalTweetsList = [];
  // 动弹作者文本样式
  TextStyle authorTextStyle;
  // 动弹时间文本样式
  TextStyle subtitleStyle;
  // 屏幕宽度
  double screenWidth;

  // 构造方法中做数据初始化
  TweetsListPage() {
    authorTextStyle = new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
    subtitleStyle = new TextStyle(fontSize: 12.0, color: const Color(0xFFB5BDC0));
    // 添加测试数据
    for (int i = 0; i < 20; i++) {
      Map<String, dynamic> map = new Map();
      // 动弹发布时间
      map['pubDate'] = '2018-7-30';
      // 动弹文字内容
      map['body'] = '早上七点十分起床，四十出门，花二十多分钟到公司，必须在八点半之前打卡；下午一点上班到六点，然后加班两个小时；八点左右离开公司，呼呼登自行车到健身房锻炼一个多小时。到家已经十点多，然后准备第二天的午饭，接着收拾厨房，然后洗澡，吹头发，等能坐下来吹头发时已经快十二点了。感觉很累。';
      // 动弹作者昵称
      map['author'] = '红薯';
      // 动弹评论数
      map['commentCount'] = 10;
      // 动弹作者头像URL
      map['portrait'] = 'https://static.oschina.net/uploads/user/0/12_50.jpg?t=1421200584000';
      // 动弹中的图片，多张图片用英文逗号隔开
      map['imgSmall'] = 'https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg';
      hotTweetsList.add(map);
      normalTweetsList.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    screenWidth = MediaQuery.of(context).size.width;
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new TabBar(
          tabs: <Widget>[
            new Tab(text: "动弹列表"),
            new Tab(text: "热门动弹")
          ],
        ),
        body: new TabBarView(
          children: <Widget>[getNormalListView(), getHotListView()],
        )),
    );
  }

  // 获取普通动弹列表
  Widget getNormalListView() {
    return new ListView.builder(
      itemCount: normalTweetsList.length * 2 - 1,
      itemBuilder: (context, i) => renderNormalRow(i)
    );
  }

  // 获取热门动弹列表
  Widget getHotListView() {
    return new ListView.builder(
      itemCount: hotTweetsList.length * 2 - 1,
      itemBuilder: (context, i) => renderHotRow(i),
    );
  }

  // 渲染普通动弹列表Item
  renderHotRow(i) {
    if (i.isOdd) {
      return new Divider(
        height: 1.0,
      );
    } else {
      i = i ~/ 2;
      return getRowWidget(hotTweetsList[i]);
    }
  }

  // 渲染热门动弹列表Item
  renderNormalRow(i) {
    if (i.isOdd) {
      return new Divider(
        height: 1.0,
      );
    } else {
      i = i ~/ 2;
      return getRowWidget(normalTweetsList[i]);
    }
  }

  // 渲染动弹列表的一行，普通动弹和热门动弹的一行是一样的格式，只是数据不同
  Widget getRowWidget(Map<String, dynamic> listItem) {
    // 列表item的第一行，显示动弹作者头像、昵称、发布时间
    var authorRow = new Row(
      children: <Widget>[
        // 用户头像
        new Container(
          width: 35.0,
          height: 35.0,
          decoration: new BoxDecoration(
            // 头像显示为圆形
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: new DecorationImage(
              image: new NetworkImage(listItem['portrait']),
              fit: BoxFit.cover),
            // 头像边框
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        // 动弹作者的昵称
        new Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
          child: new Text(
            listItem['author'],
            style: new TextStyle(fontSize: 16.0)
          )
        ),
        // 动弹发布时间，显示在最右边
        new Expanded(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(
                '${listItem['commentCount']}',
                style: subtitleStyle,
              ),
              new Image.asset(
                './images/ic_comment.png',
                width: 16.0,
                height: 16.0,
              )
            ],
          ),
        )
      ],
    );
    // 动弹内容，纯文本展示
    var _body = listItem['body'];
    var contentRow = new Row(
      children: <Widget>[
        new Expanded(child: new Text(_body))
      ],
    );
    var timeRow = new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Text(
          listItem['pubDate'],
          style: subtitleStyle,
        )
      ],
    );
    var columns = <Widget>[
      new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 2.0),
        child: authorRow,
      ),
      new Padding(
        padding: const EdgeInsets.fromLTRB(52.0, 0.0, 10.0, 0.0),
        child: contentRow,
      ),
    ];
    // 动弹中的图片数据，字符串，多张图片以英文逗号分隔
    String imgSmall = listItem['imgSmall'];
    if (imgSmall != null && imgSmall.length > 0) {
      // 动弹中有图片
      List<String> list = imgSmall.split(",");
      List<String> imgUrlList = new List<String>();
      // 开源中国的openapi给出的图片，有可能是相对地址，所以用下面的代码将相对地址补全
      for (String s in list) {
        if (s.startsWith("http")) {
          imgUrlList.add(s);
        } else {
          imgUrlList.add("https://static.oschina.net/uploads/space/" + s);
        }
      }
      List<Widget> imgList = [];
      List<List<Widget>> rows = [];
      num len = imgUrlList.length;
      // 通过双重for循环，生成每一张图片组件
      for (var row = 0; row < getRow(len); row++) { // row表示九宫格的行数，可能有1行2行或3行
        List<Widget> rowArr = [];
        for (var col = 0; col < 3; col++) { // col为列数，固定有3列
          num index = row * 3 + col;
          double cellWidth = (screenWidth - 100) / 3;
          if (index < len) {
            rowArr.add(new Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Image.network(imgUrlList[index],
                  width: cellWidth, height: cellWidth),
            ));
          }
        }
        rows.add(rowArr);
      }
      for (var row in rows) {
        imgList.add(new Row(
          children: row,
        ));
      }
      columns.add(new Padding(
        padding: const EdgeInsets.fromLTRB(52.0, 5.0, 10.0, 0.0),
        child: new Column(
          children: imgList,
        ),
      ));
    }
    columns.add(new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 6.0),
      child: timeRow,
    ));
    return new InkWell(
      child: new Column(
        children: columns,
      ),
      onTap: () {
        // 跳转到动弹详情
      }
    );
  }

  // 获取行数，n表示图片的张数
  int getRow(int n) {
    int a = n % 3;
    int b = n ~/ 3;
    if (a != 0) {
      return b + 1;
    }
    return b;
  }
}