/// Model for image location.
class Location {
  var data;

  Location(this.data);

  String getCity() {
    return data['city'];
  }

  String getCountry() {
    return data['country'];
  }
}
