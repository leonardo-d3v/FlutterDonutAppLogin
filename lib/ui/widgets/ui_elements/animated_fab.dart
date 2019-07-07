import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final Function onTap;
  final Color fabColor;
  final IconData icon1;
  final IconData icon2;

  const AnimatedFab(
      {Key key,
      @required this.onTap,
      @required this.fabColor,
      @required this.icon1,
      @required this.icon2})
      : super(key: key);

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with TickerProviderStateMixin {
  //for the rotation animation on click
  AnimationController textAnimationController;
  Animation<double> textAnimation;

  AnimationController closeAnimationController;
  Animation<double> closeAnimation;

  final double fabSize = 76.0;
  bool isMenuClosed = true;

  @override
  initState() {
    textAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200), value: 1.0)
      ..addListener(() => setState(() {}));
    textAnimation = CurvedAnimation(
      parent: textAnimationController,
      curve: Curves.easeInOut,
    );

    closeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() => setState(() {}));
    closeAnimation = CurvedAnimation(
      parent: closeAnimationController,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    textAnimationController.dispose();
    closeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onFabPressed() {
      if (textAnimationController.isDismissed) {
        textAnimationController.forward();
      } else {
        textAnimationController.reverse();
      }

      if (closeAnimationController.isDismissed) {
        closeAnimationController.forward();
      } else {
        closeAnimationController.reverse();
      }

      this.widget.onTap();
    }

    return Container(
        width: fabSize,
        height: fabSize,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4.0, // has the effect of softening the shadow
              spreadRadius: 0.1, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
          // border: Border.all(width: 2, color: Colors.white),
          color: widget.fabColor,
          shape: BoxShape.circle,
        ),
        child: RawMaterialButton(
          shape: CircleBorder(),
          elevation: 0.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ScaleTransition(
                  scale: textAnimation,
                  child: Icon(
                    widget.icon1,
                    size: 36,
                    color: Colors.white,
                  )),
              ScaleTransition(
                  scale: closeAnimation,
                  child: Icon(
                    widget.icon2,
                    size: 36,
                    color: Colors.white,
                  ))
            ],
          ),
          onPressed: () => _onFabPressed(),
        ));
  }
}
