import 'package:dio/dio.dart';
import 'package:flutter_demo/data/home_banner_data.dart';
import 'package:flutter_demo/data/home_list_data.dart';
import 'package:flutter_demo/http/dio_instance.dart';

class Api {
  static Api instance = Api._();

  Api._();

  // 获取轮播图列表
  Future<List<BannerItemData>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: "/banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    return bannerData.data;
  }

  // 获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList(String pageCount) async {
    Response response =
        await DioInstance.instance().get(path: "/article/list/$pageCount/json");
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  // 获取置顶文章
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response =
        await DioInstance.instance().get(path: "/article/top/json");
    HomeTopListData topData = HomeTopListData.fromJson(response.data);
    return topData.topList;
  }
}
