// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

import '../delegate/auth_delegate.dart';

import '../locators/ui_model_locator.dart';
import '../locators/main_model_locator.dart';

@CustomTag('main-app')
class MainApp extends PolymerElement {

  @observable
  UIModelLocator uiModel = new UIModelLocator();

  @observable
  MainModelLocator mainModel = new MainModelLocator();

  MainApp.created() : super.created();

  logout() {
    AuthDelegate d = new AuthDelegate();
    d.logout();
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}
