const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String emailColumn = 'emailColumn';
const String phoneColumn = 'phoneColumn';
const String imageColumn = 'imageColumn';

class ContactHelper {
  ContactHelper._();
  factory ContactHelper() => _instance;
  static final _instance = ContactHelper._();

  
}

class Contact {
  int? id;
  String name;
  String email;
  String phone;
  String image;

  Contact({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, email: $email, phone: $phone, image: $image}';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image,
    };

    if(id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json[idColumn],
      name: json[nameColumn],
      email: json[emailColumn],
      phone: json[phoneColumn],
      image: json[imageColumn],
    );
  }
}
