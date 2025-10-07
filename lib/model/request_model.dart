//class to represent each user making a request
class Request {
  final String requestId;
  final String destination;
  final String time;

  Request({
    required this.requestId,
    required this.destination,
    required this.time,
  });
}
