import 'dart:html';

import 'package:wbm_model/wbm_model.dart';
import 'package:redstone_mapper/mapper.dart' as mapper;

import '../locators/main_model_locator.dart';

class UserDelegate {

  String _baseUrl = "http://dev.apps.sogelink.fr:8080/users";

  static final UserDelegate _instance = new UserDelegate._internal();

  UserDelegate._internal();

  factory UserDelegate() => _instance;


  getUser(int id) {
    HttpRequest.getString(_baseUrl + "/$id")
      .then((String json) {
        MainModelLocator m = new MainModelLocator();

        m.user = mapper.decodeJson(json, User);
      }).catchError((_) {
        print("Error : $_");
      }
    );
  }
}