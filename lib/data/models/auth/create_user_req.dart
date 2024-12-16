class CreateUserReq {
  //prompters from page
  final String fullName;
  final String email;
  final String password;
  CreateUserReq(
      {required this.fullName, required this.email, required this.password});
}
