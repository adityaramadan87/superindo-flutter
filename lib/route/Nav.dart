// @dart=2.9
import 'package:flutter/material.dart';

class Nav<T> extends MaterialPageRoute<T> {
  bool fadeTs = false;
  Nav({WidgetBuilder builder, RouteSettings settings,  this.fadeTs})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

    if (settings.name == "/"){
      return child;
    }
    return this.fadeTs ?
    FadeTransition(
      opacity: animation,
      child: child,
    )
    :
    SlideTransition(
      position: Tween(
          begin: Offset(1.0, 0.0),
          end: Offset(0.0,0.0)).animate(animation),
      child: child,
    );
  }
}