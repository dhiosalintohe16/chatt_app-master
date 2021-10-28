class UserModel {
  String? uid;
  String? name;
  String? email;
  String? creationTime;
  String? lastSignInTime;
  String? photoUrl;
  String? updateTime;
  String? phoneNumber;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.creationTime,
      this.lastSignInTime,
      this.photoUrl,
      this.updateTime,
      this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    creationTime = json['creationTime'];
    lastSignInTime = json['lastSignInTime'];
    photoUrl = json['photoUrl'];
    updateTime = json['updateTime'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['creationTime'] = creationTime;
    data['lastSignInTime'] = lastSignInTime;
    data['photoUrl'] = photoUrl;
    data['updateTime'] = updateTime;
    data['phoneNumber'] = phoneNumber;
    return data;
  }

  
}
