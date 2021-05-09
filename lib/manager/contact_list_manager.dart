import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/contact_list_service.dart';

class ContactListManager {
  Future getContactListFirebase() async {
    return await ContactListService().getContactListFirebase();
  }

  Future<void> deleteUser(docId) {
    CollectionReference contacts =
        FirebaseFirestore.instance.collection('contacts');
    return contacts
        .doc(docId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> addUser(contact) {
    CollectionReference contacts =
        FirebaseFirestore.instance.collection('contacts');

    return contacts
        .doc(contact['doc_id'])
        .set(contact)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
