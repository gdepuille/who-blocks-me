library wbm_server.integration.sgbd;

import 'package:di/di.dart';
import 'package:logging/logging.dart';
import 'package:postgresql/postgresql.dart' as pg;
import 'package:redstone/server.dart' as srv;
import 'package:redstone_mapper_pg/manager.dart';

/**
 * Annotation pour la gestion transactionel
 */
class Transactional {
  final pg.Isolation isolation;

  const Transactional({this.isolation: pg.READ_COMMITTED});

  @override
  String toString() => "[isolation: $isolation]";
}

/**
 * Définition du plugin redstone pour la gestion transactionel
 */
srv.RedstonePlugin getTransactionPlugin() {

  Logger log = new Logger("TransactionPlugin");

  Function routeWrapper = (dynamic metadata, Map<String, String> pathSegments, Injector injector, srv.Request request, srv.RouteHandler route) {
    Transactional t = metadata as Transactional;
    log.fine("Initialisation transaction pour la request ${request.requestedUri.toString()} config de transaction $t.");

    PostgreSql pgConn = srv.request.attributes["dbConn"];
    return pgConn.innerConn.runInTransaction(() => route(pathSegments, injector, request), t.isolation);
  };

  return (srv.Manager manager) {
    manager.addRouteWrapper(Transactional, routeWrapper, includeGroups: true);
  };
}