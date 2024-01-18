class AttendanceDashboard {
  String? monthTitle;
  int? tillDays;
  int? totalDays;
  double? dayOff;
  double? present;
  double? absent;

  AttendanceDashboard(
      {this.monthTitle,
        this.tillDays,
        this.totalDays,
        this.dayOff,
        this.present,
        this.absent});

  AttendanceDashboard.fromJson(Map<String, dynamic> json) {
    monthTitle = json['month_title'];
    tillDays = json['till_days'];
    totalDays = json['total_days'];
    dayOff = json['day off'];
    present = json['present'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_title'] = this.monthTitle;
    data['till_days'] = this.tillDays;
    data['total_days'] = this.totalDays;
    data['day off'] = this.dayOff;
    data['present'] = this.present;
    data['absent'] = this.absent;
    return data;
  }
}
