class Client {
  String id, name, date, hour, branch;
  Client({this.branch, this.name, this.id, this.date, this.hour});

  Client.fromMap(Map snapshot, String id)
      : id = id ?? "",
        name = snapshot['name'] ?? '',
        branch = snapshot['branch'] ?? '',
        hour = snapshot['hour'] ?? '',
        date = snapshot['date'];

  toJson() {
    return {
      "name": name,
      "branch": branch,
      "hour": hour,
      "date": date,
    };
  }
}
