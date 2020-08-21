class Location {
  final int id;
  final String name;
  final String address;
  final String geoLat;
  final String geoLng;
  final String type;
  final String openingHours;
  final String category;

  //Location(this.id, this.name, this.address, this.geoLat, this.geoLng, this.type);

  Location.fromJson(Map<String, dynamic> json)
    : id = json['id']
    , name = json['name']
    , address = json["address"]
    , geoLat = json["geoLat"]
    , geoLng = json["geoLng"]
    , type = json["type"]
    , openingHours = json["openingHours"]
    , category = json["category"]
  ;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'geoLat': geoLat,
    'geoLng': geoLng,
    'type': type,
    'openingHours': openingHours,
    'category': category,
  };
}
