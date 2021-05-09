import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lista_contatos/add_contact_page.dart';
import 'package:lista_contatos/contact_list_page.dart';
import 'package:lista_contatos/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                onTap: () => context.read<AuthenticationService>().signOut(),
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
