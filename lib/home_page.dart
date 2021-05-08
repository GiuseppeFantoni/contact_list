import 'package:flutter/material.dart';
import 'package:lista_contatos/add_contact_page.dart';
import 'package:lista_contatos/contact_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
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
                Tab(icon: Icon(Icons.library_books_rounded), text: 'Contatos'),
                Tab(icon: Icon(Icons.add_circle_outline), text: 'Adicionar'),
                Tab(icon: Icon(Icons.edit_rounded), text: 'Atualizar'),
                Tab(icon: Icon(Icons.settings), text: 'Settings'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              ContactList(),
              AddContactPage(),
              buildPage('Profile Page'),
              buildPage('Settings Page'),
            ],
          ),
        ),
      );

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
        ),
      );
}
