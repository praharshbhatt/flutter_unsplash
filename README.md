[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c5e9b080c4ab4392b4d37bc74e99b6e5)](https://app.codacy.com/app/kollerlukas/flutter_unsplash?utm_source=github.com&utm_medium=referral&utm_content=kollerlukas/flutter_unsplash&utm_campaign=Badge_Grade_Dashboard)

<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/assets/ic_launcher_android.png" alt="Icon"
width="100">

# Flutter Unsplash Client

A simple Flutter app showing trending images from [Unsplash](https://unsplash.com/)

## Goal
Create a simple flutter app that uses the unsplash API which allows you to search for photos and add them into collections in an elegant way.
You should be view collections of pictures and, on closer inspection, be able to view collections related to each individual photo. Finally, when viewing collections and photos, they should be sortable by added date or popularity; popularity being how active a photo has been.

## Features:
1. Loads all the unsplash images
2. All images are searchable
3. View information on all the images
4. Login with Google
5. Ability to save the collection to user's profile.

<div>
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/demo/Demo-1.gif" alt="Unsplash Client" width="200">
</div>



## Android Screenshots
<div>
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/android_screenshot_main.png" alt="Screenshot Main" width="200">
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/android_screenshot_image.png" alt="Screenshot Source" width="200">
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/android_screenshot_search.png" alt="Screenshot Source" width="200">
</div>

## IOS Screenshots
<div>
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/ios_screenshot_main.png" alt="Screenshot Main" width="200">
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/ios_screenshot_image.png" alt="Screenshot Source" width="200">
<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/screenshots/ios_screenshot_search.png" alt="Screenshot Source" width="200">
</div>


Try the APK
</br>
<a href = "https://github.com/praharshbhatt/flutter_unsplash/raw/master/Flutter%20Unsplash.apk" ><img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" width="200"></a>


## Provide an Api Key
create new file `Keys.dart` containing your api key:
```dart
class Keys {
  /* unsplash api key */
  static String UNSPLASH_API_CLIENT_ID = 'YOUR_API_KEY';
}
```
