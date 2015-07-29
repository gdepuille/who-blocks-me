library wbm_server.rests.auth;

import 'dart:async';
import 'dart:io';

import 'package:redstone/server.dart' as srv;
import 'package:redstone_mapper/plugin.dart';

import 'package:wbm_model/wbm_model.dart';
import 'package:wbm_server/wbm_server.dart';

@srv.Group("/auth")
class AuthRest {
  UserService _userService;

  AuthRest(UserService this._userService);

  @srv.Route("/login", methods: const [srv.POST])
  Future<Map<String, Object>> login(@srv.Body(srv.JSON) Map<String, String> body) {
    ApplicationError error = new ApplicationError(code: "AUTHENTIFICATION_INVALID", message: "Login ou mot de passe invalide");

    if (!body.containsKey("username") || !body.containsKey("password")) {
      throw new srv.ErrorResponse(HttpStatus.BAD_REQUEST, error);
    }

    Completer<Map<String, Object>> completer = new Completer<Map<String, Object>>();

    String username = body["username"];
    String password = body["password"];
    this._userService.findByCredentials(username, password).then((User u) {
      HttpSession session = srv.request.session;
      session["user"] = u;

      // TODO : Charger les profils.
      List<Profil> profils = [Profil.AUTHENTICATED];
      session["roles"] = profils;

      completer.complete({"success": true, "userId": u.id});
    }).catchError((_) {
      completer.completeError(error);
    });

    return completer.future;
  }

  @srv.Route("/logout")
  Map<String, Object> logout() {
    srv.request.session.destroy();
    return {"success": true};
  }
}