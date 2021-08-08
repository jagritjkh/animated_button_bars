# animated_button_bars

A new Flutter project.

## Getting Started

To use this package, add `animated_button_bars` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

See example for the usage of animated button bar

## Add dependency
```
dependencies:
  animated_button_bars: ^0.0.2
```

## Import
```
import 'package:animated_button_bars/animated_button_bars.dart';
```

## Usage: AnimatedTextBar

### Single item in the list of Bar Items
```
BarItem(
    label: "Yellow",
    iconData: Icons.skip_previous,
    activeColor: Colors.yellow,
),
```

### AnimatedTextBar itself
```
AnimatedTextBar(
    borderRadius: BorderRadius.circular(30),
    margin: EdgeInsets.all(20),
    onTap: (index) {
        setState(() {
            _currentIndex = index;
        });
    },
    items: _barItems,
),
```

Many more animated button bars will be added soon..!

Made with :heart: by Jagrit