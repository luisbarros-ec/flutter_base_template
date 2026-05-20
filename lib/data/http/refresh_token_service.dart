import '../../core/services/secure_storage_service.dart';
import '../constants/local_storage_constants.dart';
import '../exceptions/app_exceptions.dart';
import 'http_client.dart';

abstract class IRefreshTokenService {
  Future refreshToken();

  Future<Map<String, String>> getAuthHeaders();
}

final class RefreshTokenService implements IRefreshTokenService {
  final IHttpClient client;
  final ISecureStorageService secureStorageService;

  final String _refreshUrl = 'SUA_URL_DE_REFRESH_AQUI';

  RefreshTokenService({
    required this.client,
    required this.secureStorageService,
  });

  @override
  Future refreshToken() async {
    String refreshToken = await secureStorageService.read(
      key: LocalStorageConstants.refreshToken,
    );

    Map<String, String> header = {
      //"Refresh-Token": refreshToken,
      //"Device-
      'Content-Type': 'application/json',
    };

    var response = {};
    try {
      response = await client.post(
        url: _refreshUrl,
        headers: header,
        //body: null,
        body: {'refreshToken': refreshToken},
      );

      await secureStorageService.write(
        key: LocalStorageConstants.accessToken,
        //value: body["access"],
        value: response["accessToken"],
      );
      await secureStorageService.write(
        key: LocalStorageConstants.refreshToken,
        value: response["refreshToken"],
      );
    } on UnauthorizedException {
      _deleteTokens();
      throw TokenException('');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> getAuthHeaders() async {
    final accessToken = await secureStorageService.read(
      key: LocalStorageConstants.accessToken,
    );

    return {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    };
  }

  Future _deleteTokens() async {
    await secureStorageService.delete(key: LocalStorageConstants.accessToken);
    await secureStorageService.delete(key: LocalStorageConstants.refreshToken);
  }
}
