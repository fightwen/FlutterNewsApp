
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsPageLoadingListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsPageLoadingListViewState();
  }

}

class _NewsPageLoadingListViewState extends State<NewsPageLoadingListView>{
  @override
  Widget build(BuildContext context) {
    return getLoadingListView(8);
  }

  ListView getLoadingListView(int size) => ListView.builder(
      physics:NeverScrollableScrollPhysics(),
      itemCount: size,
      itemBuilder: (BuildContext context, int position) {
        return getRow();
      });

  Widget getRow() {
    return NewsLoadingCardItem();
  }

}



class NewsLoadingCardItem extends StatefulWidget {

  NewsLoadingCardItem();


  @override
  State<StatefulWidget> createState() {
    return _NewsLoadingCardItemState();
  }
}

class _NewsLoadingCardItemState extends State<NewsLoadingCardItem>{
  Radius radius = Radius.circular(8);
  _NewsLoadingCardItemState();


  Widget _buildCardImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft:radius,topRight: radius),
          child: _buidSizedBox(double.maxFinite, 220),
        ),


      ],
    );
  }




  Widget _buildLoadingCardItems() {

    return Column(
      children: <Widget>[
        _buildCardImage(),
        _buildLoadingCardToolbar()
      ],
    );
  }

  Widget _buidSizedBox(double iconWidth,double iconHeight) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[200],
        child: Container(
          width: iconWidth,
          height: iconHeight,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLoadingCardToolbar(){
    double iconWidthHeight = 24;
    double iconSize = 22;

    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buidSizedBox(iconWidthHeight,iconWidthHeight),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 8),
              child: _buidSizedBox(iconWidthHeight,iconWidthHeight),
            )
          ],
        )
    );
  }




  @override
  Widget build(BuildContext context) {

    return Card(
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: _buildLoadingCardItems(),
        );
  }

}



