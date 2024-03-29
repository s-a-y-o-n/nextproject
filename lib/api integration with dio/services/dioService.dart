import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getdata(String url) async {
    Dio dio = Dio();
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) => response);
  }
}
