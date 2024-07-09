import 'package:flutter/material.dart';
import 'package:newapp/helper/extensions.dart';
import 'package:newapp/helper/utils.dart';
import 'package:newapp/ui/components//top_header_widget.dart';
import 'package:newapp/helper/circular_wheel_slider.dart';

enum Direction { left, right }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> isCollapsed = ValueNotifier(false);
  final DraggableScrollableController controller = DraggableScrollableController();
  final ValueNotifier<double> header = ValueNotifier(200.0);
  final ValueNotifier<int> currentTab = ValueNotifier(2);
  final WheelController wheelController = WheelController();

  double availableHeight = 0;
  double horizontalDrag = 0;
  Direction direction = Direction.left;

  @override
  void initState() {
    controller.addListener(updateVal);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(updateVal);
    super.dispose();
  }

  void updateVal() {
    final double h = controller.pixels;
    if (h > (availableHeight * 0.7)) {
      isCollapsed.value = true;
    } else {
      isCollapsed.value = false;
    }
    header.value = availableHeight - h - 10;
  }

  void onAvailableHeight() {
    header.value = availableHeight * 0.4;
  }

  void _onHorizontalSwipe(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      moveLeft();
    } else if (details.primaryVelocity! > 0) {
      moveRight();
    }
  }

  void setPage(int index) {
    if (index < 0) {
      index = navItems.length - 1;
    } else if (index >= navItems.length) {
      index = 0;
    }
    currentTab.value = index;
    wheelController.setCurrentIndex(index);
  }

  void moveRight() {
    direction = Direction.right;
    wheelController.animateRight();
    var index = wheelController.getCurrentIndex();
    index = (index == 0) ? navItems.length - 1 : index - 1;
    setPage(index);
  }

  void moveLeft() {
    direction = Direction.left;
    wheelController.animateLeft();
    var index = wheelController.getCurrentIndex();
    index = (index == navItems.length - 1) ? 0 : index + 1;
    setPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          availableHeight = constraints.maxHeight;
          onAvailableHeight();
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Flexible(flex: 2, child: Container(color: Colors.red)),
                    Flexible(flex: 2, child: Container(color: Colors.white)),
                  ],
                ),
                TopHeaderWidget(header: header, isCollapsed: isCollapsed),
                LayoutBuilder(
                  builder: (context, dragConstraints) {
                    return DraggableScrollableSheet(
                      controller: controller,
                      initialChildSize: 0.6,
                      minChildSize: 0.6,
                      maxChildSize: 0.8,
                      builder: (BuildContext context, scrollController) {
                        return ValueListenableBuilder<int>(
                          valueListenable: currentTab,
                          builder: (context, selectedIndex, _) {
                            return GestureDetector(
                              onHorizontalDragEnd: _onHorizontalSwipe,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                reverseDuration: Duration.zero,
                                switchInCurve: Curves.linear,
                                switchOutCurve: Curves.linear,
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  Animation<Offset> slideAnimation;

                                  if (direction == Direction.right) {
                                    slideAnimation = Tween<Offset>(
                                      begin: Offset(-1.0, 1.0), // From bottom-left to center
                                      end: Offset.zero,
                                    ).animate(animation);
                                  } else {
                                    slideAnimation = Tween<Offset>(
                                      begin: Offset(1.0, 1.0), // From bottom-right to center
                                      end: Offset.zero,
                                    ).animate(animation);
                                  }

                                  return SlideTransition(
                                    position: slideAnimation,
                                    child: child,
                                  );
                                },
                                child: Material(
                                  key: ValueKey<int>(selectedIndex),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: navItems[selectedIndex].tabWidget,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: GestureDetector(
              onHorizontalDragStart: (details) {
                horizontalDrag = 0;
              },
              onHorizontalDragUpdate: (details) {
                horizontalDrag += details.delta.dx;
                if (horizontalDrag >= 100) {
                  moveRight();
                  horizontalDrag = 0;
                } else if (horizontalDrag <= -100) {
                  moveLeft();
                  horizontalDrag = 0;
                }
              },
              child: CircularWheelSlider(
                height: 100,
                childs: navItems.mapIndexed((i, e) {
                  return ValueListenableBuilder<int>(
                    valueListenable: currentTab,
                    builder: (context, value, _) {
                      return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: i == value
                              ? Colors.red.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(child: e.icon),
                              e.topBodyWidget,
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                childWidth: 30,
                controller: wheelController,
              ),
            ),
          );
        },
      ),
    );
  }
}
