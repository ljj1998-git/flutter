import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/data/home_banner_data.dart';
import 'package:flutter_demo/data/home_list_data.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/http/dio_instance.dart';

class HomeViewModel with ChangeNotifier {
  int pageCount = 0;
  List<BannerItemData>? bannerList;
  List<HomeListItemData>? listData = [];

  // 获取首页轮播图
  Future getBanner() async {
    List<BannerItemData>? list = await Api.instance.getBanner();
    bannerList = list ?? [];
    notifyListeners();
  }

  Future initListData(bool loadMore, {ValueChanged<bool>? callback}) async {
    if (loadMore) {
      pageCount++;
    } else {
      pageCount = 0;
      await getTopList();
    }
    await getHomeList(loadMore);
    notifyListeners();

    // 回调出去
    callback?.call(loadMore);
  }

  // 获取首页文章列表
  Future getHomeList(bool loadMore) async {
    List<HomeListItemData>? list = await Api.instance.getHomeList("$pageCount");

    if (list != null && list.isNotEmpty) {
      listData?.addAll(list);
    } else {
      if (loadMore && pageCount > 0) {
        pageCount--; // 下一页没有数据，恢复页码
      }
    }
  }

  // 获取置顶文章
  Future getTopList() async {
    List<HomeListItemData>? list = await Api.instance.getHomeTopList();
    listData?.clear();
    listData?.addAll(list ?? []);
  }
}
