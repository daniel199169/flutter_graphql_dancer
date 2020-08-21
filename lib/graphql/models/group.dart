import 'package:dancer/graphql/models/user.dart';

class Group {
  int id;
  String name;
  User admin;

  static Group fromJson(Map<String, dynamic> json) {
    //print("Group.fromJson: $json");
    Group group = Group();
    group.id = json["id"];
    group.name = json["name"];
    if (json.containsKey("admin")) {
      //print("group has admin?");
      group.admin = User.fromJson(json["admin"]);
    }
    return group;
  }
    /*: id = json['id']
    , name = json['name']
    , admin = User.fromJson(json['admin'])
  ;*/

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'admin': admin.toJson(),
  };
}

