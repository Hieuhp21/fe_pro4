class ApiConst{

  static const String serverAddress = '192.168.0.100';
  static const int port = 8080;

  static String get baseUrl {
    return 'http://$serverAddress:$port/';
  }
}