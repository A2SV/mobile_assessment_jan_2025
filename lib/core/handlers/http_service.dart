

import 'package:dio/dio.dart';
import 'package:mobile_assessment_jan_2025/core/constants/app_constants.dart';
import 'package:mobile_assessment_jan_2025/core/handlers/token_interceptor.dart';


class HttpService {
  Dio client({bool requireAuth = false}) {
    return Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ))..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
    ..interceptors.add(LogInterceptor());
  }
}
