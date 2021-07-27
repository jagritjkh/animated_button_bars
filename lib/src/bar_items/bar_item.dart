import 'package:animated_button_bars/animated_button_bars.dart';
import 'package:flutter/widgets.dart';

/// An interactive button with an icon and text
class BarItem {
  /// Creates an item that is used with [AnimatedTextBar.items].
  ///
  /// The argument [iconData] or [image] both cannot be null.
  /// Either [image] or [iconData] can be given, not both.
  BarItem({
    this.label,
    this.image,
    this.iconData,
    this.activeColor,
    this.inactiveColor,
    this.borderRadius,
  })  : assert(image != null || iconData != null),
        assert(label != null);

  /// The text label for this [BarItem].
  ///
  /// This will be used to create a [Text] widget to put in the animated text bar.
  /// The text to be animated (it will be shown only when the item is selected).
  final String? label;

  /// The image for this [BarItem].
  ///
  /// This will be used to create a [ImageIcon] widget to put in the animated text bar.
  /// It is shown when the item is selected or unselected
  final String? image;

  /// The icon data for this [BarItem].
  ///
  /// This will be used to create a [Icon] widget to put in the animated text bar.
  /// It is shown when the item is selected or unselected
  final IconData? iconData;

  /// The color of the selected [BarItem.iconData] or [BarItem.image].
  ///
  /// If null then the selected item color [AnimatedTextBar.selectedItemColor]'s color is used.
  final Color? activeColor;

  /// The color of the unselected [BarItem.iconData] or [BarItem.image].
  ///
  /// If null then the unselected item color [AnimatedTextBar.selectedItemColor]'s color is used.
  final Color? inactiveColor;

  /// The border radius of the selected [BarItem].
  ///
  /// If null then the selected item border color [AnimatedTextBar.selectedItemBorderRadius]'s border radius is used.
  final BorderRadiusGeometry? borderRadius;
}
