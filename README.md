[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c5e9b080c4ab4392b4d37bc74e99b6e5)](https://app.codacy.com/app/kollerlukas/flutter_unsplash?utm_source=github.com&utm_medium=referral&utm_content=kollerlukas/flutter_unsplash&utm_campaign=Badge_Grade_Dashboard)

<img src="https://github.com/kollerlukas/Flutter_Unsplash/raw/master/assets/ic_launcher_android.png" alt="Icon"
width="100">

# Flutter Unsplash Client

A simple Flutter app showing trending images from [Unsplash](https://unsplash.com/)

## Goal
Create a simple flutter app that uses the unsplash API which allows you to search for photos and add them into collections in an elegant way.
You should be view collections of pictures and, on closer inspection, be able to view collections related to each individual photo. Finally, when viewing collections and photos, they should be sortable by added date or popularity; popularity being how active a photo has been.


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

## Provide an Api Key
create new file `Keys.dart` containing your api key:
```dart
class Keys {
  /* unsplash api key */
  static String UNSPLASH_API_CLIENT_ID = 'YOUR_API_KEY';
}
```
