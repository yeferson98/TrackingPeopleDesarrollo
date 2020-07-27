import 'package:json_annotation/json_annotation.dart';
part 'people.json.dart';

@JsonSerializable()
class PeopleModel {
  int idCliente;
  String name;
  String lastname;
  String email;
  String urlImage;
  String user;
  String date;
  PeopleModel(
      {this.idCliente,
      this.name,
      this.lastname,
      this.email,
      this.urlImage,
      this.user,
      this.date});

  factory PeopleModel.formJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);
  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);
}

class AddressSeach {
  String address;
  AddressSeach({this.address});
}
