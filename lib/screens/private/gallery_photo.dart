import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'gallery_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryPhoto extends StatefulWidget {
  final String item;

  GalleryPhoto({this.item});

  @override
  _GalleryPhotoState createState() => _GalleryPhotoState();
}

class _GalleryPhotoState extends State<GalleryPhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        child: CachedNetworkImage(
          imageUrl: widget.item,
          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        /*child: Image.network(
          widget.item,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),*/
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, FadeRoute(page: GalleryWrapper()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.close,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                print("save image here");
              },
              child: Icon(
                Icons.save_alt,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      )
    ]);
  }
}
