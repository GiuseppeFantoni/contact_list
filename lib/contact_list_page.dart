import 'package:flutter/material.dart';
import 'package:lista_contatos/components/body_list.dart';
import './manager/contact_list_manager.dart';
import 'package:google_fonts/google_fonts.dart';

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
    dynamic resultant = await ContactListManager().getContactListFirebase();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        contactsList = resultant;
      });
    }
  }

  deleteUser(docId) {
    ContactListManager().deleteUser(docId);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              contactsList[index]["isExpanded"] =
                  !contactsList[index]["isExpanded"];
            });
          },
          children: contactsList.map((item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      item['urlImage'] != '' && item['urlImage'] != null
                          ? Container(
                              width: 55.0,
                              height: 55.0,
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'images/profile.jpg',
                                  image: item['urlImage']),
                            )
                          : Container(
                              width: 55.0,
                              height: 55.0,
                              child: Image(
                                  image: AssetImage("images/profile.jpg")),
                            ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        child: Text(
                          item['name'],
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              isExpanded: item["isExpanded"],
              body: BodyList(item, deleteUser, fetchDatabaseList),
            );
          }).toList(),
        )
      ],
    );
  }
}
