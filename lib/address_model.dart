class AddressModel {
  int? id;
  String? name;
  String? city;
  String? region;
  String? note;

  AddressModel(
      {this.id,
      required this.name,
      required this.city,
      required this.region,
      required this.note});

  // convert form data(vars) to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'region': region,
      'note': note
    };
  }

  // convert from map to data
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
        id: map['id'],
        name: map['name'],
        city: map['city'],
        region: map['region'],
        note: map['note']);
  }
}

List<AddressModel> addresses = [
  AddressModel(
      name: 'Home',
      city: 'Cairo',
      region: 'Al rehab',
      note: 'شارع 14 عمارة الزهور \n الدور الرابع شقة 8'),
  AddressModel(
      name: 'Work',
      city: 'Cairo',
      region: 'Nasr City',
      note: 'شارع 14 عمارة الزهور'),
  AddressModel(
      name: 'My Home',
      city: 'Suez',
      region: 'Al suez',
      note: 'شارع 14 عمارة الزهور \n الدور الرابع شقة 8'),
];
