import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:flutter_demo/pages/web_view_page.dart';

// 路由管理
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(
            WebViewPage(
              title: "首页跳转来的",
            ),
            settings: settings);
    }
    //
    return pageRoute(Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("路由路径错误"),
      )),
    ));
  }

  static MaterialPageRoute pageRoute(Widget widget,
      {RouteSettings? settings,
      bool? maintainState,
      bool? fullscreenDialog,
      bool? allowSnapshotting}) {
    return MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

// 路由地址
class RoutePath {
  // 首页
  static const String tab = '/';

  // 网页页面
  static const String webViewPage = '/web_view_page';
}
