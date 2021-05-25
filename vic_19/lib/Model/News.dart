class News {
  int _idNews;
  String _title;
  String _content;
  DateTime _dateNews;
  String _newsImages;
  String _newsUrl;

  News();

  News.fromNews(this._idNews, this._title, this._content, this._dateNews,
      this._newsImages,this._newsUrl);


  int get idNews => _idNews;

  set idNews(int value) {
    _idNews = value;
  }

  News.fromJson(Map<String, dynamic> json) {
    idNews= json['idNews'];
    title = json['title'];
    content = json['content'];
    dateNews = DateTime.parse(json['dateNews']);
    newsImages = json['newsImages'];
    newsUrl = json['newsUrl'];
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  DateTime get dateNews => _dateNews;

  set dateNews(DateTime value) {
    _dateNews = value;
  }

  String get newsImages => _newsImages;

  set newsImages(String value) {
    _newsImages = value;
  }

  String get newsUrl => _newsUrl;

  set newsUrl(String value) {
    _newsUrl = value;
  }
}