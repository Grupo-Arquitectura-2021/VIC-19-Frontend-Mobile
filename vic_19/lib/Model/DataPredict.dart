class DataPredict{
  List<double> _x;
  List<double> _y;

  List<double> get x => _x;

  set x(List<double> value) {
    _x = value;
  }

  List<double> get y => _y;

  set y(List<double> value) {
    _y = value;
  }

  DataPredict(this._x, this._y);
}