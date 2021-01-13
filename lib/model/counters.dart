class Counters {
  final String token;
  final String counter_mode;
  final String counter_name;
  final String counter_status;
  final String user_id;



  Counters({
    this.token,
    this.counter_mode,
    this.counter_name,
    this.counter_status,
    this.user_id});

  factory Counters.fromJson(Map<String, dynamic> json) {
    return Counters(
      token: json['token'],
      counter_mode: json['counter_mode'],
      counter_name: json['counter_name'],
      counter_status: json['counter_status'],
      user_id: json['user_id'],

    );
  }
}
