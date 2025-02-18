class SrcModel{

  String landscape;
  String large;
  String large2x;
  String medium;
  String original;
  String portrait;
  String small;
  String tiny;

  SrcModel({required this.landscape,required this.large,required this.large2x,required this.medium,required this.original,required this.portrait,required this.small,required this.tiny});

  factory SrcModel.fromJson(Map<String,dynamic> json){
    return SrcModel(
        landscape: json["landscape"],
        large: json["large"],
        large2x: json["large2x"],
        medium: json["medium"],
        original: json["original"],
        portrait: json["portrait"],
        small: json["small"],
        tiny: json["tiny"]);
  }

}

class PhotosModel{

  String alt;
  String avg_color;
  num height;
  num id;
  bool liked;
  String photographer;
  num photographer_id;
  String photographer_url;
  String url;
  num width;

  SrcModel src;

  PhotosModel({required this.alt,required this.avg_color,required this.height,required this.id,required this.liked,required this.photographer,required this.photographer_id,required this.photographer_url,required this.url,required this.width,required this.src});

  factory PhotosModel.fromJson(Map<String,dynamic> json){
    return PhotosModel(
        alt: json["alt"],
        avg_color: json["avg_color"],
        height:json["height"] ,
        id: json["id"],
        liked: json["liked"],
        photographer: json["photographer"],
        photographer_id:json["photographer_id"] ,
        photographer_url: json["photographer_url"],
        url: json["url"],
        width: json["width"],
        src: SrcModel.fromJson(json["src"]));
  }

}

class WallpaperModel{

  String next_page;
  int page;
  int per_page;
  int total_results;
  List<PhotosModel> photos;

  WallpaperModel({required this.next_page,required this.page,required this.per_page,required this.total_results,required this.photos});

  factory WallpaperModel.fromJson(Map<String,dynamic> json){

    List<PhotosModel> mPhotos = [];

    for(Map<String,dynamic> eachPhoto in json["photos"]){
      mPhotos.add(PhotosModel.fromJson(eachPhoto));
    }

    return WallpaperModel(
        next_page: json["next_page"],
        page: json["page"],
        per_page: json["per_page"],
        total_results: json["total_results"],
        photos: mPhotos);

  }

}