class ApiConst{

  static const String serverAddress = 'Admin';
  static const int port = 8080;

  static String get baseUrl {
    return 'http://$serverAddress:$port/';
  }
}