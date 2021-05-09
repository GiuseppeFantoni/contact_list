import 'package:cloud_firestore/cloud_firestore.dart';

class ContactListService {
  Future getContactListFirebase() async {
    return await FirebaseFirestore.instance
        .collection('contacts')
        .orderBy('name')
        .get()
        .then((QuerySnapshot querySnapshot) {
      return checkresponse(querySnapshot.docs);
    });
  }

  checkresponse(response) {
    var list = [];
    if (response.length == 0) return [];
    response.forEach((element) {
      print(element);
      list.add({
        "name": element["name"],
        "email": element["email"],
        "endereco": element["endereco"],
        "cep": element["cep"],
        "telefone": element["telefone"],
        "doc_id": element["doc_id"],
        "isExpanded": false
      });
    });
    return list;
  }
}
