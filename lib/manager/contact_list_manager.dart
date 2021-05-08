import 'package:cloud_firestore/cloud_firestore.dart';

class ContactListManager {
  Future getListFirebase() async {
    var list = [];
    await FirebaseFirestore.instance
        .collection('teste')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        list.add({"name": element["name"], "email": element["email"]});
      });
    });
    return list;
  }
}
