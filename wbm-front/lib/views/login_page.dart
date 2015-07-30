// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_input.dart';
import 'package:core_elements/core_input.dart';

import '../delegate/auth_delegate.dart';

@CustomTag('login-page')
class LoginPage extends PolymerElement {

  PaperInput _tiUsername;
  CoreInput _tiPassword;

  LoginPage.created() : super.created();

  attached() {
    _tiUsername = $['tiUsername'] as PaperInput;
    _tiPassword = $['tiPassword'] as CoreInput;
  }

  void loginHandler() {
    String username = _tiUsername.committedValue;
    String password = _tiPassword.committedValue;

    AuthDelegate authDelegate = new AuthDelegate();
    authDelegate.login(username, password);

    _resetFields();
  }

  _resetFields() {
    _tiPassword.value = null;
    _tiUsername.value = null;
  }
}
