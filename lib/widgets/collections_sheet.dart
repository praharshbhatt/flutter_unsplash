import 'package:flutter/material.dart';
import 'package:flutter_unsplash/models/location.dart';
import 'package:flutter_unsplash/services/auth.dart';
import 'package:flutter_unsplash/services/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import 'loading_indicator.dart';

/// Bottom-sheet displaying collections to add to a given [image].
class CollectionsSheet extends StatelessWidget {
  // Bottomsheet controller
  PersistentBottomSheetController collectionsBottomSheetController;

  final UnsplashImage image;

  CollectionsSheet(this.collectionsBottomSheetController, this.image);

  @override
  Widget build(BuildContext context) => /*Container*/ Card(
        margin: const EdgeInsets.only(top: 16.0),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: image != null
                ? <Widget>[
                    //Title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Add this image to your collections',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Spacer(),

                          //Close icon button
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => collectionsBottomSheetController.close(),
                          ),
                        ],
                      ),
                    ),

                    //List of all collections
                    userProfile.collections.length == 0
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No collections added yet."),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: userProfile.collections.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(userProfile.collections.keys.elementAt(index)),
                                trailing:
                                    Icon(userProfile.collections.values.elementAt(index).contains(image.getId()) ? Icons.done : Icons.add),
                                onTap: () async {
                                  if (userProfile.collections.values.elementAt(index).contains(image.getId())) {
                                    //If already added
                                    //Remove from the current collection
                                    List lstCollection = userProfile.collections.values.elementAt(index);
                                    lstCollection.remove(image.getId());
                                    userProfile.collections[userProfile.collections.keys.elementAt(index)] = lstCollection;
                                  } else {
                                    //Not already added
                                    //Add this image id to this collection
                                    List lstCollection = userProfile.collections.values.elementAt(index);
                                    lstCollection.add(image.getId());
                                    userProfile.collections[userProfile.collections.keys.elementAt(index)] = lstCollection;
                                  }

                                  //update the database
                                  await FirestoreService.setUserData();

                                  //Close the bottomsheet
                                  collectionsBottomSheetController.close();
                                },
                              );
                            },
                          ),

                    //Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //New collection button
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: RaisedButton(
                            child: Row(
                              children: [
                                //Add new collection
                                Icon(Icons.add, color: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text("New collection", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              String strCollectionName = await _displayDialog(context);
                              if (strCollectionName != null && strCollectionName != "") {
                                //Create a new collection and add this image
                                userProfile.collections[strCollectionName] = [image.getId()];

                                //update the database
                                await FirestoreService.setUserData();

                                //Close the bottomsheet
                                collectionsBottomSheetController.close();
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ].where((w) => w != null).toList()
                : <Widget>[LoadingIndicator(Colors.black26)]),
      );

  ///Takes input from the user to set the name of a new [userProfile.collections]
  final TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text('Enter new Collection name'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(hintText: "Collection name"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel', style: TextStyle(color: Colors.black87)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.black87,
                child: Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop(_textFieldController.text);
                },
              ),
            ],
          );
        });
  }
}
