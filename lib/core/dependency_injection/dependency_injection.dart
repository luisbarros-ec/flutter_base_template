import 'package:flutter/material.dart';
import '/ui/screens/example_screen/example_controller.dart';
import 'package:provider/provider.dart';
import '../../data/http/http_client.dart';
import '../../data/http/http_interceptor.dart';
import '../../data/http/refresh_token_service.dart';
import '../../data/repositories/example_repository.dart';
import '../services/connectivity_services.dart';
import '../services/location_service.dart';
import '../services/network_service.dart';
import '../services/secure_storage_service.dart';

class DependencyInjection extends StatelessWidget {
  final Widget child;

  const DependencyInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Providers sem dependências (Serviços Base)
        Provider<IHttpClient>(create: (context) => HttpClient()),
        Provider<ISecureStorageService>(
          create: (context) => SecureStorageService(),
        ),
        Provider<IConnectivityService>(
          create: (context) => ConnectivityService(),
        ),
        Provider<ILocationService>(create: (context) => LocationService()),

        /// Providers com dependências (Services complexos e Repositórios)
        Provider<IRefreshTokenService>(
          create: (context) => RefreshTokenService(
            client: context.read<IHttpClient>(),
            secureStorageService: context.read<ISecureStorageService>(),
          ),
        ),
        Provider<IHttpInterceptor>(
          create: (context) => HttpInterceptor(
            refreshTokenService: context.read<IRefreshTokenService>(),
          ),
        ),
        Provider<INetworkService>(
          create: (context) =>
              NetworkService(httpClient: context.read<IHttpClient>()),
        ),

        /// Repositório de exemplo
        Provider<IExampleRepository>(
          create: (context) =>
              ExampleRepository(httpClient: context.read<IHttpClient>()),
        ),

        /// Controllers (Gerenciadores de Estado da UI)
        ChangeNotifierProvider<ExampleController>(
          create: (context) =>
              ExampleController(repository: context.read<IExampleRepository>()),
        ),
      ],
      child: child,
    );
  }
}
