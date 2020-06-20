import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_model.dart';
import 'package:http/http.dart' as http;

final _urlNews = 'newsapi.org';
final _apiKey = 'bb2c72fc0e8b47e9a4df1fc5bc70accb';
final _country = 'us';

class NewService with ChangeNotifier {
  // Definiciones de varaibles
  List<Article> headLines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  // Constructor
  NewService() {
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  // Getter y Settes
  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

  // Servicios
  getTopHeadLines() async {
    final url = Uri.http(_urlNews, '/v2/top-headlines', {
      "country": _country,
      "apikey": _apiKey,
    });

    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.http(_urlNews, '/v2/top-headlines', {"country": _country, "apikey": _apiKey, "category": category});
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
