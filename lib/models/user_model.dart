import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
   String id;
  
  @HiveField(1)
   String username;
  
  @HiveField(2)
   String email;
  
  @HiveField(3)
   String? phoneNumber;

  @HiveField(4)
   String password;
  
  @HiveField(5)
   String? profileImage;
  
  @HiveField(6)
   String? bio;
  
  @HiveField(7)
   DateTime? createdAt;
  
  @HiveField(8)
   DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    required this.password,
    this.profileImage,
    this.bio,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username:json['username']?.toString() ?? 'Unknown User',
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null, password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'bio': bio,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}