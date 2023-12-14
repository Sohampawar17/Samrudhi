class NotesList {
  int? name;
  String? note;
  String? commented;
  String? addedOn;
  String? image;

  NotesList({this.name, this.note, this.commented, this.addedOn, this.image});

  NotesList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    note = json['note'];
    commented = json['commented'];
    addedOn = json['added_on'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['note'] = this.note;
    data['commented'] = this.commented;
    data['added_on'] = this.addedOn;
    data['image'] = this.image;
    return data;
  }
}
