import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ContactList {
  ContactList({
    @required this.name,
    @required this.email,
    @required this.telefone,
    @required this.cep,
    @required this.logradouro,
    @required this.numeroLogradouro,
    @required this.bairro,
    @required this.cidade,
    this.complemento,
  });

  ContactList.fromJson(Map<String, Object> json)
      : this(
          name: json['name'] as String,
          email: json['email'] as String,
          telefone: json['telefone'] as String,
          cep: json['cep'] as String,
          logradouro: json['endereco'] as String,
          numeroLogradouro: json["numeroLogradouro"] as String,
          bairro: json["bairro"] as String,
          cidade: json["cidade"] as String,
          complemento: json["complemento"] as String,
        );

  final String name;
  final String email;
  final String telefone;
  final String cep;
  final String logradouro;
  final String numeroLogradouro;
  final String bairro;
  final String cidade;
  final String complemento;

  Map<String, Object> toJson(isEditing) {
    if (isEditing) {
      return {
        'name': name,
        'email': email,
        'telefone': telefone,
        'cep': cep,
        'logradouro': logradouro,
        'numeroLogradouro': numeroLogradouro,
        'bairro': bairro,
        'cidade': cidade,
        "complemento": complemento
      };
    }
    return {
      'name': name,
      'email': email,
      'telefone': telefone,
      'cep': cep,
      'logradouro': logradouro,
      'numeroLogradouro': numeroLogradouro,
      'bairro': bairro,
      'cidade': cidade,
      'complemento': complemento,
      "doc_id": Uuid().v4()
    };
  }
}
