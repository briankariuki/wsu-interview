import 'package:flutter/material.dart';
import 'package:wsu_app/config/palette.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final double height;
  final double minWidth;
  final Color color;
  final Color textColor;
  final bool isLoading;

  const CustomButton({
    Key key,
    this.onTap,
    this.title,
    this.height,
    this.minWidth,
    this.color,
    this.textColor,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(minWidth, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: color,
          padding: EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 0.0,
          ),
          elevation: 0.0,
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
        onPressed: onTap,
      ),
    );
  }
}
