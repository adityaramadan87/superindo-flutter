// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:superindo/constant/Constant.dart';

class ButtonMain extends StatefulWidget {

  GestureTapCallback onTap;
  Color splashColor;
  BorderRadius borderRadius;
  String text;
  Color textColor;
  double textSize;
  FontWeight textWeight;
  Color backgroundColor;
  double width;
  Color borderOutlineColor;
  String heroTag;
  bool isLoading;

  ButtonMain({
    @required this.onTap,
    @required this.text,
    Color textColor,
    Color splashColor,
    BorderRadius borderRadius,
    double textSize,
    FontWeight textWeight,
    Color backgroundColor,
    double width,
    Color borderOutlineColor,
    String heroTag,
    bool isLoading
  }) :
        splashColor = splashColor ?? Colors.indigo,
        borderRadius = borderRadius ?? BorderRadius.circular(16),
        textColor = textColor ?? Colors.black87,
        textSize = textSize ?? 14,
        textWeight = textWeight ?? FontWeight.normal,
        backgroundColor = backgroundColor ?? Colors.white,
        width = width ?? 20,
        borderOutlineColor = borderOutlineColor ?? backgroundColor,
        heroTag = heroTag ?? null,
        isLoading = isLoading ?? false;

  @override
  _ButtonMainState createState() => _ButtonMainState();
}

class _ButtonMainState extends State<ButtonMain> {
  @override
  Widget build(BuildContext context) {
    return widget.heroTag != null ?
    Hero(
        tag: widget.heroTag,
        child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(color: widget.borderOutlineColor, width: widget.borderOutlineColor == widget.backgroundColor ? 0 : 1),
        ),
        width: widget.width,
        child: Material(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor,
          elevation: 6,
          type: MaterialType.button,
          child: InkWell(
            highlightColor: widget.splashColor,
            onTap: widget.onTap,
            splashColor: widget.splashColor,
            borderRadius: widget.borderRadius,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: widget.isLoading ?
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    :
                Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.textSize,
                      fontWeight: widget.textWeight,
                      fontFamily: widget.textWeight == FontWeight.bold ? Constant.fonts.NUNITO : Constant.fonts.POPPINS
                  ),
                ),
              ),
            ),
          ),
        )
    ))
    :
    Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(color: widget.borderOutlineColor, width: widget.borderOutlineColor == widget.backgroundColor ? 0 : 1),
        ),
        width: widget.width,
        child: Material(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor,
          elevation: 6,
          type: MaterialType.button,
          child: InkWell(
            highlightColor: widget.splashColor,
            onTap: widget.onTap,
            splashColor: widget.splashColor,
            borderRadius: widget.borderRadius,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.textSize,
                      fontWeight: widget.textWeight,
                      fontFamily: widget.textWeight == FontWeight.bold ? Constant.fonts.NUNITO : Constant.fonts.POPPINS
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
