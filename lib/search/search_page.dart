import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }

}

class _SearchPageState extends State<SearchPage> {
  Widget _buildTextFormFieldStyle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(left: 6,right: 6),
          child: Icon(Icons.search),),

        Expanded(child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Find it on News'
          ),)
        )
      ],
    );
  }

  Widget _buildTextFormFieldStyleWithRadius(){
    const double radius = 4.0;
    return Container(
      margin: EdgeInsets.all(8),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(radius),
            topRight: const Radius.circular(radius),
            bottomRight: const Radius.circular(radius),
            bottomLeft: const Radius.circular(radius),
          )
      ),
      child: _buildTextFormFieldStyle(),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          color:Colors.grey[300],
          child: Row(children: <Widget>[
            Expanded(

              child: _buildTextFormFieldStyleWithRadius(),),
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text("Cancel",style: TextStyle(fontSize: 16),),),

          ],),)



    );
  }

}