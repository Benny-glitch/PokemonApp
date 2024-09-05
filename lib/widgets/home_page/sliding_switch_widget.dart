import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingSwitch extends StatefulWidget {
  final double height;
  final ValueChanged<bool> onChanged;
  final bool value;
  final String textOff;
  final String textOn;
  final IconData iconOff;
  final IconData iconOn;
  final double contentSize;
  final Duration animationDuration;
  final Color colorOn;
  final Color colorOff;
  final Color background;
  final Color buttonColor;
  final Color inactiveColor;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;

  const SlidingSwitch({super.key,
    required this.value,
    required this.onChanged,
    this.height = 55,
    this.animationDuration = const Duration(milliseconds: 100),
    required this.onTap,
    required this.onDoubleTap,
    required this.onSwipe,
    this.textOff = "Off",
    this.textOn = "On",
    required this.iconOff,
    required this.iconOn,
    this.contentSize = 17,
    this.colorOn = const Color(0xeeeeeeee),
    this.colorOff = const Color(0xff6682c0),
    this.background = const Color(0xffe4e5eb),
    this.buttonColor = const Color(0xfff7f5f7),
    this.inactiveColor = const Color(0xff636f7b),
  });

  @override
  _SlidingSwitch createState() => _SlidingSwitch();
}

class _SlidingSwitch extends State<SlidingSwitch> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double value = 0.0;
  late bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dynamicWidth = constraints.maxWidth;

        return GestureDetector(
          onTap: () {
            _action();
            widget.onTap();
          },
          onPanEnd: (details) {
            _action();
            widget.onSwipe();
          },
          child: Container(
            height: widget.height + 10,
            width: dynamicWidth,
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(6),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(
                    ((dynamicWidth * 0.5) * value - (2 * value)),
                    0,
                  ),
                  child: Container(
                    height: widget.height,
                    width: dynamicWidth * 0.5 - 9,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      color: widget.buttonColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.iconOff,
                              color: turnState
                                  ? widget.inactiveColor
                                  : widget.colorOff,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.textOff,
                              style: TextStyle(
                                color: turnState
                                    ? widget.inactiveColor
                                    : widget.colorOff,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.iconOn,
                              color: turnState
                                  ? widget.colorOn
                                  : widget.inactiveColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.textOn,
                              style: TextStyle(
                                color: turnState
                                    ? widget.colorOn
                                    : widget.inactiveColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _action() {
    _determine(changeState: true);
  }

  void _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();
      if (changeState) widget.onChanged(turnState);
    });
  }
}