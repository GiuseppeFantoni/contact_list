import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/contact_list_page.dart';
import 'package:lista_contatos/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var login = '';
  var password = '';

  showAlertDialogError() {
    if (password != '' && login != '') {
      login = '';
      password = '';

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));

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
        title: 'Bem vindo!',
        desc: 'Login feito com sucesso',
      )..show();
    }

    return AwesomeDialog(
      dialogBackgroundColor: Colors.white,
      context: context,
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      width: 400,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(8)),
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      dialogType: DialogType.ERROR,
      title: 'Aviso',
      desc: 'Login ou senha invalidos',
      showCloseIcon: true,
      btnOkColor: Colors.red[400],
      btnOkOnPress: () {},
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.softLight),
                    image: AssetImage('assets/images/background2.jpg'))),
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
                    // Image(
                    //   //image: AssetImage('assets/images/loginLogo.png'),
                    //   width: 100,
                    //   height: 100,
                    // ),
                    Text(
                      "Contatos",
                      style: GoogleFonts.petrona(
                        textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 60,
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
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                            style: (TextStyle(color: Colors.green)),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  color: Colors.green,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: "Email ou Usuarioo",
                              hintStyle: TextStyle(color: Colors.green),
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
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          style: (TextStyle(color: Colors.green)),
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.vpn_key_rounded,
                                color: Colors.green,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Senha",
                            hintStyle: TextStyle(color: Colors.green),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ClipOval(
                              child: Material(
                                color: Colors.green
                                    .withOpacity(0.3), // button color
                                child: InkWell(
                                  splashColor: Colors.green, // inkwell color
                                  child: SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.green,
                                      )),
                                  onTap: () {
                                    showAlertDialogError();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.green,
                      height: 10,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        "Clique aqui para criar uma conta.",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
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
