import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String title;
  final Color color;

  const Heading1({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 56,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: 1.61,
        ),
      ),
    );
  }
}

class Heading2 extends StatelessWidget {
  final String title;
  final Color color;

  const Heading2({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 40,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: 1.6,
        ),
      ),
    );
  }
}

class Heading3 extends StatelessWidget {
  final String title;
  final Color color;
  final double lineHeight;

  const Heading3({
    Key key,
    @required this.title,
    @required this.color,
    this.lineHeight = 1.61,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 28,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: lineHeight,
        ),
      ),
    );
  }
}

class Heading4 extends StatelessWidget {
  final String title;
  final Color color;
  final double lineHeight;

  const Heading4({
    Key key,
    @required this.title,
    @required this.color,
    this.lineHeight = 1.61,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 20,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: lineHeight,
        ),
      ),
    );
  }
}

class Heading5 extends StatelessWidget {
  final String title;
  final Color color;
  final double lineHeight;

  const Heading5({
    Key key,
    @required this.title,
    @required this.color,
    this.lineHeight = 1.61,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: lineHeight,
        ),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String title;
  final Color color;

  const Paragraph({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 1.57,
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String title;
  final Color color;

  const Subtitle({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 1.57,
        ),
      ),
    );
  }
}

class Subtitle2 extends StatelessWidget {
  final String title;
  final Color color;

  const Subtitle2({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 1.57,
        ),
      ),
    );
  }
}

class ParagraphBold extends StatelessWidget {
  final String title;
  final Color color;

  const ParagraphBold({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.57,
        ),
      ),
    );
  }
}

class ParagraphMedium extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;

  const ParagraphMedium({
    Key key,
    @required this.title,
    @required this.color,
    this.fontSize = 14,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 1.57,
        ),
      ),
    );
  }
}

class Small extends StatelessWidget {
  final String title;
  final Color color;
  final double lineHeight;
  final double fontSize;

  const Small({
    Key key,
    @required this.title,
    @required this.color,
    this.lineHeight = 1.83,
    this.fontSize = 12,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: lineHeight,
        ),
      ),
    );
  }
}

class SmallBold extends StatelessWidget {
  final String title;
  final Color color;

  const SmallBold({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
