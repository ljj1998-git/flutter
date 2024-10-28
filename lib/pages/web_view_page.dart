import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
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
