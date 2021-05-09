import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BodyList extends StatelessWidget {
  final dynamic itemLista;
  final deleteUser;

  BodyList(this.itemLista, this.deleteUser);

  @override
  Widget build(BuildContext context) {
    deleteContact() {
      AwesomeDialog(
        context: context,
        width: 400,
        dialogType: DialogType.QUESTION,
        buttonsBorderRadius: BorderRadius.all(Radius.circular(8)),
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Você realmente deseja excluir este contato?',
        showCloseIcon: true,
        btnCancelText: "Cancelar",
        btnOkText: "Sim",
        btnOkColor: Colors.red[400],
        btnCancelColor: Colors.grey[600],
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          deleteUser(itemLista["doc_id"]);
        },
      )..show();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Telefone:",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['telefone'],
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Endereco:",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['endereco'],
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Cep:",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['cep'],
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4e4376),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Text(
                        "Editar",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4e4376),
                      ),
                      onPressed: () {
                        deleteContact();
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          "Exlcuir",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
