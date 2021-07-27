import 'package:animated_button_bars/animated_button_bars.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Button Bars',
      home: AnimatedTextBarExample(),
    );
  }
}

class AnimatedTextBarExample extends StatefulWidget {
  @override
  _AnimatedTextBarExampleState createState() => _AnimatedTextBarExampleState();
}

class _AnimatedTextBarExampleState extends State<AnimatedTextBarExample> {
  int _currentIndex = 0;

  List<Color> _colors = [Colors.yellow, Colors.red, Colors.blue, Colors.green];

  final List<BarItem> _barItems = [
    BarItem(
      label: "Yellow",
      iconData: Icons.skip_previous,
      activeColor: Colors.yellow,
    ),
    BarItem(
      label: "Red",
      iconData: Icons.stop,
      activeColor: Colors.red,
    ),
    BarItem(
      label: "Blue",
      iconData: Icons.play_arrow,
      activeColor: Colors.blue,
    ),
    BarItem(
      label: "Green",
      iconData: Icons.skip_next,
      activeColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors[_currentIndex],
      appBar: AppBar(
        title: Text(
          'Animation Button Bars',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      bottomNavigationBar: AnimatedTextBar(
        borderRadius: BorderRadius.circular(30),
        margin: EdgeInsets.all(20),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _barItems,
      ),
    );
  }
}
