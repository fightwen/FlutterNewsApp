import 'package:flutter/material.dart';
import 'package:flutter_news_app/generated/i18n.dart';
import 'package:flutter_news_app/search/recent_search_page.dart';
import 'package:flutter_news_app/search/controller/search_controller.dart';
import 'package:flutter_news_app/search/search_result_page.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'package:flutter_news_app/style/app_paddings.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  static const double leftPadding = AppPaddings.leftPadding;
  static const double rightPadding = 8;
  static const double searchleftRightPadding = 6;
  var _searchController = SearchController();
  bool isSearched = false;
  var _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildTextFormFieldStyle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: searchleftRightPadding, right: searchleftRightPadding),
          child: Icon(Icons.search),
        ),
        Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 42,
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _searchController.saveKeywordToFile(value);
                      isSearched = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.of(context).find_it_on_news,
                  suffixIcon: IconButton(
                      onPressed: () => _controller.clear(),
                      icon: Icon(Icons.clear)),
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildTextFormFieldStyleWithRadius() {
    const double radius = 4.0;
    const double otherPadding = 8;
    return Container(
      margin: EdgeInsets.only(
          left: leftPadding,
          top: otherPadding,
          bottom: otherPadding,
          right: otherPadding),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(radius),
            topRight: const Radius.circular(radius),
            bottomRight: const Radius.circular(radius),
            bottomLeft: const Radius.circular(radius),
          )),
      child: _buildTextFormFieldStyle(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildTextFormFieldStyleWithRadius(),
          ),
          Padding(
            padding: EdgeInsets.only(right: rightPadding),
            child: InkWell(
              onTap: () {
                setState(() {
                  isSearched = false;
                  _controller.clear();
                });
              },
              child: Text(
                S.of(context).cancel,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSearchBar(),
        _generateSearchListPage(isSearched,keyword:_controller.text),
      ],
    );
  }

  Widget _generateSearchListPage(bool isSearched,{String keyword = ""}) {
    if (isSearched) return _buildSearchResultPage(keyword);
    return Expanded(
      child: RecentSearchPage(searchCallBack:(value){
        setState(() {
          this.isSearched = true;
          _controller.text = value;
        });
      }),
    );
  }

  Widget _buildSearchResultPage(String keyword){
    return Expanded(child: SearchResultPage(keyword:keyword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor, body: _buildSearchPage());
  }
}
