import 'dart:convert';
import '../helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class NewsModel {
  String source;
  String title;
  String description;
  String more;
  String urlToImage;
  String content;
  String author;
  String publishedAt;

  NewsModel(
      {required this.title,
      required this.description,
      required this.more,
      required this.urlToImage,
      required this.content,
      required this.author,
      required this.publishedAt,
      required this.source});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      more: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      content: json['content'] ?? 'No content',
      author: json['author'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
      source: json['source']?['name'] ?? 'Unknown source',
    );
  }
}

class NewsProvider with ChangeNotifier {
  List<NewsModel> _generalNews = [];
  List<NewsModel> _sportsNews = [];
  List<NewsModel> _techNews = [];
  List<NewsModel> _healthNews = [];
  List<NewsModel> _entertainmentNews = [];
  List<NewsModel> _scienceNews = [];
  List<NewsModel> _businessNews = [];
  List<NewsModel> _favNews = [];

  List<NewsModel> getNews(String category) {
    switch (category) {
      case 'favorites':
        return _favNews;
      case 'technology':
        return _techNews;
      case 'general':
        return _generalNews;
      case 'sports':
        return _sportsNews;
      case 'health':
        return _healthNews;
      case 'science':
        return _scienceNews;
      case 'business':
        return _businessNews;
      case 'entertainment':
        return _entertainmentNews;
      default:
        return []; // Return an empty list if no match is found
    }
  }

  Future<void> getAndFetchNews(String category) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      final newsUrl = Uri.parse(
          'https://newsapi.org/v2/top-headlines?apiKey=9a420f1e32e64332aca15d4fcb43b5a4&category=$category&country=in');

      final _newsResponse = await http.get(newsUrl);
      if (_newsResponse.statusCode != 200) {
        throw Exception('Failed to load news');
      }

      final _newsBody = json.decode(_newsResponse.body);
      final _newsList = _newsBody['articles'] as List<dynamic>;
      final tempnews =
          _newsList.map((news) => NewsModel.fromJson(news)).toList();

      switch (category) {
        case 'technology':
          _techNews = tempnews;
          break;
        case 'general':
          _generalNews = tempnews;
          break;
        case 'sports':
          _sportsNews = tempnews;
          break;
        case 'health':
          _healthNews = tempnews;
          break;
        case 'science':
          _scienceNews = tempnews;
          break;
        case 'business':
          _businessNews = tempnews;
          break;
        case 'entertainment':
          _entertainmentNews = tempnews;
          break;
      }
      notifyListeners();
    } catch (error) {
      print('Error fetching news: $error'); // Log the error
      throw error;
    }
  }

  void addFavorites(NewsModel news) {
    DBHelper.insert('fav_news', {
      'id': news.title,
      'title': news.title,
      'description': news.description,
      'more': news.more,
      'image': news.urlToImage,
      'content': news.content,
      'author': news.author,
      'publishedAt': news.publishedAt,
    });
    _favNews.add(news);
    notifyListeners();
  }

  void deleteFavorites(String id) {
    DBHelper.deleteFavorites('fav_news', id);
    int delIndex = _favNews.indexWhere((element) => element.title == id);
    _favNews.removeAt(delIndex);
    notifyListeners();
  }

  Future<void> getFavourites() async {
    final dataList = await DBHelper.getData('fav_news');
    _favNews = dataList
        .map(
          (news) => NewsModel(
              description: news['description'],
              title: news['title'],
              content: news['content'],
              urlToImage: news['image'],
              more: news['more'],
              author: news['author'],
              publishedAt: news['publishedAt'],
              source: ''),
        )
        .toList();

    notifyListeners();
  }
}
