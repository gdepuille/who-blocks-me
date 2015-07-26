library wbm_server.services.user;

import 'dart:async';

import 'package:wbm_model/wbm_model.dart';
import 'package:redstone_mapper_pg/service.dart';

class UserService extends PostgreSqlService<User> {

  Future<User> findById(int id) {
    String queryString = '''
    SELECT *
    FROM users
    WHERE id = @id
    ''';

    Completer<User> completer = new Completer<User>();
    query(queryString, {"id": id}).then((values) {
      if (values != null && values.length == 1) {
        completer.complete(values.elementAt(0));
      } else {
        ApplicationError error = new ApplicationError(code: 'USER_NOT_FOUND', message: 'Aucun utilisateur avec l\'identifiant $id');
        completer.completeError(error);
      }
    }).catchError((_) {
      ApplicationError error = new ApplicationError(code: 'UNKNOWN_ERROR', message: 'Impossible de lire les informations en base de données');
      completer.completeError(error);
    });

    return completer.future;
  }

  Future<User> findByCredentials(String username, String password) {
    String queryString = '''
    SELECT *
    FROM users
    WHERE (mail = @username OR username = @username) AND password = @password
    ''';

    Completer<User> completer = new Completer<User>();
    query(queryString, {"username": username, "password": password}).then((values) {
      if (values != null && values.length == 1) {
        completer.complete(values.elementAt(0));
      } else {
        ApplicationError error = new ApplicationError(code: 'AUTHENTIFICATION_INVALID', message: 'Login ou mot de passe invalide');
        completer.completeError(error);
      }
    }).catchError((_) {
      ApplicationError error = new ApplicationError(code: 'UNKNOWN_ERROR', message: 'Impossible de lire les informations en base de données');
      completer.completeError(error);
    });

    return completer.future;
  }

  Future<User> updateUser(User user) {
    String queryString = '''
    UPDATE users
    SET nom = @nom, prenom = @prenom, mail = @mail
    WHERE id = @id
    ''';

    Completer<User> completer = new Completer<User>();
    execute(queryString).then((value) {
      completer.complete(user);
    }).catchError((_) {
      ApplicationError error = new ApplicationError(code: 'UDATE_BDD', message: 'Erreur lors de la mise à jour des informations de l\'utilisateur ${user.id}');
      completer.completeError(error);
    });

    return completer.future;
  }
}