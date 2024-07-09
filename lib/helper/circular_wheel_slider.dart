import 'dart:math';
import 'package:flutter/material.dart';

class CircularWheelSlider extends StatefulWidget {
  final double height;
  final double childWidth;
  final List<Widget> childs;
  final double unitValue;
  final double circleCenterX;
  final double circleCenterY;
  final double radius;
  final WheelController controller;

  const CircularWheelSlider({
    super.key,
    required this.height,
    required this.childs,
    required this.childWidth,
    required this.controller,
    this.unitValue = 40.0,
    this.circleCenterX = 0.0,
    this.circleCenterY = -9.0,
    this.radius = 10.0,
  });

  @override
  State<StatefulWidget> createState() {
    return _CircularWheelSliderState();
  }
}

typedef CurrentIndex = int Function();

class WheelController {
  CurrentIndex? _getCurrentIndex;
  Function(int)? _setCurrentIndex;
  Function()? _animateLeft;
  Function()? _animateRight;

  setCurrentIndex(int index) {
    _setCurrentIndex?.call(index);
  }

  animateRight() {
    _animateRight?.call();
  }

  animateLeft() {
    _animateLeft?.call();
  }

  int getCurrentIndex() {
    return _getCurrentIndex?.call() ?? 0;
  }
}

enum Direction { left, right }

class _CircularWheelSliderState extends State<CircularWheelSlider>
    with SingleTickerProviderStateMixin {
  double totalWidthUnits = 0;
  int currentIndex = 2;
  int indexOnAnimate = 2;
  late AnimationController _controller;
  Direction direction = Direction.left;

  @override
  void initState() {
    widget.controller._getCurrentIndex = getCurrentIndex;
    widget.controller._animateLeft = animateLeft;
    widget.controller._animateRight = animateRight;
    widget.controller._setCurrentIndex = setCurrentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateAgain() {
    indexOnAnimate = currentIndex;
    _controller.forward(from: 0);
  }

  void animateLeft() {
    direction = Direction.left;
    animateAgain();
  }

  void animateRight() {
    direction = Direction.right;
    animateAgain();
  }

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  int getCurrentIndex() {
    return currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          totalWidthUnits = width / widget.unitValue;
          double clipperValue =
              (1 - findYFromX(totalWidthUnits / 2)) * widget.unitValue;
          return ClipPath(
            clipper: BottomCurveClipper(clipperValue),
            child: Container(
              height: widget.height,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(top: 2),
              child: ClipPath(
                clipper: BottomCurveClipper(clipperValue),
                child: Container(
                  height: widget.height - 4,
                  width: double.infinity,
                  color: Colors.white70,
                  child: Stack(
                    children: getWidgets(width),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double findYFromX(double x) {
    var xDiff = x - widget.circleCenterX;
    return widget.circleCenterY +
        sqrt((widget.radius * widget.radius) - (xDiff * xDiff));
  }

  double findYFromActualX(double width, double x) {
    var plotX = (x - (width / 2)) / widget.unitValue;
    if (plotX >= widget.radius) {
      plotX = widget.radius;
    }
    if (plotX <= -widget.radius) {
      plotX = -widget.radius;
    }
    var y = findYFromX(plotX);
    return ((1 - y) * widget.unitValue);
  }

  List<Widget> getWidgets(double width) {
    var animatedValue = _controller.value;
    if (direction == Direction.left) {
      animatedValue = -animatedValue;
    }
    if (widget.childs.isEmpty) {
      return [];
    }
    List<Widget> widgets = [];
    double childUnitSpace = widget.childs.length > 1
        ? widget.childWidth / (widget.childs.length - 1)
        : widget.childWidth;
    double overAllUnitSpace = widget.childs.length > 1
        ? width / (widget.childs.length - 1)
        : width / 2;
    for (int i = -1; i < widget.childs.length + 1; i++) {
      var x = (overAllUnitSpace * (i + animatedValue)) -
          (childUnitSpace * (i + animatedValue));
      var y = findYFromActualX(width, (overAllUnitSpace * (i + animatedValue)));
      widgets.add(Positioned(left: x, top: y, child: findWidgetByPos(i)));
    }
    return widgets;
  }

  Widget findWidgetByPos(int pos) {
    var start = indexOnAnimate + 3 + pos;
    return widget.childs[start % widget.childs.length];
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  final double depth;

  BottomCurveClipper(this.depth);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, depth);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
    path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, depth);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
