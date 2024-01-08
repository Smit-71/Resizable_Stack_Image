library resizable_stack_image;
import 'package:flutter/material.dart';

class ResizableStackImage extends StatefulWidget {
  const ResizableStackImage({super.key, required this.child});

  final Widget child;

  @override
  _ResizableStackImageState createState() => _ResizableStackImageState();
}

const ballDiameter = 20.0;
double top = 0;
double left = 0;
double height = 150;
double width = 150;

class _ResizableStackImageState extends State<ResizableStackImage> {
  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: SizedBox(
            height: height,
            width: width,
            child: widget.child,
          ),
        ),
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = height - 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : height - 2 * mid;
              var newWidth = width - 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : width - 2 * mid;

              setState(() {
                height = newHeight > 20 ? newHeight : 20;
                width = newWidth > 20 ? newWidth : 20;
                top = top + mid < 0
                    ? 0
                    : top + mid > size.height * 0.22
                        ? size.height * 0.22
                        : top + mid;
                left = left + mid < 0
                    ? 0
                    : left + mid > size.height * 0.22
                        ? size.height * 0.22
                        : left + mid;
              });
            },
          ),
        ),
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = height + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : height + 2 * mid;
              var newWidth = width + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : width + 2 * mid;

              setState(() {
                height = newHeight > 20 ? newHeight : 20;
                width = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > size.height * 0.22
                        ? size.height * 0.22
                        : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > size.height * 0.22
                        ? size.height * 0.22
                        : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = height + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : height + 2 * mid;
              var newWidth = width + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : width + 2 * mid;

              setState(() {
                height = newHeight > 20 ? newHeight : 20;
                width = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > size.height * 0.22
                        ? size.height * 0.22
                        : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > size.height * 0.22
                        ? size.height * 0.22
                        : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = height + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : height + 2 * mid;
              var newWidth = width + 2 * mid > size.height * 0.22
                  ? size.height * 0.22
                  : width + 2 * mid;

              setState(() {
                height = newHeight > 20 ? newHeight : 20;
                width = newWidth > 20 ? newWidth : 20;
                top = top - mid < 0
                    ? 0
                    : top - mid > size.height * 0.22
                        ? size.height * 0.22
                        : top - mid;
                left = left - mid < 0
                    ? 0
                    : left - mid > size.height * 0.22
                        ? size.height * 0.22
                        : left - mid;
              });
            },
          ),
        ),
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              setState(() {
                top = top + dy < 0
                    ? 0
                    : top + dy > size.height * 0.22 - height
                        ? size.height * 0.22 - height
                        : top + dy;
                left = left + dx < 0
                    ? 0
                    : left + dx > size.height * 0.22 - width
                        ? size.height * 0.22 - width
                        : left + dx;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
