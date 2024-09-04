import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'database.dart';

class UserProvider with ChangeNotifier{
  bool _email = false;
  late SharedPreferences prefs;
  bool get email => _email;

  UserProvider() {
    getSession();
    fetchAll();
  }

  void getSession() async{
    prefs = await SharedPreferences.getInstance();
    _email = prefs.getBool('email') ?? false;
    notifyListeners();
  }
  void fetchAll() async {
    List<Map<String, dynamic>> data = await UserDBHelper.instance.queryAll();
    print("simran");
    print(data);
    notifyListeners();
  }
  Future<List<Map<String, dynamic>>> find(String email) async {
    final List<Map<String, dynamic>> maps=await UserDBHelper.instance.findUser(email);
    return maps;
  }
  Future<List<Map<String, dynamic>>> login(String email,String password) async {
    final List<Map<String, dynamic>> maps=await UserDBHelper.instance.login(email,password);
    return maps;
  }
  Future<void> updatePassword(String email, String password) async {
    await UserDBHelper.instance.updatePassword(email, password);
    notifyListeners();
  }
  Future<int?> addDuoDevice(
      String name,
      String email,
      String password
      ) async {
    final List<Map<String, dynamic>> maps=await UserDBHelper.instance.findUser(email);
 if(maps.isEmpty) {
   var result =await UserDBHelper.instance.insert({
     UserDBHelper.name: name,
     UserDBHelper.email: email,
     UserDBHelper.password: password
   });
   return result;
 }
 else{
   errorSnackbar(msg: "This Email Is Already Registered");
   return null;
 }
  }
}
