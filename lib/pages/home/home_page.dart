import 'package:flutter/material.dart';
import 'package:flutter_demo/data/home_list_data.dart';
import 'package:flutter_demo/pages/home/home_vm.dart';
import 'package:flutter_demo/route/route_utils.dart';
import 'package:flutter_demo/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    viewModel.getBanner();
    viewModel.initListData(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) {
          return viewModel;
        },
        child: Scaffold(
          body: SafeArea(
              child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  header: ClassicHeader(),
                  footer: ClassicFooter(),
                  onLoading: () => {
                        // 上拉刷新回调
                        viewModel.initListData(true, callback: (loadMore) {
                          refreshController.loadComplete();
                        })
                      },
                  onRefresh: () => {
                        // 下拉刷新回调
                        viewModel.getBanner().then((value) => {
                              viewModel.initListData(false,
                                  callback: (loadMore) {
                                refreshController.refreshCompleted();
                              })
                            })
                      },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [_banner(), _homeListView()],
                    ),
                  ))),
        ));
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Swiper(
          indicatorLayout: PageIndicatorLayout.NONE,
          autoplay: true,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
          itemCount: vm.bannerList?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              height: 150.h,
              color: Colors.lightBlue,
              child: Image.network(
                vm.bannerList?[index].imagePath ?? "",
                fit: BoxFit.fill,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _listItemView(vm.listData?[index]);
        },
        itemCount: vm.listData?.length ?? 0,
      );
    });
  }

  Widget _listItemView(HomeListItemData? item) {
    var name;
    if (item?.author?.isNotEmpty == true) {
      name = item?.author ?? "";
    } else {
      name = item?.shareUser ?? "";
    }

    return GestureDetector(
        onTap: () {
          RouteUtils.pushForNamed(context, RoutePath.webViewPage,
              arguments: {"name": "使用路由传值"});
          // 路由跳转 name
          // Navigator.pushNamed(context, RoutePath.webViewPage);
          // 路由跳转
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      name,
                      style: TextStyle(color: Colors.black),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          item?.niceShareDate ?? "",
                          style: TextStyle(color: Colors.black),
                        )),
                    Text(
                      "置顶",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  item?.title ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      item?.chapterName ?? "",
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
