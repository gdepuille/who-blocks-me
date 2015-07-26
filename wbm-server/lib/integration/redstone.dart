library wbm_server.integration.redstone;

import 'dart:io';

import 'package:di/di.dart';
import 'package:logging/logging.dart';
import 'package:redstone/server.dart' as srv;

/**
 * Enumération des profil de conexxion
 */
enum Profil {
  AUTHENTICATED,
  ADMIN
}

/**
 * Annotation de sécurité pour les routes
 */
class Secured {
  final List<Profil> roles;

  const Secured(this.roles);

  @override
  String toString() => "[roles: ${roles.join(", ")}";
}

/**
 * Définition du plugin de gestion
 */
srv.RedstonePlugin getAuthorizationPlugin() {
  Logger log = new Logger("AuthorizationPlugin");

  Function routeWrapper = (dynamic metadata, Map<String, String> pathSegments, Injector injector, srv.Request request, srv.RouteHandler route) {
    Secured s = metadata as Secured;
    log.fine("Tentative d'accès sécurisé à la méthode ${request.requestedUri.toString()}.");

    HttpSession session = srv.request.session;
    if (!session.containsKey("user")) {
      throw new srv.ErrorResponse(HttpStatus.UNAUTHORIZED, null);
    }

    List<Profil> userRoles = session["roles"];
    if (!userRoles.contains(s.roles)) {
      throw new srv.ErrorResponse(HttpStatus.FORBIDDEN, null);
    }

    return route(pathSegments, injector, request);
  };

  return (srv.Manager manager) {
    manager.addRouteWrapper(Secured, routeWrapper, includeGroups: true);
  };
}