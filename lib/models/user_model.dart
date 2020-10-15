class UserModel {
  String uid;
  String email;

  UserModel({this.uid, this.email});

  UserModel.frommap(Map<String, String> map) {
    this.uid = map['uid'];
    this.email = map['email'];
  }

  Map<String, String> toMap(){
    return <String, String> {
      'uid': this.uid,
      'email': this.email
    };
  }

}