// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library wbm_model.entities.user;

import 'package:redstone_mapper/mapper.dart';

class User extends Schema {

  @Field()
  int id;

  @Field()
  @NotEmpty()
  String nom;

  @Field()
  @NotEmpty()
  String prenom;

  @Field()
  @Matches(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$', required: true)
  String mail;

  @Field()
  @Range(min: 4, required: true)
  String userName;

  @Field()
  @Range(min: 6, required: true)
  String password;

}
