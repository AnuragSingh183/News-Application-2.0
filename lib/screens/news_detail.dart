import 'package:flutter/material.dart';
import 'package:news_app/widgets/customimage.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'package:intl/intl.dart';

class NewsDetail extends StatelessWidget {
  static const routeName = '/news-detail-screen';

  Future<void> _launchUrl(String urlString) async {
    if (await url.canLaunch(urlString)) {
      await url.launch(urlString);
    } else {
      throw 'Could not launch URL $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic> news = args as Map<String, dynamic>? ?? {};
    final String publishedAt = news['publishedAt'] ?? '';
    final String formattedDate = publishedAt.isNotEmpty
        ? DateFormat.yMMMMd().format(DateTime.parse(publishedAt))
        : 'Unknown date';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          news['author'] ?? 'Anonymous',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (publishedAt.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                if (news['description'] != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      news['description'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 25),
                if (news['title'] != null && news['urlToImage'] != null)
                  Hero(
                    tag: news['title'],
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CustomNetworkImage(
                          imageUrl: news['urlToImage'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                if (news['content'] != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      news['content'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                const SizedBox(height: 50),
                Center(
                  child: OutlinedButton(
                    onPressed: news['more'] != null
                        ? () => _launchUrl(news['more'])
                        : null,
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(13),
                    ),
                    child: const Text(
                      'Full Coverage',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
