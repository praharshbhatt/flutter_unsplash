class User {
  String uid, email, name;

  User(this.uid, this.name, this.email);

  User.fromMap(Map mapUser) {
    uid = mapUser["uid"];
    email = mapUser["email"];
    name = mapUser["name"];
  }
}
