import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_unsplash/models/collection/collections.dart';
import 'package:flutter_unsplash/models/models.dart';
import 'package:flutter_unsplash/services/auth.dart';
import 'package:flutter_unsplash/widgets/image_tile.dart';
import 'package:flutter_unsplash/widgets/loading_indicator.dart';
import 'package:parallax_image/parallax_image.dart';

import '../services/unsplash_image_provider.dart';
import 'collection.dart';

/// Screen for showing a collection of photos added by the [User].
class CollectionsScreen extends StatefulWidget {
  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

/// Provide a state for [CollectionsScreen].
class _CollectionsScreenState extends State<CollectionsScreen> {
  final _controller = new ScrollController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Collections",
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: ListView.builder(
          controller: _controller,
          itemCount: userProfile.collections.length,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<UnsplashImage>(
              future: UnsplashImageProvider.loadImage(userProfile.collections.values.elementAt(index).first),
              builder: (BuildContext context, AsyncSnapshot<UnsplashImage> snapshot) {
                if (snapshot.hasData == false) return Center(child: CircularProgressIndicator());

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectionScreen(
                                    userProfile.collections.keys.elementAt(index),
                                    userProfile.collections.values.elementAt(index),
                                  ))),
                      child: ParallaxImage(
                        image: Image.network(
                          snapshot.data.getSmallUrl(),
                          frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
                            return Padding(padding: EdgeInsets.all(8.0), child: child);
                          },
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                    : null,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            );
                          },
                        ).image,
                        extent: 150.0,
                        child: Center(
                          child: Text(
                            userProfile.collections.keys.elementAt(index),
                            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                          ),
                        ),
                        controller: _controller,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
