import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/web_view_page.dart';
import 'package:flutter_demo/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            child: Swiper(
              indicatorLayout: PageIndicatorLayout.NONE,
              autoplay: true,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 150.h,
                  color: Colors.lightBlue,
                );
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return _listItemView();
            },
            itemCount: 100,
          ))
        ],
      )),
    );
  }

  Widget _listItemView() {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutePath.webViewPage);
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return WebViewPage(title: "首页跳转来的");
          // }));
        },
        child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
            padding: EdgeInsets.only(
                top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5.r),
                borderRadius: BorderRadius.all(Radius.circular(6.r))),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.h),
                        child: Image.network(
                          "https://wx4.sinaimg.cn/mw690/006rUba1gy1hrcdrha7v3j30j60pkacf.jpg",
                          width: 30.r,
                          height: 30.r,
                          fit: BoxFit.fill,
                        )),
                    const Text(
                      "作者",
                      style: TextStyle(color: Colors.black),
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: const Text(
                          "2024-10-28 15:01:00",
                          style: TextStyle(color: Colors.black),
                        )),
                    const Text(
                      "置顶",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "标题标题标题标题标题标题标题标题标题标题标题标题标题标题",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
                Row(
                  children: [
                    Text(
                      "分类",
                      style: TextStyle(color: Colors.green, fontSize: 12.sp),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      "assets/images/equipment2.png",
                      width: 20.w,
                      height: 20.w,
                    ),
                  ],
                )
              ],
            )));
  }
}
