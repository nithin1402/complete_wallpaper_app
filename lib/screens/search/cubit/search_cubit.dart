import 'package:complete_wallpaper_app/models/wallpaper_model.dart';
import 'package:complete_wallpaper_app/screens/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/wallpaper_repository.dart';

class SearchCubit extends Cubit<SearchState>{
  WallpaperRepository wallpaperRepository;
  SearchCubit({required this.wallpaperRepository}) : super(SearchInitialState());

  void getSearchWallpaper({required String query,String color = ""}) async{
    emit(SearchLoadingState());

    try{
     var mData = await wallpaperRepository.getSearchWallpaper(query,mColor: color);
     WallpaperModel wallpaperModel =  WallpaperModel.fromJson(mData);
     emit(SearchLoadedState(listPhotos: wallpaperModel.photos!,totalWallpapers: wallpaperModel.total_results!));
    }catch (e){
      emit(SearchErrorState(errorMsg: e.toString()));
    }
  }

}