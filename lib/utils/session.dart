
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:synkrama/utils/provider.dart';
import 'package:synkrama/widgets/dashboard.dart';
import 'package:synkrama/widgets/signIn.dart';

class Session extends StatefulWidget {

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<UserProvider>(
      builder: (context, user, child) {
        if (user.email) {
          return DashboardScreen();
        }
        return  SignIn();
      },
    );
  }
}
