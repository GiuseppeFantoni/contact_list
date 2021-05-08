import 'package:flutter/material.dart';
import './manager/contact_list_manager.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List contactsList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await ContactListManager().getListFirebase();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        contactsList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView.separated(
        itemCount: contactsList.length,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            height: 50,
            child: Center(
                child: Column(
              children: [
                Text(contactsList[index]['name']),
                Text(contactsList[index]['email']),
              ],
            )),
          );
        },
      ),
    );
  }
}
