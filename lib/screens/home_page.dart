import 'package:complete_wallpaper_app/app_widgets/wallpaper_bg_widget.dart';
import 'package:complete_wallpaper_app/constants/app_constantss.dart';
import 'package:complete_wallpaper_app/data/remote/api_helper.dart';
import 'package:complete_wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:complete_wallpaper_app/screens/detail_wallpaper_page.dart';
import 'package:complete_wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:complete_wallpaper_app/screens/home/cubit/home_state.dart';
import 'package:complete_wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:complete_wallpaper_app/screens/search/searched_wallpaper_page.dart';
import 'package:complete_wallpaper_app/utils/util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getTrendingWallpaper();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                  style: mTextStyle12(),
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        if(searchController.text.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>SearchCubit(wallpaperRepository: WallpaperRepository(apiHelper: ApiHelper())),
                            child: SearchedWallpaperPage(query: searchController.text,),)));
                        }
                      },
                        child: Icon(Icons.search,color: Colors.grey.shade300,)),
                    filled: true,
                    hintText: "Find Wallpaper..",
                    hintStyle: mTextStyle12(mColor: Colors.grey.shade400),
                    fillColor: AppColors.secondaryLightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.transparent
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.transparent
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.transparent
                        )
                    ),
                  ),
              ),
            ),
            SizedBox(height: 11,),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 16),
              child: Text("Best of Month",style: mTextStyle16(mFontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 7,),
            SizedBox(
              height: 200,
              child:BlocBuilder<HomeCubit,HomeState>(
                builder: (_,state){
                  if(state is LoadingState){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is ErrorState){
                    return Center(
                      child: Text("${state.errorMsg}"),
                    );
                  }else if(state is LoadedState){
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.listPhotos.length,
                        itemBuilder: (_,index){
                          var eachPhoto = state.listPhotos[index];
                          return Padding(
                            padding: EdgeInsets.only( left: 11,right: index==state.listPhotos.length-1 ? 11 : 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWallpaperPage(imgModel: eachPhoto.src,)));
                              },
                                child: WallpaperBgWidget(imgUrl: eachPhoto.src!.portrait)),
                          );
                        });
                  }
                  return Container();
                },
              )
            ),



            SizedBox(height: 11,),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 16),
              child: Text("Color Tone",style: mTextStyle16(mFontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 7,),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppConstantss.mColors.length,
                  itemBuilder: (_,index){
                    return Padding(
                      padding: EdgeInsets.only( left: 11,right: index==AppConstantss.mColors.length-1 ? 11 : 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>SearchCubit(wallpaperRepository: WallpaperRepository(apiHelper: ApiHelper())),
                            child: SearchedWallpaperPage(
                              query: searchController.text.isNotEmpty ? searchController.text : "Space",
                              color : AppConstantss.mColors[index]["code"],
                            ),
                          )));
                        },
                          child: getColorToneWidget(AppConstantss.mColors[index]["color"]))
                    );
                  }),
            ),




            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16),
              child: Text("Category",style: mTextStyle16(mFontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 7,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: 9/5
                ),
                  itemCount: AppConstantss.mCategories.length,
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>SearchCubit(wallpaperRepository: WallpaperRepository(apiHelper: ApiHelper())),
                          child: SearchedWallpaperPage(query: AppConstantss.mCategories[index]["title"]),
                        )
                        )
                        );
                      },
                      child: getCategoryWidget(
                          AppConstantss.mCategories[index]["image"],
                          AppConstantss.mCategories[index]["title"]),
                    );
                  }),
            ),
          ],
        )
      ),
    );
  }

  Widget getColorToneWidget(Color mcolor){
    return Container(
      width: 50,
        height: 50,
      decoration: BoxDecoration(
        color: mcolor,
        borderRadius: BorderRadius.circular(11)
      ),

    );
  }

  Widget getCategoryWidget(String imgUrl, String title){
    return Container(
      width: 200,
      height: 100,
      child: Center(
        child: Text(title, style: mTextStyle16(mColor: Colors.white),),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        image: DecorationImage(
          image: NetworkImage(imgUrl),fit: BoxFit.fill
        )
      ),
    );
  }
}
