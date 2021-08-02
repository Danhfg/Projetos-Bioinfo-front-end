import 'package:app2/modules/signin/signin_page.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Daniel Henrique Ferreira Gomes"),
            accountEmail: Text("danielhenriquefg@gmail.com"),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text("Minhas predições"),
            onTap: () => {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("Políticas de privacidade"),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Opções"),
            onTap: () => {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SignInPage(),
                  ),
                  ModalRoute.withName('/'))
            },
          ),
        ],
      ),
    );
  }
}
