// @dart=2.9
import 'package:flutter/material.dart';

class HeroContainer extends StatefulWidget {

  String heroTag;
  double height;
  double width;
  Widget child;
  EdgeInsetsGeometry margin;
  BorderRadiusGeometry borderRadius;

  HeroContainer({
    this.heroTag,
    this.child,
    this.height,
    this.width,
    EdgeInsetsGeometry margin,
    BorderRadiusGeometry borderRadius
  }) :
  margin = margin ?? EdgeInsets.all(0),
  borderRadius = borderRadius ?? BorderRadius.circular(0);

  @override
  _HeroContainerState createState() => _HeroContainerState();
}

class _HeroContainerState extends State<HeroContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius
      ),
      child: Hero(
          tag: widget.heroTag,
          child: widget.child
      ),
    );
  }
}
