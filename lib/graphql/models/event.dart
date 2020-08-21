import 'package:dancer/graphql/models/location.dart';
import 'package:dancer/graphql/models/user.dart';

class Event {
  int id;
  String name;
  DateTime startsAt;
  DateTime endsAt;
  String type;
  bool recurring;
  Location location;
  User teacher;
  String description;

  //Event(this.id, this.name, this.startsAt, this.endsAt, this.type, this.recurring, this.location, this.teacher);

  static Event fromJson(Map<String, dynamic> json) {
    //print("Event.fromJson: $json");
    Event e = Event();
    e.id = json["id"] as int;
    e.name = json["name"];
    e.startsAt = DateTime.parse(json["startsAt"]);
    e.endsAt = DateTime.parse(json["endsAt"]);
    e.type = json["type"];
    e.recurring = json["recurring"] as bool;
    e.location = Location.fromJson(json["location"]);
    if (json.containsKey("teacher") && json["teacher"] != null) e.teacher = User.fromJson(json["teacher"]);
    e.description = json["description"];

    return e;
  }
    /*: id = json['id']
    , name = json['name']
    , startsAt = DateTime.parse(json['startsAt'])
    , endsAt = DateTime.parse(json['endsAt'])
    , type = json['type']
    , recurring = json["recurring"]
    , location = Location.fromJson(json["location"])
    , teacher = User.fromJson(json.containsKey("admin") == true ? json["admin"] : json["teacher"])
  ;*/

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'startsAt': startsAt,
    'endsAt': endsAt,
    'type': type,
    'recurring': recurring,
    'location': location.toJson(),
    'teacher': teacher.toJson(),
    'description': description,
  };
}
