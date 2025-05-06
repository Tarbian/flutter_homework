import '../news_generator.dart';

abstract class NewsRepository {
  String getNews();
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsGenerator news;

  NewsRepositoryImpl(this.news);

  @override
  String getNews() => news.generate();
}
