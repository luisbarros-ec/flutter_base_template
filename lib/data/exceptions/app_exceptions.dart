/// Location Service Exceptions
class LocationServiceDisabledException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationPermissionPermanentlyDeniedException implements Exception {}

/// Network Service Exceptions
class NetworkIpInvalidResponseException implements Exception {}

class NetworkIpFetchFailureException implements Exception {
  final String originalError;

  NetworkIpFetchFailureException(this.originalError);
}

/// Http Exceptions
class UnauthorizedException implements Exception {}

class TokenException implements Exception {
  final String message;

  TokenException(this.message);
}

class ServerConnectionException implements Exception {}

class ServerTimeoutException implements Exception {}
