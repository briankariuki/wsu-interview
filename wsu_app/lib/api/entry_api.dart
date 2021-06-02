import 'package:get/get.dart';
import 'package:wsu_app/helpers/helpers.dart';

class EntryApi extends BaseConnect {
  Future<Response<BaseResponse>> create(Map<String, dynamic> body) => post('v1/entry', body);

  Future<Response<BaseResponse>> fetch(Map<String, dynamic> query) => get('v1/entry', query: query);
}
