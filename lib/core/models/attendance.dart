class Attendance {
  String id, name, date, hour, branch, photo;

  Attendance(
      {this.branch, this.name, this.id, this.date, this.hour, this.photo});

  Attendance.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        branch = snapshot['branch'] ?? '',
        hour = snapshot['hour'] ?? '',
        photo = snapshot['photo'] ?? '',
        date = snapshot['date'];

  toJson() {
    return {
      "name": name,
      "branch": branch,
      "hour": hour,
      "photo": photo,
      "date": date,
    };
  }
}
