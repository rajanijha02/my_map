class LocationHistory {
  String? date;
  int? location;

  LocationHistory({this.date, this.location});

  LocationHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['location'] = this.location;
    return data;
  }
}
