// lib/core/constants/environment.dart

enum EnvType { dev, sit, uat, prod }

class Environment {
  static const EnvType _env = EnvType.sit;

  static const Map<EnvType, String> _baseUrls = {
    EnvType.dev: "https://vbhcapi.vsolv.net",
    EnvType.sit: "https://vbhcsitapi.vsolv.net",
    EnvType.uat: "https://vbhcuatapi.vsolv.net",
    EnvType.prod: "https://vbhcprodapi.vsolv.net",
  };

  static const Map<EnvType, bool> _showCaptcha = {
    EnvType.dev: false,
    EnvType.sit: true,
    EnvType.uat: true,
    EnvType.prod: true,
  };

  static const int portUser = 1000;
  static const int portMaster = 1001;
  static const int portDoc = 1002;
  static const int portVendor = 1003;
  static const int portPrpo = 1004;
  static const int portCrm = 1010;
  static const int portTa = 1019;
  static const int portHrms = 1023;
  static const int portProject = 1007;
  static const int portSales = 1009;
  static const int portSms = 1008;

  // Getters
  static String get baseUrl => _baseUrls[_env]!;
  static bool get showCaptcha => _showCaptcha[_env]!;

  // Service URLs (buildUrl equivalent)
  static String get userServiceUrl => "$baseUrl:$portUser";
  static String get crmServiceUrl => "$baseUrl:$portCrm";
  static String get docServiceUrl => "$baseUrl:$portDoc";
  static String get hrmsServiceUrl => "$baseUrl:$portHrms";
  static String get taServiceUrl => "$baseUrl:$portTa";
  static String get masterServiceUrl => "$baseUrl:$portMaster";
  static String get prpoServiceUrl => "$baseUrl:$portPrpo";
  static String get vendorServiceUrl => "$baseUrl:$portVendor";
  static String get projectServiceUrl => "$baseUrl:$portProject";
  static String get salesServiceUrl => "$baseUrl:$portSales";
  static String get smsServiceUrl => "$baseUrl:$portSms";

  static const String appVersion = "V 1.0";
  static const String releaseDate = "13-Nov-2024";
}
