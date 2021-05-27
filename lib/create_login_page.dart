import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CreateLoginPage extends StatefulWidget {
  @override
  _CreateLoginPageState createState() => _CreateLoginPageState();
}

class _CreateLoginPageState extends State<CreateLoginPage> {
  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var password = TextEditingController(text: '');

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  criarConta() async {
    var response = await context.read<AuthenticationService>().signUp(
          email: email.text.trim(),
          password: password.text.trim(),
          name: name.text,
        );

    if (response != '') {
      return AwesomeDialog(
        dialogBackgroundColor: Colors.white,
        context: context,
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
        width: 400,
        buttonsBorderRadius: BorderRadius.all(Radius.circular(8)),
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        title: 'Aviso',
        desc: response,
        showCloseIcon: true,
        btnOkColor: Color(0xFF4e4376),
        btnOkOnPress: () {},
      )..show();
    }

    FocusScope.of(context).unfocus();

    name.clear();
    email.clear();
    password.clear();

    return AwesomeDialog(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
      dialogBackgroundColor: Colors.white,
      context: context,
      btnOkColor: Color(0xFF4e4376),
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      width: 400,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      title: 'Usuário criado com sucesso!',
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2b5876), Color(0xFF4e4376)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          Scaffold(
            appBar: AppBar(
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
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ContatosApp",
                            style: GoogleFonts.petrona(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          controller: name,
                          style: (TextStyle(color: Colors.black54)),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.person,
                                color: Colors.black54,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Nome Completo",
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          controller: email,
                          style: (TextStyle(color: Colors.black54)),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.email,
                                color: Colors.black54,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          controller: password,
                          style: (TextStyle(color: Colors.black54)),
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.vpn_key_rounded,
                                color: Colors.black54,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Senha",
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              criarConta();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4e4376),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Text(
                                "Criar Conta",
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
