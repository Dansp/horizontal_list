# horizontal_list

[![pub](https://img.shields.io/pub/v/horizontal_list)](https://pub.dev/packages/horizontal_list)
[![license](https://img.shields.io/badge/license-mit-green.svg)](https://github.com/Dansp/horizontal_list/blob/main/LICENSE)
[![build](https://github.com/Dansp/horizontal_list/actions/workflows/build.yml/badge.svg)](https://github.com/Dansp/horizontal_list/actions/)
[![codecov](https://codecov.io/gh/Dansp/horizontal_list/branch/main/graph/badge.svg?token=jYfO55O22s)](https://codecov.io/gh/Dansp/horizontal_list)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/rafamizes/horizontal_list)](https://www.codefactor.io/repository/github/rafamizes/horizontal_list)
[![Hits-of-Code](https://hitsofcode.com/github/Dansp/horizontal_list?branch=main)](https://hitsofcode.com/github/Dansp/horizontal_list/view?branch=main)

A horizontal list widget with buttons next and previous. You can customize your card for example and insert it on HorizontalListView widget.


<div>
  WEB/DESKTOP
  <br>
  <img src="https://raw.githubusercontent.com/Dansp/horizontal_list/main/media/web.gif" height="400">
  <br>
  APP
  <br>
  <img src="https://raw.githubusercontent.com/Dansp/horizontal_list/main/media/mobile.gif" height="400">
</div>

<br>

## Using the library

Add the repo to your Flutter `pubspec.yaml` file.

```
dependencies:
  horizontal_list: <<version>>
```

Then run...
```
flutter packages get
```


## Example

```dart
HorizontalListView(
    width: double.maxFinite, //Width of widget
    height: 200, //Height of widget
    list: [Text('Text 1'), Text('Text 2')], //List of widget
    iconNext: Icon(Icons.arrow_forward_ios), // Icon for button next
    iconPrevious: Icon(Icons.arrow_back_ios), // Icon for button previous
    curveAnimation: Curves.bounceIn, //Curve for animation
    durationAnimation: Duration(milliseconds: 300), //Duration of animation
    onNextPressed: () { //On button next pressed
      print('On next pressed');
    },
    onPreviousPressed: () { //On button next pressed
      print('On previous pressed');
    },
),
```
