class User {
  final int? id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String? password;

  User({
    this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['name'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, String>{
      'name': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };

    if (password?.isNotEmpty ?? false) {
      data['password'] = password!;
    }

    return data;
  }
}
