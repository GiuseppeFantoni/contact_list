import 'package:cloud_firestore/cloud_firestore.dart';

class ContactListManager {
  Future getListFirebase() async {
    var list = [];
    await FirebaseFirestore.instance
        .collection('contacts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        list.add({
          "name": element["name"],
          "email": element["email"],
          "endereco": element["endereco"],
          "cep": element["cep"],
          "telefone": element["telefone"],
          "isExpanded": false
        });
      });
    });
    return list;
  }
}
