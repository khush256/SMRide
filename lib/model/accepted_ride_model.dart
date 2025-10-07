//class to represent each accepted ride of a user
class AcceptedRide {
  late final String acceptedDriverName;
  late final String acceptedDriverNumber;
  late final String destination;
  late final String time;
  late final String rate;

  AcceptedRide({
    required this.acceptedDriverName,
    required this.acceptedDriverNumber,
    required this.destination,
    required this.time,
    required this.rate,
  });

  AcceptedRide.fromJson(Map<String, dynamic> json) {
    acceptedDriverName = json['driverName'];
    acceptedDriverNumber = json['driverPhone'];
    destination = json['location'];
    time = json['time'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverName'] = this.acceptedDriverName;
    data['driverPhone'] = this.acceptedDriverNumber;
    data['location'] = this.destination;
    data['time'] = this.time;
    data['rate'] = this.rate;
    return data;
  }
}
