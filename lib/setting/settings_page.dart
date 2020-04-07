import 'package:flutter/material.dart';
import 'package:flutter_news_app/generated/i18n.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';
import 'package:flutter_news_app/preferences/setting_preferences.dart';
import 'package:flutter_news_app/setting/setting_web_page.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'package:flutter_news_app/views/line_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  static const double mainFontSize = 18;
  static const double subFontSize = 12;
  //this goes in our State class as a global variable
  bool isSwitched = false;
  SettingPreference preference = SettingPreference();

  Widget _buildText(String text, {String subText}) {
    Widget subTextWidget = subText == null
        ? Container()
        : Text(
            subText,
            style: TextStyle(fontSize: subFontSize, color: Colors.grey[600]),
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
    Widget chooseBar = isShowBar ? FutureBuilder(
        future: preference.isTextOnlyMode(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            isSwitched = snapshot.data;
          }

          if(snapshot.connectionState == ConnectionState.done){
            return _buildSwitchBar();
          }else{
            return Container();
          }


    }) : Container();
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

  _launchURL() async {
    const url = 'https://newsapi.org/';
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingWebPageRoute(
              initialUrl: url
            )));
  }


  Widget _buildTextAndChooseBarWithLine(bool isShowBar, String text,
      {String subText}) {
    return  Column(
      children: <Widget>[
        _buildTextLineAndChooseBar(isShowBar, text, subText: subText),
        LineWidget(Colors.grey)
      ],
    );
  }

  Widget _buildTextBlackStyle(String text) {
    return Text(text, style: TextStyle(fontSize: mainFontSize, color: Colors.black));
  }

  Widget _buildVersionText(String version){
    return Padding(
      padding: EdgeInsets.only(top:16,bottom: 16),
      child: Text(version, style: TextStyle(fontSize: subFontSize, color: Colors.grey[600])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Padding(
          padding: EdgeInsets.only(left: 14, top: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                 onTap: (){
                 _launchURL();
                 },
               child:_buildTextAndChooseBarWithLine(false, S.of(context).powered_by_news_api)
              ),
              _buildTextAndChooseBarWithLine(false, S.of(context).font_size,
                  subText: S.of(context).default_setting),
              _buildTextAndChooseBarWithLine(true, S.of(context).reader_mode,
                  subText: S.of(context).text_only),
              _buildVersionText(S.of(context).version+"1.1"),
            ],
          )
      ),
    );
  }


  Widget _buildSwitchBar() {
    //this goes in as one of the children in our column
    return Switch(
      value: isSwitched == null?false:isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          preference.setTextOnlyMode(isSwitched);
        });
      },
      activeTrackColor: Colors.red[100],
      activeColor: Colors.red,
    );
  }
}
