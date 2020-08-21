class GalleryFile {
  final int id;
  final String url;

  GalleryFile.fromJson(Map<String, dynamic> json)
    : id = json['id']
    , url = json['url']
  ;

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
  };
}

class Gallery {
  final int id;
  final String name;
  final List<GalleryFile> images;

  Gallery.fromJson(Map<String, dynamic> json)
    : id = json['id']
    , name = json['name']
    , images = List<GalleryFile>.from(json["images"].map((i) => GalleryFile.fromJson(i)))
  ;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'images': images,
  };
}
