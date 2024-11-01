import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  const WebViewPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String? name;

  // 生命周期 build执行之前会执行
  @override
  void initState() {
    super.initState();

    // build 执行之后会执行的回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 获取路由参数
      var map = ModalRoute.of(context)?.settings.arguments;
      if (map is Map) {
        name = map['name'];
        // 刷新页面
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(name ?? "")),
        body: SafeArea(
            child: Container(
                child: InkWell(
                    onTap: () {
                      // 销毁
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 200.w, height: 200.h, child: Text("返回"))))));
  }
}
