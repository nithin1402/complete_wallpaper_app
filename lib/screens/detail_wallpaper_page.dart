
import 'package:complete_wallpaper_app/models/wallpaper_model.dart';
import 'package:complete_wallpaper_app/utils/util_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

class DetailWallpaperPage extends StatelessWidget {
  SrcModel imgModel;
  DetailWallpaperPage({required this.imgModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
          height: double.infinity,
            width: double.infinity,
            child: Image.network(imgModel.portrait,fit: BoxFit.cover,)),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getActionBtn(onTap: (){

                    }, title: "Info", icon: Icons.info_outline),
                    SizedBox(width: 25,),
                    getActionBtn(onTap:(){
                      saveWallpaper(context);
                    }, title: "Save", icon: Icons.download),
                    SizedBox(width: 25,),
                    getActionBtn(onTap: (){
    applyWallpaper(context);
    }
                      , title: "Apply", icon:
                     Icons.format_paint,bgColor: Colors.blueAccent)
                  ],
                ),
              ),
            ),
          )

      ]
      ),
    );
  }

  Widget getActionBtn({required VoidCallback onTap, required String title, required IconData icon, Color? bgColor}){
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color:bgColor!=null ? Colors.blueAccent : Colors.white.withOpacity(0.4)
            ),
            child: Center(
              child: Icon(icon,color: Colors.white,size: 28,),
            ),
          ),
        ),
        SizedBox(height: 1,),
        Text(title,style: mTextStyle12(mColor: Colors.white,),)
      ],
    );
  }

  void saveWallpaper(BuildContext context) {
    GallerySaver.saveImage(imgModel.portrait).then((value)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wallpaper saved onto Gallery!!"))));
  }

  void applyWallpaper(BuildContext context) {
    Wallpaper.imageDownloadProgress(imgModel.portrait!).listen((event){
      print(event);
    },onDone: () {
      Wallpaper.homeScreen(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        options: RequestSizeOptions.resizeFit
      ).then((value){
        print(value);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wallpaper set on Home Screen!!")));
      });
    },onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download ERROr: $e, Error while setting the wallpaper!!")));
    }

    );
  }

}
