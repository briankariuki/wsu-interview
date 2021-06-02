import 'package:get/get_connect/http/src/response/response.dart';
import 'package:wsu_app/helpers/helpers.dart';
import 'package:wsu_app/models/models.dart';

class AuthApi extends BaseConnect {
  Future<Response<BaseResponse>> auth() => get('v1/auth');

  Future<Response<BaseResponse>> register(UserCreate userRegister) => post('v1/auth/register', userRegister.toJson());
}
