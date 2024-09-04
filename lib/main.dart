import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkrama/utils/provider.dart';
import 'package:synkrama/utils/session.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA_0mOIZaHCiOV0XfxcrNg5y4n_yJCKFmc',
      appId: '1:434124355329:android:4a7eefdff579fdd6fc0d00',
      messagingSenderId: '434124355329',
      projectId: 'fluttertest-20cc2',
    ),
  );  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      )
    ],
     child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Session(),
    )
    );
  }
}



