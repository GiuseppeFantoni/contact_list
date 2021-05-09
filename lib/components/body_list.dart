import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyList extends StatelessWidget {
  final dynamic itemLista;
  final deleteUser;

  BodyList(this.itemLista, this.deleteUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
              child: Row(
                children: [
                  Text(
                    "Telefone:",
                    style: GoogleFonts.petrona(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['telefone'],
                      style: GoogleFonts.petrona(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
              child: Row(
                children: [
                  Text(
                    "Endereco:",
                    style: GoogleFonts.petrona(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['endereco'],
                      style: GoogleFonts.petrona(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Row(
                children: [
                  Text(
                    "Cep:",
                    style: GoogleFonts.petrona(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemLista['cep'],
                      style: GoogleFonts.petrona(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.grey[600],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      deleteUser(itemLista["doc_id"]);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
