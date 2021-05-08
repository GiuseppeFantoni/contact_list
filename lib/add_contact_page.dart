import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddContactPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var name = useState("");
    var email = useState("");
    var cep = useState("");
    var adreess = useState("");
    var telefone = useState("");

    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
            child: TextFormField(
              initialValue: name.value,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.person,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
            child: TextFormField(
              initialValue: email.value,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.email,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
            child: TextFormField(
              initialValue: cep.value,
              decoration: InputDecoration(
                labelText: 'Cep',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.add_location_alt),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
            child: TextFormField(
              initialValue: adreess.value,
              decoration: InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.home),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: TextFormField(
              initialValue: telefone.value,
              decoration: InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.phone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
