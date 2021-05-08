import '../services//contact_list_service.dart';

List<Map<String, dynamic>> getContactList(idUsuario) {
  const list = [
    {"nome": "Giuseppe Fantoni", "telefone": "32453252345", "idade": 24},
    {"nome": "Tulio Imundo", "telefone": "276423245", "idade": 25}
  ];

  const list2 = [
    {"nome": "Hugo", "telefone": "32453252345", "idade": 24},
    {"nome": "Amanda", "telefone": "276423245", "idade": 25}
  ];

  var result = getContactListService(idUsuario);
  if (result.length == 0) return null;
  if (idUsuario == 1) {
    return list;
  }
  return list2;
}
