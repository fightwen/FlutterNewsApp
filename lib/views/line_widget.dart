import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget{
  Color mColor;
  LineWidget(Color color){
    mColor = color;
  }

  Widget _buildLine(Color color){
    return Container(
      height: 1.0,
      width: double.infinity,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLine(mColor);
  }
}