import 'package:complete_wallpaper_app/models/wallpaper_model.dart';
import 'package:complete_wallpaper_app/screens/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/wallpaper_repository.dart';

class HomeCubit extends Cubit<HomeState>{

  WallpaperRepository wallPaperRepository;
  HomeCubit({required this.wallPaperRepository}) : super(HomeInitialState());


  void getTrendingWallpaper() async{
    emit(LoadingState());
    
    try{
      var data = await wallPaperRepository.getTrendingWallpaper();
      var wallpaperModel = WallpaperModel.fromJson(data);
      emit(LoadedState(listPhotos: wallpaperModel.photos));
    }catch (e){
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

}