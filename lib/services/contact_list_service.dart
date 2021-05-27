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
        "logradouro": element["logradouro"],
        "cep": element["cep"],
        "telefone": element["telefone"],
        "doc_id": element["doc_id"],
        "numeroLogradouro": element["numeroLogradouro"],
        "cidade": element["cidade"],
        "bairro": element["bairro"],
        "complemento": element["complemento"],
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
    print(item);
    return {
      "name": item["name"],
      "email": item["email"],
      "telefone": item["telefone"],
      "cep": item["cep"],
      "logradouro": item["logradouro"],
      "numeroLogradouro": item["numeroLogradouro"],
      "cidade": item["cidade"],
      "bairro": item["bairro"],
      "complemento": item["complemento"]
    };
  }
}
