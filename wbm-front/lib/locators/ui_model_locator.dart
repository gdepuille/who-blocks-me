
import 'package:polymer/polymer.dart';

class UIModelLocator implements Observable {

  /**
   * Instance singleton
   */
  static final UIModelLocator _instance = new UIModelLocator._internal();

  /**
   * Factory pour la récupération du model
   */
  factory UIModelLocator() {
    return _instance;
  }

  /**
   * Constructeur nommé privé.
   */
  UIModelLocator._internal();

  @observable
  int mainViewIdx = 0;


  showLoginPage() {
    mainViewIdx = 0;
  }

  showMainPage() {
    mainViewIdx = 1;
  }
}