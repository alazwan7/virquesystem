class Request {
  final String token;
  final String senior_citizen;

  final String disable;
  final String currentLocation;
  final String distance;
  final String user_id;



  Request({
    this.token,
    this.senior_citizen,
    this.disable,
    this.currentLocation,
    this.distance,
    this.user_id});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      token: json['token'],

      senior_citizen: json['senior_citizen'],
      disable: json['disable'],
      currentLocation: json['currentLocation'],
      distance: json['distance'],
      user_id: json['user_id'],

    );
  }
}
