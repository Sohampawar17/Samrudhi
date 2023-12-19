class ChangePassword {
  String? currentpassword;
  String? newpassword;

  ChangePassword(
      {this.currentpassword,
        this.newpassword,
       });

  ChangePassword.fromJson(Map<String, dynamic> json) {
    currentpassword = json['current_password'];
    newpassword = json['new_password'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_password'] = this.currentpassword;
    data['new_password'] = this.newpassword;
    return data;
  }
}
