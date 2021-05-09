import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ContactList {
  ContactList(
      {@required this.name,
      @required this.email,
      @required this.telefone,
      @required this.cep,
      @required this.endereco});

  ContactList.fromJson(Map<String, Object> json)
      : this(
          name: json['name'] as String,
          email: json['email'] as String,
          telefone: json['telefone'] as String,
          cep: json['cep'] as String,
          endereco: json['endereco'] as String,
        );

  final String name;
  final String email;
  final String telefone;
  final String cep;
  final String endereco;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'email': email,
      'telefone': telefone,
      'cep': cep,
      'endereco': endereco,
      "doc_id": Uuid().v4()
    };
  }
}
