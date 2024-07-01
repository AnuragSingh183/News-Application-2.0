import 'package:flutter/material.dart';
import 'package:news_app/widgets/show_dialogue.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import '../widgets/loader.dart';

class NewsScreen extends StatelessWidget {
  final category;
  NewsScreen(this.category);
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return Expanded(
      child: FutureBuilder(
        future: newsProvider.getNews(category).isEmpty
            ? newsProvider
                .getAndFetchNews(category)
                .catchError((error) => showCustomDialogue(context, error))
            : Future.value(true),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Loader()
                : Consumer<NewsProvider>(
                    builder: (context, newsItem, child) => Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: RefreshIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                        onRefresh: () => newsProvider
                            .getAndFetchNews(category)
                            .catchError(
                                (error) => showCustomDialogue(context, error)),
                        displacement: 2,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return NewsCard(
                              news: newsItem.getNews(category)[index],
                            );
                          },
                          itemCount: newsItem.getNews(category).length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
