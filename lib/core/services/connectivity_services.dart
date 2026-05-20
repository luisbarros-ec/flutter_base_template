import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { connected, disconnected }

abstract class IConnectivityService {
  Future<ConnectivityStatus> checkConnectivity();
}

class ConnectivityService implements IConnectivityService {
  @override
  Future<ConnectivityStatus> checkConnectivity() async {
    // Get if is connected, list because can be Wi-fi, 5G etc.
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return ConnectivityStatus.connected;
    } else {
      return ConnectivityStatus.disconnected;
    }
  }
}
