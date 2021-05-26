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

  Future getContactListWithId(docId) async {
    var document = FirebaseFirestore.instance.collection('contacts').doc(docId);
    return document.get().then((value) => checkresponseItem(value));
  }

  checkresponseItem(item) {
    return {
      "name": item["name"],
      "email": item["email"],
      "telefone": item["telefone"],
      "cep": item["cep"],
      "endereco": item["endereco"]
    };
  }
}
