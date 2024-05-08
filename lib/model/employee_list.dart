
class EmployeeAssignerDetails {

  String? id;
  String? employeeName;

  EmployeeAssignerDetails({
    this.id,
    this.employeeName,
  });

  EmployeeAssignerDetails.fromJson(dynamic json) {
    id = json['name']!.toString();
    employeeName = json['employee_name']!.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = id;
    data['employee_name'] = employeeName;
    return data;
  }
}
