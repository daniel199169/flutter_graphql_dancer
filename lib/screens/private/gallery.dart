import 'package:flutter/material.dart';
import 'gallery_photo_wrapper.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'package:loader/loader.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/graphql/models/gallery.dart' as model;

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with LoadingMixin<Gallery> {
  List<String> items = List<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.gallery();
    if (r.hasException) {
      print("gallery: error fetching: ${r.exception}");
      return;
    }
    final galleries = List<model.Gallery>.from(r.data["galleries"].map((i) => model.Gallery.fromJson(i)));
    for (var gallery in galleries) {
      for (var image in gallery.images) {
        items.add(image.url);
      }
    }
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final gallery = Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(4.0),
        // childAspectRatio: 8.0 / 9.0,
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, FadeRoute(page: GalleryPhotoWrapper(item: item)));
            },
            child: Card(
              child: Image.network(item, fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );

    final viewMoreButton = Container(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.2,
        0,
        MediaQuery.of(context).size.width * 0.2,
        0,
      ),
      child: MaterialButton(
        onPressed: () => {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'View more',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        color: Colors.white,
        padding: EdgeInsets.all(0),
        elevation: 4,
        height: 30,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
        ),
      ),
    );

    final children = <Widget> [];

    if (loading) {
      children.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("gallery: error loading: $error");
      children.add(Center(child: Text("Error loading images")));
    } else {

    }

    children.add(gallery);
    //children.add(viewMoreButton);

    return ListView(
      children: children,
    );
  }
}
