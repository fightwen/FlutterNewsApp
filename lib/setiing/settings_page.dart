import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }

}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text("Edition"),
      Text("International"),
      Text("Alerts"),
      Text("Android Notification Settings"),
      Row(
        children: <Widget>[
          Column(children: <Widget>[
            Text("Reader Mode"),
          ],),

          _buildSwitchBar()],),
    ],);
  }

  //this goes in our State class as a global variable
  bool isSwitched = true;

  Widget _buildSwitchBar(){
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

