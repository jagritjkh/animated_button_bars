import 'package:animated_button_bars/src/bar_items/bar_item.dart';
import 'package:flutter/material.dart';

/// A widget that's used either at the bottom of an app in the
/// [Scaffold]'s [Scaffold.bottomNavigationBar] argument
/// or
/// at the top of an app as a [TabBar] by wrapping with [PreferredSize] in the
/// [Scaffold]'s [Scaffold.appBar] or [AppBar]'s [AppBar.bottom] argument
/// for selecting among a small number of views, typically between three and five.
class AnimatedTextBar extends StatefulWidget {
  /// Creates a animated text bar which is typically used as a
  /// [Scaffold]'s [Scaffold.bottomNavigationBar] argument.
  ///
  /// The length of [items] must be at least two and each item's iconData or
  /// image and label must not be null.
  ///
  /// [elevation] argument must be non-negative.
  AnimatedTextBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.backgroundColor,
    this.shadowColor,
    this.animatedTextDuration = const Duration(milliseconds: 250),
    this.animatedTextCurve = Curves.easeInOut,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.margin,
    this.padding,
    this.borderRadius,
    this.textPosition = TextPosition.RIGHT,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedItemBorderRadius,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
  }) : assert(elevation == null || elevation >= 0.0),
       super(key: key);

  /// Defines the appearance of the button items that are arrayed within the
  /// animated text bar.
  final List<BarItem> items;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the animated text bar needs to keep
  /// track of the index of the selected [BarItem] and call
  /// `setState` to rebuild the animated text bar with the new [currentIndex].
  final ValueChanged<int>? onTap;

  /// The index into [items] for the current active [BarItem].
  final int currentIndex;

  /// The z-coordinate of this [BottomNavigationBar].
  ///
  /// If null then `8.0` is used.
  final double? elevation;

  /// The color of the [AnimatedTextBar] itself.
  ///
  /// If null then the [ThemeData.scaffoldBackgroundColor]'s color is used.
  final Color? backgroundColor;

  /// The shadow color of the [AnimatedTextBar] itself.
  ///
  /// If null, [ThemeData.shadowColor] is used, which defaults to fully opaque black.
  final Color? shadowColor;

  /// The margin of the [AnimatedTextBar] itself from the screen.
  ///
  /// If null, [EdgeInsets.zero] is used.
  final EdgeInsetsGeometry? margin;

  /// The padding of the [items] from [AnimatedTextBar].
  ///
  /// If null, [const EdgeInsets.symmetric(vertical: 8.0)] is used.
  final EdgeInsetsGeometry? padding;

  /// The border radius of the [AnimatedTextBar] itself.
  ///
  /// If null, [BorderRadius.zero] is used.
  final BorderRadiusGeometry? borderRadius;

  /// The position of animated text (label [BarItem.label]).
  ///
  /// Defaults to [TextPosition.RIGHT]
  final TextPosition textPosition;

  /// The duration of animation of the label [BarItem.label].
  ///
  /// Defaults to Duration(milliseconds: 250).
  final Duration animatedTextDuration;

  ///The curve of animation of the label [BarItem.label].
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve animatedTextCurve;

  /// The color of the selected [BarItem.iconData] or [BarItem.image]s.
  ///
  /// If [BarItem.activeColor] is null then selected item color is used.
  /// If null then the [ThemeData.primaryColor] is used.
  final Color? selectedItemColor;

  /// The color of the unselected [BarItem.iconData] or [BarItem.image]s.
  ///
  /// If [BarItem.inactiveColor] is null then unselected item color is used.
  /// If null then the [ThemeData.unselectedWidgetColor]'s color is used.
  final Color? unselectedItemColor;

  /// The [TextStyle] of the [BarItem] labels when they are
  /// selected.
  final TextStyle? selectedLabelStyle;

  /// The [TextStyle] of the [BarItem] labels when they are not
  /// selected.
  final TextStyle? unselectedLabelStyle;

  /// The font size of the [BarItem] labels when they are selected.
  ///
  /// If [TextStyle.fontSize] of [selectedLabelStyle] is non-null, it will be
  /// used instead of this.
  ///
  /// Defaults to `14.0`.
  final double selectedFontSize;

  /// The font size of the [nBarItem] labels when they are not
  /// selected.
  ///
  /// If [TextStyle.fontSize] of [unselectedLabelStyle] is non-null, it will be
  /// used instead of this.
  ///
  /// Defaults to `12.0`.
  final double unselectedFontSize;

  /// The border radius of the selected [BarItem].
  ///
  /// If null, [BorderRadius.all(Radius.circular(30))] is used.
  final BorderRadiusGeometry? selectedItemBorderRadius;

  @override
  _AnimatedTextBarState createState() => _AnimatedTextBarState();
}

