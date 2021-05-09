import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/entitys/contact_list_entity.dart';
import 'package:lista_contatos/manager/contact_list_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EditContactPage extends StatefulWidget {
  final String docID;
  final dynamic fetchDatabaseList;

  const EditContactPage({Key key, this.docID, this.fetchDatabaseList})
      : super(key: key);
  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var cep = TextEditingController(text: '');
  var endereco = TextEditingController(text: '');
  var telefone = TextEditingController(text: '');

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    cep.dispose();
    endereco.dispose();
    telefone.dispose();
    super.dispose();
  }

  bool validatePhoneNumberForm(phoneNumber) {
    if (phoneNumber.toString().length == 0 ||
        phoneNumber.toString().length >= 8) {
      return true;
    }
    return false;
  }

  bool validatePhoneNumber(phoneNumber) {
    return phoneNumber.toString().length >= 8;
  }

  bool validateEmailForm(email) {
    if (email.length == 0 || EmailValidator.validate(email)) {
      return true;
    }
    return false;
  }

  adicionarContato() {
    if (name.text != '' &&
        validatePhoneNumber(telefone.text) &&
        EmailValidator.validate(email.text) &&
        cep.text != '' &&
        endereco.text != '') {
      ContactListManager().updateUser(
          ContactList(
                  name: name.text,
                  email: email.text,
                  cep: cep.text,
                  telefone: telefone.text,
                  endereco: endereco.text)
              .toJson(true),
          widget.docID);

      name.clear();
      email.clear();
      cep.clear();
      endereco.clear();
      telefone.clear();

      widget.fetchDatabaseList();

      return AwesomeDialog(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
        dialogBackgroundColor: Colors.white,
        context: context,
        autoHide: Duration(seconds: 2),
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
        width: 400,
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Contato Inserido com sucesso!',
      )..show();
    } else {
      return AwesomeDialog(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          dialogBackgroundColor: Colors.white,
          context: context,
          autoHide: Duration(seconds: 3),
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
          width: 400,
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          dialogType: DialogType.WARNING,
          title: 'Dado Invalido',
          desc: 'Verifique se todos os dados estão preenchidos corretamente')
        ..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        centerTitle: true,
        backwardsCompatibility: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2b5876), Color(0xFF4e4376)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                child: TextFormField(
                  controller: name,
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
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (telefone) => validatePhoneNumberForm(telefone)
                      ? null
                      : "Telefone inválido",
                  controller: telefone,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      validateEmailForm(email) ? null : "Email inválido",
                  controller: email,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: cep,
                  decoration: InputDecoration(
                    labelText: 'Cep',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.add_location_alt),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: TextFormField(
                  controller: endereco,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.home),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4e4376),
                      textStyle:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    onPressed: () {
                      adicionarContato();
                    },
                    child: Text("Atualizar Contato")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
