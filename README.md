# horizontal_list

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