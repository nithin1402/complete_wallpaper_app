import 'package:complete_wallpaper_app/data/remote/urls.dart';

import '../remote/api_helper.dart';

class WallpaperRepository{
  ApiHelper apiHelper;
  WallpaperRepository({required this.apiHelper});

  //search
  Future<dynamic> getSearchWallpaper(String mQuery,{String mColor = "",int mPage=1}) async{

    try {
      return await apiHelper.getApi(url: "${AppUrls.SEARCH_URL}?query=$mQuery&color=$mColor&page=$mPage");
    }catch (e){
      throw(e);
    }
  }

  //trending
  Future<dynamic> getTrendingWallpaper() async{

    try {
      return await apiHelper.getApi(url: AppUrls.TRENDING_URL);
    }catch (e){
      throw(e);
    }
  }
}