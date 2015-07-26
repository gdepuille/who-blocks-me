library wbm_model.errors.application;

import 'package:redstone_mapper/mapper.dart';

class ApplicationError {

  @Field()
  String code;

  @Field()
  String message;

  @Field()
  String complement;

  ApplicationError({String this.code, String this.message, String this.complement});
}