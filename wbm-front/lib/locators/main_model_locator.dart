
import 'package:polymer/polymer.dart';
import 'package:wbm_model/wbm_model.dart';

class MainModelLocator implements Observable {

  /**
   * Instance singleton
   */
  static final MainModelLocator _instance = new MainModelLocator._internal();

  /**
   * Factory pour la récupération du model
   */
  factory MainModelLocator() {
    return _instance;
  }

  /**
   * Constructeur nommé privé.
   */
  MainModelLocator._internal();

  @observable
  int currentUserId;

  @observable
  User user;

  void reset() {
    currentUserId = null;
    user = null;
  }
}