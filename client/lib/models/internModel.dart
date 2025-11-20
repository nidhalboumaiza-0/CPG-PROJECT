class Intern {
  String? picture;
  String? id;
  String? supervisorId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? cin;
  String? genre;
  String? instituteName;
  String? instituteId;
  String? internShipType;
  String? supervisorfirstName;
  String? supervisorlastName;
  DateTime? dateStart;
  DateTime? dateFinish;
  List? absent;
  bool? status;
  bool? affected;

  Intern(
      {this.picture,
      this.id,
      this.firstName,
      this.lastName,
      this.supervisorId,
      this.email,
      this.phoneNumber,
      this.cin,
      this.genre,
      this.instituteName,
      this.instituteId,
      this.internShipType,
      this.supervisorfirstName,
      this.supervisorlastName,
      this.dateStart,
      this.dateFinish,
      this.status,
      this.affected,
      this.absent});
}
