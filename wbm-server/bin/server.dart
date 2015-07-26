// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:di/di.dart';
import 'package:logging/logging.dart';
import 'package:redstone/server.dart' as srv;
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_pg/manager.dart';

import 'package:wbm_server/rest/rests.dart';
import 'package:wbm_server/wbm_server.dart';

void main(List<String> args) {
  // Récupération des arguments pour la configuration
  var parser = new ArgParser()
      ..addOption('port', abbr: 'p', defaultsTo: '8080')
      ..addOption('dbHost', defaultsTo: 'localhost')
      ..addOption('dbPort', defaultsTo: '5432')
      ..addOption('dbName', defaultsTo: 'wbm')
      ..addOption('dbUser', defaultsTo: 'postgres')
      ..addOption('dbPassword', defaultsTo: 'postgres');
  var result = parser.parse(args);

  // Récupération des paramètres
  int port = int.parse(result['port'], onError: (val) {
    stderr.writeln('Could not parse port value "$val" into a number.');
    exit(1);
  });
  String dbHost = result['dbHost'];
  int dbPort = int.parse(result['dbPort']);
  String dbName = result['dbName'];
  String dbUser = result['dbUser'];
  String dbPassword = result['dbPassword'];

  // Configuration du Pool de connection à la base de donnée
  PostgreSqlManager pgsqlManager = new PostgreSqlManager("postgres://$dbUser:$dbPassword@$dbHost:$dbPort/$dbName", min: 1, max: 10);

  // Configuration de l'injection de dépendance
  Module diModule = new Module()
    ..bind(UserService);

  // Configuration de Redstone.
  srv.addPlugin(getMapperPlugin(pgsqlManager));
  srv.addPlugin(getAuthorizationPlugin());
  //srv.addPlugin(getTransactionPlugin());
  srv.addModule(diModule);
  srv.setupConsoleLog(Level.ALL);
  srv.start(port: port);
}
