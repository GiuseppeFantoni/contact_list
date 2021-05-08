import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './manager/contact_list_manager.dart';

class ContactList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var _numberString = useState([]);

    useEffect(
      () {
        var result = getContactList(1);
        _numberString.value = result;
      },
      [],
    );

    void atualizarLista() {
      var result = getContactList(1);
      _numberString.value = result;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          atualizarLista();
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
      body: new ListView.separated(
        itemCount: _numberString.value.length,
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
                Text(_numberString.value[index]['nome']),
                Text("giuseppeFant07@gmail.com"),
              ],
            )),
          );
        },
      ),
    );
  }
}
