import 'package:flutter_share/flutter_share.dart';

class ShareTool{

  Future<void> share(String title,String url) async {
    await FlutterShare.share(
        title: title == null ? "": title,
        linkUrl: url == null ? "": url,
        chooserTitle: 'Example Chooser Title'
    );
  }
}