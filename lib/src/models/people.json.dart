part of 'people.model.dart';

PeopleModel _$PeopleModelFromJson(Map<String, dynamic> json) {
  return PeopleModel(
    idCliente: json['Usu_Codigo'] as int,
    date: json['Usu_Celular'] as String,
    name: json['Usu_Nom'] as String,
    lastname: json['Usu_Ape'] as String,
    email: json['Usu_Email'] as String,
    urlImage: json['Usu_foto'] as String,
    user: json['Usu_Usuario'] as String,
    cargo: json['Tra_Cargo'] as String,
  );
}

Map<String, dynamic> _$PeopleModelToJson(PeopleModel instance) =>
    <String, dynamic>{
      'Usu_Codigo': instance.idCliente,
      'Usu_Celular': instance.date,
      'Usu_Nom': instance.name,
      'Usu_Ape': instance.lastname,
      'Usu_Email': instance.email,
      'Usu_foto': instance.urlImage,
      'Usu_Usuario': instance.user
    };
