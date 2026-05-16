class EntityModel {
  final int? id;
  final String? name;
  final String? namespace;
  final String? shortCode;
  final int? status;

  // captcha
  final String? captchaKey;
  final String? captchaImageUrl;

  EntityModel({
    this.id,
    this.name,
    this.namespace,
    this.shortCode,
    this.status,
    this.captchaKey,
    this.captchaImageUrl,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      id: json["id"],
      name: json["name"],
      namespace: json["namespace"],
      shortCode: json["short_code"],
      status: json["status"],
      captchaKey: json["captcha_key"],
      captchaImageUrl: json["captcha_image_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "namespace": namespace,
      "short_code": shortCode,
      "status": status,
      "captcha_key": captchaKey,
      "captcha_image_url": captchaImageUrl,
    };
  }
}
