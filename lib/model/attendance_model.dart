class attendancedetails {
  AttendanceDetails? attendanceDetails;
  List<AttendanceList>? attendanceList;

  attendancedetails({this.attendanceDetails, this.attendanceList});

  attendancedetails.fromJson(Map<String, dynamic> json) {
    attendanceDetails = json['attendance_details'] != null
        ? new AttendanceDetails.fromJson(json['attendance_details'])
        : null;
    if (json['attendance_list'] != null) {
      attendanceList = <AttendanceList>[];
      json['attendance_list'].forEach((v) {
        attendanceList!.add(new AttendanceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendanceDetails != null) {
      data['attendance_details'] = this.attendanceDetails!.toJson();
    }
    if (this.attendanceList != null) {
      data['attendance_list'] =
          this.attendanceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceDetails {
  int? daysInMonth;
  int? present;
  int? absent;
  int? late;

  AttendanceDetails({this.daysInMonth, this.present, this.absent, this.late});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    daysInMonth = json['days_in_month'];
    present = json['present'];
    absent = json['absent'];
    late = json['late'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days_in_month'] = this.daysInMonth;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['late'] = this.late;
    return data;
  }
}

class AttendanceList {
  String? attendanceDate;
  double? workingHours;
  double? inTime;
  double? outTime;

  AttendanceList(
      {this.attendanceDate, this.workingHours, this.inTime, this.outTime});

  AttendanceList.fromJson(Map<String, dynamic> json) {
    attendanceDate = json['attendance_date'];
    workingHours = json['working_hours'];
    inTime = json['in_time'];
    outTime = json['out_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_date'] = this.attendanceDate;
    data['working_hours'] = this.workingHours;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    return data;
  }
}
