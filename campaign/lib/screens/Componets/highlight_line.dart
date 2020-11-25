import 'dart:math';

import 'package:flutter/material.dart';

class CustomRadialGradient extends StatelessWidget {
  final double width;
  final double height;
  CustomRadialGradient({
    @required this.width,
    @required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFFF5F5F5),
              Color(0xFFC7C7C7),
              Color(0xFF9C9C9C),
              Color(0xFF777777),
              Color(0xFF010101),
              Color(0xFF000000),
            ],
            stops: [
              0,
              0.25,
              0.37,
              0.63,
              0.75,
              1,
            ],
            radius: 5,
          ),
        ),
      ),
      clipper: CustomClipPath(),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double widthDp;

  CustomClipPath();
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.addArc(Rect.fromLTRB(0, 0, size.width, size.height), pi, -pi);
    path.addArc(Rect.fromLTRB(0, 0, size.width, size.height), -pi, pi);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
