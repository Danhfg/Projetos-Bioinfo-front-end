import 'package:app2/app/app_module.dart';
import 'package:app2/modules/predict/components/menuBar_bloc.dart';
import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/signin/signin_page.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  MenuBarBloc menuBarBloc = PredictModule.to.getBloc<MenuBarBloc>();
  AuthBloc auth = AppModule.to.getBloc<AuthBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(menuBarBloc.user.name),
            accountEmail: Text(menuBarBloc.user.username),
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
              auth.exit = true,
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => new SignInPage(),
                  ),
                  ModalRoute.withName('/'))
            },
          ),
        ],
      ),
    );
  }
}
