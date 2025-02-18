import 'package:complete_wallpaper_app/models/wallpaper_model.dart';

abstract class HomeState{}

class HomeInitialState extends HomeState{}
class LoadingState extends HomeState{}
class LoadedState extends HomeState{
  List<PhotosModel> listPhotos;
  LoadedState({required this.listPhotos});
}
class ErrorState extends HomeState{
  String errorMsg;
  ErrorState({required this.errorMsg});
}