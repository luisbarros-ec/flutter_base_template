import '../../data/exceptions/app_exceptions.dart';
import '/data/http/http_client.dart';

abstract class INetworkService {
  Future<String> getPublicIpAddress();
}

class NetworkService implements INetworkService {
  final IHttpClient httpClient;

  //Url that returns user IP
  final _ipifyUrl = 'https://api.ipify.org?format=json';

  NetworkService({required this.httpClient});

  @override
  Future<String> getPublicIpAddress() async {
    try {
      final responseMap = await httpClient.get(url: _ipifyUrl, headers: {});

      // The client.get already returns a map
      final ip = responseMap['ip'];

      if (ip != null && ip is String) {
        return ip;
      } else {
        // If the response doesn't have the expected ip
        throw NetworkIpInvalidResponseException();
      }
    } catch (e) {
      throw NetworkIpFetchFailureException(e.toString());
    }
  }
}
