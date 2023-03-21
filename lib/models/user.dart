class Users{
  String? id;
  String? fullname;
  String? username;
  String? phone;
  String? email;
  String? role;
  int? nik;

  Users({
    this.id,
    this.fullname,
    this.username,
    this.phone,
    this.email,
    this.role,
    this.nik
  });

  factory Users.fromJson(Map<String, dynamic> json, {bool purify = false}){
    if(purify){
      return Users(
          id: json['id'],
          fullname: json['fullname'],
          username: json['username'],
          phone: json['phone'],
          email: json['email'],
          role: json['role'],
          nik: json['nik'].toInt()
      );
    }
    return Users(
      id: json['id'],
      fullname: json['fullname'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      nik: json['nik']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'fullname': fullname,
      'username': username,
      'phone': phone,
      'email': email,
      'role': role,
      'nik': nik
    };
  }
}