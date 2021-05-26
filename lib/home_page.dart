import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lista_contatos/add_contact_page.dart';
import 'package:lista_contatos/contact_list_page.dart';
import 'package:lista_contatos/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  sair() {
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
      desc: "Você realmente deseja sair?",
      btnCancelText: "Cancelar",
      btnOkText: "Sim",
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkColor: Colors.grey,
      btnCancelColor: Color(0xFF4e4376),
      btnOkOnPress: () {
        context.read<AuthenticationService>().signOut();
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: SpeedDial(
            renderOverlay: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF2b5876),
                label: 'Sair',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  sair();
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF2b5876),
                label: 'Perfil',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('SECOND CHILD'),
              ),
            ],
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF4e4376),
          ),
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
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.menu_book), text: 'Contatos'),
                Tab(icon: Icon(Icons.add_circle_outline), text: 'Adicionar'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              ContactList(),
              AddContactPage(),
            ],
          ),
        ),
      );
}
