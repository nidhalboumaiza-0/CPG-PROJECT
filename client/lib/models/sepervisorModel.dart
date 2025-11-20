class Supervisor {
  String? picture;

  String? firstName;
  String? lastName;

  String? email;
  String? phoneNumber;
  String? workStation;
  String? matricule;
  int? internNumber;
  bool? supervisorStatus;
  var id;

  Supervisor(
      {this.picture,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.workStation,
      this.matricule,
      this.internNumber,
      this.supervisorStatus,
      this.id});
}
