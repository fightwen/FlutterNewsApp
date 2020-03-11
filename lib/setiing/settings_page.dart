import 'package:flutter/material.dart';
import 'package:flutter_news_app/views/line_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildText(String text, {String subText}) {
    Widget subTextWidget = subText == null
        ? Container()
        : Text(
            subText,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: _buildTextBlackStyle(text),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 8),
          child: subTextWidget,
        )
      ],
    );
  }

  Widget _buildTextLineAndChooseBar(bool isShowBar, String text,
      {String subText}) {
    Widget chooseBar = isShowBar ? _buildSwitchBar() : Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildText(text, subText: subText),
        ),
        chooseBar
      ],
    );
  }

  Widget _buildTextAndChooseBarWithLine(bool isShowBar, String text,
      {String subText}) {
    return Column(
      children: <Widget>[
        _buildTextLineAndChooseBar(isShowBar, text, subText: subText),
        LineWidget(Colors.grey)
      ],
    );
  }

  Widget _buildTextBlackStyle(String text) {
    return Text(text, style: TextStyle(fontSize: 20, color: Colors.black));
  }

  Widget _buildVersionText(String version){
    return Padding(
      padding: EdgeInsets.only(top:16,bottom: 16),
      child: Text(version, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 14, top: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextAndChooseBarWithLine(false, "Privacy Policy"),
            _buildTextAndChooseBarWithLine(false, "Font Size",
                subText: "Default"),
            _buildTextAndChooseBarWithLine(true, "Reader Mode",
                subText: "A text-only view of the Newsfeed"),
            _buildVersionText("Version 6.7"),
          ],
        ));
  }

  //this goes in our State class as a global variable
  bool isSwitched = true;

  Widget _buildSwitchBar() {
    //this goes in as one of the children in our column
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}
