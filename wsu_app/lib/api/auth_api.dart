import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:wsu_app/helpers/helpers.dart';
import 'package:wsu_app/models/models.dart';

class AuthApi extends BaseConnect {
  Future<Response<BaseResponse>> auth() => get('v1/auth');

  Future<Response<BaseResponse>> register(Map<String, dynamic> body) => post('v1/auth/register', body);
}
