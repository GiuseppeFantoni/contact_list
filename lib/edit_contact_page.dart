import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/entitys/contact_list_entity.dart';
import 'package:lista_contatos/manager/contact_list_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lista_contatos/services/via_cep_service.dart';

class EditContactPage extends StatefulWidget {
  final String docID;
  final dynamic fetchDatabaseList;

  const EditContactPage({Key key, this.docID, this.fetchDatabaseList})
      : super(key: key);
  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  dynamic contact;

  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var cep = TextEditingController(text: '');
  var logradouro = TextEditingController(text: '');
  var telefone = TextEditingController(text: '');
  var numeroLogradouro = TextEditingController(text: '');
  var bairro = TextEditingController(text: '');
  var cidade = TextEditingController(text: '');
  var complemento = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    getContactWithId();
  }

  getContactWithId() async {
    dynamic resultant =
        await ContactListManager().getContactListWithId(widget.docID);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        contact = resultant;
      });
    }

    name.text = contact["name"];
    email.text = contact["email"];
    cep.text = contact["cep"];
    telefone.text = contact["telefone"];
    logradouro.text = contact["logradouro"];
    numeroLogradouro.text = contact["numeroLogradouro"];
    bairro.text = contact["bairro"];
    cidade.text = contact["cidade"];
    complemento.text = contact['complemento'];
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    cep.dispose();
    logradouro.dispose();
    telefone.dispose();
    bairro.dispose();
    cidade.dispose();
    numeroLogradouro.dispose();
    complemento.dispose();
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
        logradouro.text != '') {
      ContactListManager().updateUser(
          ContactList(
                  name: name.text,
                  email: email.text,
                  cep: cep.text,
                  telefone: telefone.text,
                  logradouro: logradouro.text,
                  numeroLogradouro: numeroLogradouro.text,
                  bairro: bairro.text,
                  cidade: cidade.text,
                  complemento: complemento.text == '' ? null : complemento.text)
              .toJson(true),
          widget.docID);

      name.clear();
      email.clear();
      cep.clear();
      bairro.clear();
      cidade.clear();
      complemento.clear();
      logradouro.clear();
      numeroLogradouro.clear();
      telefone.clear();

      FocusScope.of(context).unfocus();

      widget.fetchDatabaseList();

      return AwesomeDialog(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
        dialogBackgroundColor: Colors.white,
        context: context,
        btnOkOnPress: () {
          Navigator.pop(context);
        },
        btnOkColor: Color(0xFF4e4376),
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
        width: 400,
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Contato Atualizado com sucesso!',
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

  Future _searchCep() async {
    final resultCep = await ViaCepService.fetchCep(cep: cep.text);

    if (resultCep.logradouro == null) {
      return AwesomeDialog(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          dialogBackgroundColor: Colors.white,
          context: context,
          autoHide: Duration(seconds: 2),
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
          width: 400,
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          dialogType: DialogType.ERROR,
          title: 'Erro ao buscar Cep',
          desc: 'Verifique se é um cep válido')
        ..show();
    }

    setState(() {
      logradouro.text = resultCep.logradouro;
      complemento.text = resultCep.complemento;
      bairro.text = resultCep.bairro;
      cidade.text = resultCep.localidade;
    });
  }

  validateCep(cep) {
    if (cep.length == 0 || cep.length == 8) {
      return true;
    }
    return false;
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
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 190,
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
                      width: 155,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (telefone) =>
                            validatePhoneNumberForm(telefone)
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
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
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 210,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (cep) =>
                            validateCep(cep) ? null : "Cep inválido",
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
                        width: 135,
                        height: 59,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4e4376),
                              textStyle: TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                            onPressed: () {
                              _searchCep();
                            },
                            child: Text("Buscar CEP"))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 210,
                      child: TextFormField(
                        controller: logradouro,
                        decoration: InputDecoration(
                          labelText: 'Logradouro',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.home),
                        ),
                      ),
                    ),
                    Container(
                      width: 135,
                      child: TextFormField(
                        controller: numeroLogradouro,
                        decoration: InputDecoration(
                          labelText: 'Número',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.looks_one_sharp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 7.0),
                child: TextFormField(
                  controller: complemento,
                  decoration: InputDecoration(
                    labelText: 'Complemento',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.home_work),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
                child: TextFormField(
                  controller: bairro,
                  decoration: InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.streetview),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
                child: TextFormField(
                  controller: cidade,
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.map),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
