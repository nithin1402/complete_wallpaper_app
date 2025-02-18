import 'package:complete_wallpaper_app/data/remote/urls.dart';

import '../remote/api_helper.dart';

class WallpaperRepository{
  ApiHelper apiHelper;
  WallpaperRepository({required this.apiHelper});

  Future<dynamic> getTrendingWallpaper() async{

    try {
      return await apiHelper.getApi(url: AppUrls.TRENDING_URL);
    }catch (e){
      throw(e);
    }
  }
}