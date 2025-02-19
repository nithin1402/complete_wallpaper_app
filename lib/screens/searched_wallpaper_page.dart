import 'package:complete_wallpaper_app/app_widgets/wallpaper_bg_widget.dart';
import 'package:complete_wallpaper_app/screens/home/cubit/home_state.dart';
import 'package:complete_wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:complete_wallpaper_app/screens/search/cubit/search_state.dart';
import 'package:complete_wallpaper_app/utils/util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_constantss.dart';

class SearchedWallpaperPage extends StatefulWidget {

  String query;
  String color;
  SearchedWallpaperPage({required this.query,this.color = ""});

  @override
  State<SearchedWallpaperPage> createState() => _SearchedWallpaperPageState();
}

class _SearchedWallpaperPageState extends State<SearchedWallpaperPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SearchCubit>(context).getSearchWallpaper(query: widget.query,color: widget.color);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: BlocBuilder<SearchCubit,SearchState>(
        builder: (_,state){
          if(state is SearchLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is SearchErrorState){
            return Center(
              child: Text(state.errorMsg,),
            );
          }else if(state is SearchLoadedState){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(widget.query,style: mTextStyle34(mFontWeight: FontWeight.w900),),
                  Text("${state.totalWallpapers} wallpaper available",style: mTextStyle14(),),
                  SizedBox(
                    height: 21,
                  ),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11,
                            childAspectRatio: 3/4
                        ),
                        itemCount:state.listPhotos.length,
                        itemBuilder: (_,index){
                          var eachPhotos =state.listPhotos[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: index==state.listPhotos.length-1 ? 11.0 : 0),
                            child: WallpaperBgWidget(imgUrl: eachPhotos.src.portrait),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        return Container();
      },)
    );
  }
}
