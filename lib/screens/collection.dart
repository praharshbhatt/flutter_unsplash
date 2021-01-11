import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_unsplash/models/collection/collections.dart';
import 'package:flutter_unsplash/models/models.dart';
import 'package:flutter_unsplash/widgets/image_tile.dart';
import 'package:flutter_unsplash/widgets/loading_indicator.dart';

import '../services/unsplash_image_provider.dart';

/// Screen for showing a collection of photos added by the [User].
class CollectionScreen extends StatefulWidget {
  final String title;
  final List<String> lstCollection;

  CollectionScreen(this.title, this.lstCollection);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

/// Provide a state for [CollectionScreen].
class _CollectionScreenState extends State<CollectionScreen> {
  /// Stores the currently loaded loaded images.
  List<UnsplashImage> images = [];

  /// States whether there is currently a task running loading images.
  bool loadingImages = false;

  /// Stored the currently searched keyword.
  //String keyword;
  @override
  initState() {
    super.initState();
    // initial image Request
    _loadImages();
  }

  /// Requests a list of [UnsplashImage].
  _loadImages() async {
    // check if there is currently a loading task running
    if (loadingImages) {
      // there is currently a task running
      return;
    }

    // set loading state
    // delay setState, otherwise: Unhandled Exception: setState() or markNeedsBuild() called during build.
    await Future.delayed(Duration(microseconds: 1));
    setState(() {
      // set loading
      loadingImages = true;
    });

    //Add all the images
    await Future.forEach(widget.lstCollection, (imageID) async {
      images.add(await UnsplashImageProvider.loadImage(imageID));
    });

    // update the state
    setState(() {
      // done loading
      loadingImages = false;
      images = images.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[50],
        body: OrientationBuilder(
          builder: (context, orientation) => CustomScrollView(
            // put AppBar in NestedScrollView to have it sliver off on scrolling
            slivers: <Widget>[
              //App bar
              SliverAppBar(
                //Appbar Title
                title: Text(widget.title, style: TextStyle(color: Colors.black87)),

                //Color
                backgroundColor: Colors.grey[50],

                leading: IconButton(
                  icon: Icon(Platform.isIOS ? Icons.arrow_back_ios: Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1.color),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              //Grid view with all the images
              _buildImageGrid(orientation: orientation),

              // loading indicator at the bottom of the list
              loadingImages ? SliverToBoxAdapter(child: LoadingIndicator(Colors.grey[400])) : null,

              // filter null views
            ].where((w) => w != null).toList(),
          ),
        ),
      );

  /// Returns a StaggeredTile for a given [image].
  StaggeredTile _buildStaggeredTile(UnsplashImage image, int columnCount) {
    // calc image aspect ration
    double aspectRatio = image.getHeight().toDouble() / image.getWidth().toDouble();
    // calc columnWidth
    double columnWidth = MediaQuery.of(context).size.width / columnCount;
    // not using [StaggeredTile.fit(1)] because during loading StaggeredGrid is really jumpy.
    return StaggeredTile.extent(1, aspectRatio * columnWidth);
  }

  /// Returns the grid that displays images.
  /// [orientation] can be used to adjust the grid column count.
  Widget _buildImageGrid({orientation = Orientation.portrait}) {
    // calc columnCount based on orientation
    int columnCount = orientation == Orientation.portrait ? 2 : 3;
    // return staggered grid
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverStaggeredGrid.countBuilder(
        // set column count
        crossAxisCount: columnCount,
        itemCount: images.length,
        // set itemBuilder
        itemBuilder: (BuildContext context, int index) => _buildImageItemBuilder(index),
        staggeredTileBuilder: (int index) => _buildStaggeredTile(images[index], columnCount),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
    );
  }

  /// Returns a FutureBuilder to load a [UnsplashImage] for a given [index].
  Widget _buildImageItemBuilder(int index) =>
      FutureBuilder(future: _loadImage(index), builder: (context, snapshot) => ImageTile(snapshot.data));

  /// Asynchronously loads a [UnsplashImage] for a given [index].
  Future<UnsplashImage> _loadImage(int index) async => index < images.length ? images[index] : null;
}
