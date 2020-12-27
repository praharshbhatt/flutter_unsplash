import 'package:flutter/material.dart';
import 'package:flutter_unsplash/widgets/collections_sheet.dart';
import 'package:flutter_unsplash/widgets/info_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../services/unsplash_image_provider.dart';

/// Screen for showing an individual [UnsplashImage].
class ImagePage extends StatefulWidget {
  final String imageId, imageUrl;

  ImagePage(this.imageId, this.imageUrl, {Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

/// Provide a state for [ImagePage].
class _ImagePageState extends State<ImagePage> {
  /// create global key to show info bottom sheet
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Bottomsheet controller
  PersistentBottomSheetController infoBottomSheetController, collectionsBottomSheetController;

  /// Displayed image.
  UnsplashImage image;

  @override
  void initState() {
    super.initState();
    // load image
    _loadImage();
  }

  /// Reloads the image from unsplash to get extra data, like: exif, location, ...
  _loadImage() async {
    UnsplashImage image = await UnsplashImageProvider.loadImage(widget.imageId);
    setState(() {
      this.image = image;
      // reload bottom sheet if open
      if (infoBottomSheetController != null) _showInfoBottomSheet();

      // reload bottom sheet if open
      if (collectionsBottomSheetController != null) _showCollectionsBottomSheet();
    });
  }

  /// Returns AppBar.
  Widget _buildAppBar() => AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:
            // back button
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          // show image info
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            tooltip: 'Image Info',
            onPressed: () => infoBottomSheetController = _showInfoBottomSheet(),
          ),

          // Add to the user's collection
          IconButton(
            icon: Icon(Icons.collections_bookmark_outlined, color: Colors.white),
            tooltip: 'Add to your Collection',
            onPressed: () => collectionsBottomSheetController = _showCollectionsBottomSheet(),
          ),

          // open in browser icon button
          IconButton(
            icon: Icon(
              Icons.open_in_browser,
              color: Colors.white,
            ),
            tooltip: 'Open in Browser',
            onPressed: () => launch(image?.getHtmlLink()),
          ),
        ],
      );

  /// Returns PhotoView around given [imageId] & [imageUrl].
  Widget _buildPhotoView(String imageId, String imageUrl) => Hero(
        tag: imageId,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          initialScale: PhotoViewComputedScale.covered,
          minScale: PhotoViewComputedScale.covered,
          maxScale: PhotoViewComputedScale.covered,
          loadingBuilder: (BuildContext context, ImageChunkEvent imageChunkEvent) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // set the global key
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhotoView(widget.imageId, widget.imageUrl),
          // wrap in Positioned to not use entire screen
          Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
        ],
      ),
    );
  }

  /// Shows a BottomSheet containing image info.
  PersistentBottomSheetController _showInfoBottomSheet() {
    return _scaffoldKey.currentState.showBottomSheet((context) => InfoSheet(image));
  }

  /// Shows a BottomSheet containing image collections.
  PersistentBottomSheetController _showCollectionsBottomSheet() {
    return _scaffoldKey.currentState.showBottomSheet((context) => CollectionsSheet(collectionsBottomSheetController, image));
  }
}
