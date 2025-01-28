import 'package:get_it/get_it.dart';
import 'package:mobile_assessment_jan_2025/core/handlers/http_service.dart';
import 'package:mobile_assessment_jan_2025/services/api_service.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  // Register HttpService
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  
  // Register ApiService with HttpService dependency
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(httpService: getIt<HttpService>())
  );
}

// Export commonly used services
final httpService = getIt.get<HttpService>();
final apiService = getIt.get<ApiService>();

