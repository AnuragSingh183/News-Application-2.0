import 'package:flutter/material.dart';
import 'package:news_app/screens/web_view.dart';
import 'package:news_app/widgets/customimage.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/news_provider.dart';
import 'package:share/share.dart';

class FavoritesCard extends StatelessWidget {
  final NewsModel news;
  const FavoritesCard({required this.news});

  void _share() {
    Share.share(news.more);
  }

  @override
  Widget build(BuildContext context) {
    final String _publishedAt =
        DateFormat.yMMMMd().format(DateTime.parse(news.publishedAt));
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CustomWebView.routeName, arguments: {"news": news});
        },
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: news.title,
                      child: Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CustomNetworkImage(
                            imageUrl: news.urlToImage,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Text(
                          news.title,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          _publishedAt,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.black87,
                        ),
                        onPressed: _share,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                        onPressed: () =>
                            Provider.of<NewsProvider>(context, listen: false)
                                .deleteFavorites(news.title),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
