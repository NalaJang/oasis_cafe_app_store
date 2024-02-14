class UserModel {

  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userDateOfBirth = '';
  String userMobileNumber = '';
  bool notification = false;

  UserModel(this.userName, this.userEmail, this.userPassword, this.userMobileNumber);

  Map<String, dynamic> setData() {
    return {
      'signUpTime' : DateTime.now(),
      'signInTime' : DateTime.now(),
      'signOutTime' : DateTime.now(),
      'userEmail' : userEmail,
      'userPassword' : userPassword,
      'userName' : userName,
      'userMobileNumber' : userMobileNumber,
      'notification' : notification,
    };
  }
}