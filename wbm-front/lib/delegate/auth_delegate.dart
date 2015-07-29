import 'dart:html';
import 'dart:convert';

import '../locators/main_model_locator.dart';
import '../locators/ui_model_locator.dart';
import 'user_delegate.dart';

class AuthDelegate {

  String _baseUrl = "http://dev.apps.sogelink.fr:8080/auth";

  /**
   * Instance singleton
   */
  static final AuthDelegate _instance = new AuthDelegate._internal();

  /**
   * Factory pour la récupération du model
   */
  factory AuthDelegate() {
    return _instance;
  }

  /**
   * Constructeur nommé privé.
   */
  AuthDelegate._internal();


  login(String username, String password) {
    Map<String, String> headers = {
      "Content-Type": "application/json;charset=UTF-8"
    };

    Map<String, String> data = {
      "username": username,
      "password": password
    };

    HttpRequest.request(_baseUrl + "/login", method: "POST", requestHeaders: headers, sendData: JSON.encode(data))
      .then((HttpRequest req) {
        MainModelLocator m = new MainModelLocator();
        UIModelLocator ui = new UIModelLocator();

        String json = req.responseText;
        Map<String, Object> datas = JSON.decode(json);
        m.currentUserId = datas["userId"];
        ui.showMainPage();

        UserDelegate u = new UserDelegate();
        u.getUser(m.currentUserId);
      }).catchError((_) {
        print("Error : $_");
      }
    );
  }

  logout() {
    HttpRequest.getString(_baseUrl + "/logout")
    .then((String result) {
      MainModelLocator l = new MainModelLocator();
      UIModelLocator ui = new UIModelLocator();

      l.reset();
      ui.showLoginPage();
    }).catchError((_) {
      print("Error : $_");
    }
    );
  }
}