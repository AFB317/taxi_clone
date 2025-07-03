class DriversP{
  dynamic id,lng,lat;

  DriversP.fromJson(Map json){
    id = json['driver_id'];
    lng = json['location']['lng'];
    lat = json['location']['lat'];
  }
}