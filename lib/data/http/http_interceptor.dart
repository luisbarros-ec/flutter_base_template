import '../exceptions/app_exceptions.dart';
import '/data/http/refresh_token_service.dart';

abstract class IHttpInterceptor {
  Future<T> handleAuth<T>(
    Future<T> Function(Map<String, String> headers) requestFn,
  );

  Future<Map<String, String>> getAuthHeaders();
}

final class HttpInterceptor implements IHttpInterceptor {
  final IRefreshTokenService refreshTokenService;

  HttpInterceptor({required this.refreshTokenService});

  @override
  Future<T> handleAuth<T>(
    Future<T> Function(Map<String, String> headers) requestFn,
  ) async {
    try {
      final Map<String, String> headers = await getAuthHeaders();
      return await requestFn(headers);
    } on UnauthorizedException {
      await refreshTokenService.refreshToken();
      final Map<String, String> headers = await getAuthHeaders();
      return await requestFn(headers);
    } on TokenException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> getAuthHeaders() {
    return refreshTokenService.getAuthHeaders();
  }
}
