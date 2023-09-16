class UserDetail {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  UserDetail({
    this.accessToken = "",
    this.tokenType = "",
    this.expiresIn = 0,
    User? user,
  }) : user = user ?? User();

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      accessToken: json['access_token'] ?? "",
      tokenType: json['token_type'] ?? "",
      expiresIn: json['expires_in'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String mobile;
  final String mobileVerifiedAt;
  final String status;
  final int communityId;
  final String address;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  User({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.emailVerifiedAt = "",
    this.mobile = "",
    this.mobileVerifiedAt = "",
    this.status = "",
    this.communityId = 0,
    this.address = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      emailVerifiedAt: json['email_verified_at'] ?? "",
      mobile: json['mobile'] ?? "",
      mobileVerifiedAt: json['mobile_verified_at'] ?? "",
      status: json['status'] ?? "",
      communityId: json['community_id'] ?? 0,
      address: json['address'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'mobile': mobile,
      'mobile_verified_at': mobileVerifiedAt,
      'status': status,
      'community_id': communityId,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
