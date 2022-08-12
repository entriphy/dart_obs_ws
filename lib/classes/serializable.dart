class Serializable {
  final Map<String, dynamic> data;

  Serializable(this.data);

  @override
  String toString() => data.toString();
}
