class EmployeeDetails {
  String? employeeName;
  String? designation;
  String? name;
  String? dateOfJoining;
  String? dateOfBirth;
  String? gender;
  String? companyEmail;
  String? personalEmail;
  String? cellNumber;
  String? emergencyPhoneNumber;
  String? employeeImage;

  EmployeeDetails(
      {this.employeeName,
        this.designation,
        this.name,
        this.dateOfJoining,
        this.dateOfBirth,
        this.gender,
        this.companyEmail,
        this.personalEmail,
        this.cellNumber,
        this.emergencyPhoneNumber,
        this.employeeImage});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    employeeName = json['employee_name'];
    designation = json['designation'];
    name = json['name'];
    dateOfJoining = json['date_of_joining'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    companyEmail = json['company_email'];
    personalEmail = json['personal_email'];
    cellNumber = json['cell_number'];
    emergencyPhoneNumber = json['emergency_phone_number'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_name'] = this.employeeName;
    data['designation'] = this.designation;
    data['name'] = this.name;
    data['date_of_joining'] = this.dateOfJoining;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['company_email'] = this.companyEmail;
    data['personal_email'] = this.personalEmail;
    data['cell_number'] = this.cellNumber;
    data['emergency_phone_number'] = this.emergencyPhoneNumber;
    data['employee_image'] = this.employeeImage;
    return data;
  }
}
