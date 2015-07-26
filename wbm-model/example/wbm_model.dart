// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library wbm_model.example;

import 'package:wbm_model/wbm_model.dart';

main() {
  User user = new User("SHATAN", "Ham", "satan@hell.org", "belzebuth");
  user.id = 1;
  print('User: ${user.id}');
}
