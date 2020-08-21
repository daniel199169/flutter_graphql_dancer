import 'dart:convert';

import 'package:dancer/graphql/models/group.dart';
import 'package:dancer/graphql/models/event.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String phone;
  String email;
  String firstName;
  String lastName;
  String contact1;
  String contact2;
  List<String> roles;
  Group group;
  List<Event> events;
  double ranking;
  int myRank;
  int age;
  String country;
  String about;
  String currentSchool;
  String linkInstagram;
  String linkTiktok;
  String linkFacebook;
  String profileImage;

  User({
    this.id,
    this.phone,
    this.firstName,
    this.lastName,
    this.email = "",
    this.contact1 = "",
    this.contact2 = "",
    this.roles,
    this.group,
    this.events,
    this.ranking = 0,
    this.myRank,
    this.age,
    this.country,
    this.about,
    this.currentSchool,
    this.linkInstagram,
    this.linkTiktok,
    this.linkFacebook,
    this.profileImage,
  });

  bool isTeacher() {
    return roles[0] == "teacher";
  }

  bool isDancer() {
    return roles[0] == "user";
  }

  bool isGuardian() {
    return roles[0] == "admin";
  }

  String name() {
    return firstName + " " + lastName;
  }

  Widget getProfileImage({double height: 80, double width: 80, fit: BoxFit.cover}) {
    try {
      if (profileImage != null && profileImage.isEmpty) {
        return Image.network(
          profileImage,
          height: height,
          width: width,
          fit: fit,
        );
      }
    } catch (Exception) {
    }
    return Image.asset(
      'assets/images/profile.png',
      height: height,
      width: width,
      fit: fit,
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    //print("User.fromJson: $json");
    User user = User();
    user.ranking = 0;

    user.id = int.parse(json["id"]);
    user.phone = json["phone"];
    user.firstName = json["firstName"];
    user.lastName = json["lastName"];
    user.roles = (json["roles"] as List<dynamic>).cast<String>();

    if (json.containsKey("contact1") && json["contact1"] != null) user.contact1 = json["contact1"];
    if (json.containsKey("contact2") && json["contact2"] != null) user.contact2 = json["contact2"];
    if (json.containsKey("email") && json["email"] != null) user.email = json["email"];

    if (json.containsKey("groups") && json["groups"] != null) {
      try {
        user.group = Group.fromJson(json["groups"][0]);
      } catch (Exception) {
      }
    }

    if (json.containsKey("events") && json["events"] != null) user.events = List<Event>.from(json["events"].map((i) => Event.fromJson(i)));
    if (json.containsKey("ranking") && json["ranking"] != null) {
      try {
        user.ranking = json["ranking"];
      } catch (Exception) {
        user.ranking = 0;
      }
    }
    if (json.containsKey("myRank") && json["myRank"] != null) user.myRank = json["myRank"];
    if (json.containsKey("age") && json["age"] != null) user.age = json["age"];
    if (json.containsKey("about") && json["about"] != null) user.about = json["about"];
    if (json.containsKey("currentSchool") && json["currentSchool"] != null) user.currentSchool = json["currentSchool"];
    if (json.containsKey("linkInstagram") && json["linkInstagram"] != null) user.linkInstagram = json["linkInstagram"];
    if (json.containsKey("linkTiktok") && json["linkTiktok"] != null) user.linkTiktok = json["linkTiktok"];
    if (json.containsKey("linkFacebook") && json["linkFacebook"] != null) user.linkFacebook = json["linkFacebook"];
    if (json.containsKey("profileImage") && json["profileImage"] != null) user.profileImage = json["profileImage"];

    return user;
  }
    /*: id = json['id']
    , phone = json['phone']
    , email = json['email']
    , firstName = json['firstName']
    , lastName = json['lastName']
    , contact1 = json['contact1']
    , contact2 = json['contact2']
    , roles = (json["roles"] as List<dynamic>).cast<String>()
    , group = Group.fromJson(json["groups"][0])
    , events = List<Event>.from(json["events"].map((i) => Event.fromJson(i)))
  ;*/

  Map<String, dynamic> toJson() => {
    'id': id,
    'phone': phone,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'contact1': contact1,
    'contact2': contact2,
    'roles': roles,
    'groups': group,
    'events': events,
    'ranking': ranking,
    'myRank': myRank,
    'about': about,
    'age': age,
    'country': country,
    'currentSchool': currentSchool,
    'linkInstagram': linkInstagram,
    'linkTikTok': linkTiktok,
    'linkFacebook': linkFacebook,
    'profileImage': profileImage,
  };

}

