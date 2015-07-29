// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_button.dart';
import 'package:paper_elements/paper_input.dart';

import '../delegate/auth_delegate.dart';

@CustomTag('login-page')
class LoginPage extends PolymerElement {

  LoginPage.created() : super.created();

  void loginHandler() {
    String username = ($['tiUsername'] as PaperInput).value;
    String password = ($['tiPassword'] as PaperInput).value;

    AuthDelegate authDelegate = new AuthDelegate();
    authDelegate.login(username, password);
  }
}
