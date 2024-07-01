import 'package:flutter/material.dart';
import 'package:news_app/screens/web_view.dart';
import 'package:news_app/widgets/customimage.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/news_provider.dart';
import 'package:share/share.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  final snackBar = SnackBar(
    content: Text(
      'News added to favorites.',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    backgroundColor: Colors.black,
  );

  NewsCard({required this.news});

  void _share() {
    Share.share(news.more);
  }

  @override
  Widget build(BuildContext context) {
    final _publishedAt =
        DateFormat.yMMMMd().format(DateTime.parse(news.publishedAt));
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CustomWebView.routeName, arguments: {"news": news});
        },
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: news.title,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: CustomNetworkImage(
                        imageUrl: news.urlToImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    news.title,
                    overflow: TextOverflow.clip,
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                          Icons.add_circle_rounded,
                          size: 30,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          Provider.of<NewsProvider>(context, listen: false)
                              .addFavorites(news);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
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
