import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }

}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Colors.grey[200],
        child:Center(
            child: getListView(),
        )
    );
  }

  ListView getListView() => ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return CustomCard();
  }

}

class CustomCard extends StatelessWidget {

  Widget _buildCardImage(){
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
        ),
        Container(
            width: double.infinity,
            constraints: BoxConstraints.expand(height: 150.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87]))
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle",
            style: TextStyle(color: Colors.white,fontSize: 26.0),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ) ,
        ),

      ],
    );
  }

  Widget _buildCardItems(){
    return Column(
      children: <Widget>[
        _buildCardImage(),
        Padding(
            padding: EdgeInsets.all(7.0),
                child: Row(
                    children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.bookmark_border),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Icon(Icons.share),
                )
              ],
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildCardItems(),
    );
  }
}

