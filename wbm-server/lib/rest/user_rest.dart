library wbm_server.rests.user;

import 'dart:async';
import 'dart:io';

import 'package:redstone/server.dart' as srv;
import 'package:redstone_mapper/plugin.dart';

import 'package:wbm_model/wbm_model.dart';
import 'package:wbm_server/wbm_server.dart';

@srv.Group("/users")
class UserRest {

  UserService _userService;

  UserRest(UserService this._userService);

  @Encode()
  @Transactional()
  @Secured(const [Profil.AUTHENTICATED])
  @srv.Route("/:id", methods: const [srv.GET])
  Future<User> getUser(int id) {
    return this._userService.findById(id);
  }

  @Encode()
  @Transactional()
  @Secured(const [Profil.AUTHENTICATED])
  @srv.Route("/:id", methods: const [srv.PUT])
  Future<User> updateUser(int id, @Decode() User user) {
    if (id != user.id) {
      ApplicationError error = new ApplicationError(code: "IDENTIFIANT_INVALID", message: "L'identifiant $id est différent de celui de l'utilisateur ${user.id}");
      throw new srv.ErrorResponse(HttpStatus.BAD_REQUEST, error);
    }

    return this._userService.updateUser(user);
  }
}