class _AnimatedTextBarState extends State<AnimatedTextBar> with TickerProviderStateMixin {
  late int _selectedBarIndex;

  @override
  void initState() {
    super.initState();
    _selectedBarIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Material(
        elevation: widget.elevation ?? 8.0,
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        color: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        shadowColor: widget.shadowColor,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _createBarItems(),
          ),
        ),
      ),
    );
  }

  // If the given [TextStyle] has a non-null `fontSize`, it should be used.
  // Otherwise, the [selectedFontSize] parameter should be used.
  static TextStyle _effectiveTextStyle(TextStyle? textStyle, double fontSize) {
    textStyle ??= const TextStyle();
    // Prefer the font size on textStyle if present.
    return textStyle.fontSize == null ? textStyle.copyWith(fontSize: fontSize) : textStyle;
  }

  /// method that returns the item background color
  Color _itemBackgroundColor(bool isSelected, BarItem item) {
    return isSelected
        ? (item.activeColor ?? widget.selectedItemColor ?? Theme.of(context).primaryColor)
            .withValues(alpha: 0.075)
        : Colors.transparent;
  }

  /// method that returns the item color when item is selected or not
  Color _itemColor(bool isSelected, BarItem item) {
    return isSelected
        ? item.activeColor ?? widget.selectedItemColor ?? Theme.of(context).primaryColor
        : item.inactiveColor ??
            widget.unselectedItemColor ??
            Theme.of(context).unselectedWidgetColor;
  }

  /// method that returns the bottom bar items
  List<Widget> _createBarItems() {
    final BottomNavigationBarThemeData bottomTheme = BottomNavigationBarTheme.of(context);

    final TextStyle effectiveSelectedLabelStyle = _effectiveTextStyle(
      widget.selectedLabelStyle ?? bottomTheme.selectedLabelStyle,
      widget.selectedFontSize,
    );
    final TextStyle effectiveUnselectedLabelStyle = _effectiveTextStyle(
      widget.unselectedLabelStyle ?? bottomTheme.unselectedLabelStyle,
      widget.unselectedFontSize,
    );

    final List<Widget> _barItems = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      BarItem item = widget.items[i];
      bool isSelected = _selectedBarIndex == i;
      _barItems.add(
        _BottomBarItem(
          item,
          () {
            setState(() {
              _selectedBarIndex = i;
              widget.onTap?.call(i);
            });
          },
          isSelected ? effectiveSelectedLabelStyle : effectiveUnselectedLabelStyle,
          _itemColor(isSelected, item),
          _itemBackgroundColor(isSelected, item),
          widget.textPosition,
          widget.animatedTextDuration,
          widget.animatedTextCurve,
          item.borderRadius ??
              widget.selectedItemBorderRadius ??
              const BorderRadius.all(Radius.circular(30)),
          isSelected,
        ),
      );
    }
    return _barItems;
  }
}

/// bottom bar item to build the bar single bar item with animation
class _BottomBarItem extends StatefulWidget {
  _BottomBarItem(
    this.item,
    this.onTap,
    this.labelStyle,
    this.color,
    this.bgColor,
    this.textPosition,
    this.animatedTextDuration,
    this.animatedTextCurve,
    this.borderRadius,
    this.isSelected,
  );

  final BarItem item;
  final VoidCallback? onTap;
  final TextStyle labelStyle;
  final Color color;
  final Color bgColor;
  final Duration animatedTextDuration;
  final Curve animatedTextCurve;
  final BorderRadiusGeometry borderRadius;
  final bool isSelected;
  final TextPosition textPosition;

  @override
  _BottomBarItemState createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem> {
  BarItem get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        duration: widget.animatedTextDuration,
        decoration: BoxDecoration(color: widget.bgColor, borderRadius: widget.borderRadius),
        child: _buildRowItem(),
      ),
    );
  }

  Row _buildRowItem() {
    return Row(
      children: [
        if (item.label != null && widget.textPosition == TextPosition.LEFT) _animatedText(),
        if (item.label != null && widget.textPosition == TextPosition.LEFT) SizedBox(width: 10.0),
        if (item.image != null) ImageIcon(AssetImage(item.image!), color: widget.color),
        if (item.iconData != null) Icon(item.iconData!, color: widget.color),
        if (item.label != null && widget.textPosition == TextPosition.RIGHT) SizedBox(width: 10.0),
        if (item.label != null && widget.textPosition == TextPosition.RIGHT) _animatedText(),
      ],
    );
  }

  AnimatedSize _animatedText() {
    return AnimatedSize(
      duration: widget.animatedTextDuration,
      curve: widget.animatedTextCurve,
      alignment: Alignment.centerRight,
      child: Text(widget.isSelected ? item.label! : "", style: widget.labelStyle),
    );
  }
}

enum TextPosition { LEFT, RIGHT }
