class OperationalModel {
  int? hourStart;
  int? hourEnd;
  int? hourBreakStart;
  int? hourBreakEnd;
  int? sessionDuration;
  int? capacity;

  OperationalModel({
    this.hourStart,
    this.hourEnd,
    this.hourBreakStart,
    this.hourBreakEnd,
    this.sessionDuration,
    this.capacity,
  });

  OperationalModel.fromJson(Map<String, dynamic> json) {
    hourStart = json['hourStart'];
    hourEnd = json['hourEnd'];
    hourBreakStart = json['hourBreakStart'];
    hourBreakEnd = json['hourBreakEnd'];
    sessionDuration = json['sessionDuration'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hourStart'] = this.hourStart;
    data['hourEnd'] = this.hourEnd;
    data['hourBreakStart'] = this.hourBreakStart;
    data['hourBreakEnd'] = this.hourBreakEnd;
    data['sessionDuration'] = this.sessionDuration;
    data['capacity'] = this.capacity;

    return data;
  }
}
