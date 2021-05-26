import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/create_login_page.dart';
import 'package:lista_contatos/services/authentication_service.dart';
import 'package:lista_contatos/shared/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var login = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    entrar() async {
      var response = await context.read<AuthenticationService>().signIn(
            login: login.trim(),
            password: password.trim(),
          );

      var possuiErro = verifyError(response);

      if (possuiErro != '') {
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
          desc: possuiErro,
          showCloseIcon: true,
          btnOkColor: Color(0xFF4e4376),
          btnOkOnPress: () {},
        )..show();
      }
      FocusScope.of(context).unfocus();
    }

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
                )))),
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
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
                            onChanged: (value) {
                              setState(() {
                                login = value;
                              });
                            }),
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
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Esqueceu sua senha?",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
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
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4e4376),
                            ),
                            onPressed: () {
                              entrar();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Text(
                                "Entrar",
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
                    const Divider(
                      height: 10,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Nao tem uma conta ainda?",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CreateLoginPage()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                " Clique aqui",
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                        ],
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
