// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library wbm_model.test;

import 'package:wbm_model/wbm_model.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    User user;

    setUp(() {
      user = new User("SHATAN", "Ham", "satan@hell.org", "belzebuth");
      user.id = 1;
    });

    test('First Test', () {
      expect(user.id, 1);
    });
  });
}
