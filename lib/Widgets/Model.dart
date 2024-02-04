class Model {
  int? id;
  String? title;
  String? descriptions;
  DateTime? datetime;
  DateTime? impdatetime;

  Model(
      {this.id,
      this.title,
      this.descriptions,
      this.datetime,
      this.impdatetime});

  //factory constructor
  factory Model.fromjson(Map<String, dynamic> map) {
    return Model(
        id: map['id'],
        title: map['title'],
        descriptions: map['descriptions'],
        impdatetime: DateTime.parse(map['impdatetime']),
        datetime: DateTime.parse(map['datetime']));
  }

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "title": title,
      "descriptions": descriptions,
      "datetime": datetime.toString(),
      "impdatetime": impdatetime.toString()
    };
  }
}
