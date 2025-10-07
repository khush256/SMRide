class FetchRequestModel {
  String? requestID;
  String? userId;
  String? location;
  String? time;
  String? createdAt;

  FetchRequestModel(
      {this.requestID, this.userId, this.location, this.time, this.createdAt});

  FetchRequestModel.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    userId = json['userId'];
    location = json['location'];
    time = json['time'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['userId'] = this.userId;
    data['location'] = this.location;
    data['time'] = this.time;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
