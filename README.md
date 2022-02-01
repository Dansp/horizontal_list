# horizontal_list

A horizontal list widget to use in mainly for web or desktop application.

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
HorizontalScrollView(
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