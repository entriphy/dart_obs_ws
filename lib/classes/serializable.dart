class Serializable {
  final Map<String, dynamic> _data;
  Map<String, dynamic> get data => _data;

  Serializable(this._data);

  @override
  String toString() => _data.toString();
}
