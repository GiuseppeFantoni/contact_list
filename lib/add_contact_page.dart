import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/entitys/contact_list_entity.dart';
import 'package:lista_contatos/manager/contact_list_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lista_contatos/services/via_cep_service.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var cep = TextEditingController(text: '');
  var logradouro = TextEditingController(text: '');
  var telefone = TextEditingController(text: '');
  var numeroLogradouro = TextEditingController(text: '');
  var complemento = TextEditingController(text: '');
  var bairro = TextEditingController(text: '');
  var cidade = TextEditingController(text: '');

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    cep.dispose();
    logradouro.dispose();
    numeroLogradouro.dispose();
    bairro.dispose();
    cidade.dispose();
    telefone.dispose();
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
        validateCep(cep.text) &&
        logradouro.text != '' &&
        numeroLogradouro.text != '' &&
        bairro.text != '') {
      ContactListManager().addUser(ContactList(
        name: name.text,
        email: email.text,
        cep: cep.text,
        telefone: telefone.text,
        logradouro: logradouro.text,
        numeroLogradouro: numeroLogradouro.text,
        bairro: bairro.text,
        cidade: cidade.text,
        complemento: complemento.text == '' ? null : complemento.text,
      ).toJson(false));

      name.clear();
      email.clear();
      cep.clear();
      logradouro.clear();
      numeroLogradouro.clear();
      complemento.clear();
      bairro.clear();
      cidade.clear();
      telefone.clear();

      FocusScope.of(context).unfocus();

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

  validateCep(cep) {
    if (cep.length == 0 || cep.length == 8) {
      return true;
    }
    return false;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  child: Text("Adicionar Contato")),
            ),
          ],
        ),
      ),
    );
  }
}
