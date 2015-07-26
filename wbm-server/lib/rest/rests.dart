library wbm_server.rests;

import 'dart:io';
import 'package:redstone/server.dart' as srv;
import 'package:redstone_mapper/mapper.dart' as mapper;
import 'package:shelf/shelf.dart' as shelf;

// Model
import 'package:wbm_model/wbm_model.dart';

// Route REST
import 'user_rest.dart';
import 'auth_rest.dart';

var _errorHeaders = {
  "Content-Type": "application/json"
};

// Handler d'erreur
@srv.ErrorHandler(HttpStatus.INTERNAL_SERVER_ERROR)
shelf.Response onInternalServerError() {
  return _generateError();
}

@srv.ErrorHandler(HttpStatus.BAD_REQUEST)
shelf.Response onBadRequestError() {
  return _generateError();
}

@srv.ErrorHandler(HttpStatus.UNAUTHORIZED)
shelf.Response onUnauthorizedError() {
  ApplicationError error = new ApplicationError(code: 'NON_AUTORISE', message: 'Veuillez vous authentifier.');
  return new shelf.Response(HttpStatus.UNAUTHORIZED, body: mapper.encodeJson(error), headers: _errorHeaders);
}

@srv.ErrorHandler(HttpStatus.FORBIDDEN)
shelf.Response onAccessDeniedError() {
  ApplicationError error = new ApplicationError(code: 'NON_AUTORISE', message: 'Veuillez vous authentifier.');
  return new shelf.Response.forbidden(mapper.encodeJson(error), headers: _errorHeaders);
}

shelf.Response _generateError() {
  ApplicationError error;

  if (srv.chain.error is ApplicationError) {
    error = srv.chain.error;
    return new shelf.Response(HttpStatus.BAD_REQUEST, body: mapper.encodeJson(error), headers: _errorHeaders);
  } else {
    error = new ApplicationError(code: 'UNKNOWN_ERROR', message: 'Une erreur inconnue est survenue.');
    return new shelf.Response.internalServerError(body: mapper.encodeJson(error), headers: _errorHeaders);
  }
}