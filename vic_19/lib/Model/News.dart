class News {
  int _idNews;
  String _title;
  String _content;
  DateTime _dateNews;
  String _urlImage;
  String _source;

  News();

  News.fromNews(this._idNews, this._title, this._content, this._dateNews,
      this._urlImage,this._source);


  String get source => _source;

  set source(String value) {
    _source = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }

  DateTime get dateTime => _dateNews;

  set dateNews(DateTime value) {
    _dateNews = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get idNews => _idNews;

  set idNews(int value) {
    _idNews = value;
  }
}