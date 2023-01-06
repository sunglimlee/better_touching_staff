class JobModel {

  late String _name;
  late int? _age;
  late int? _coupon;

  JobModel({required String name, int? age, int? coupon}) {
    _name = name;
    _age = age;
    _coupon = coupon;
  }

  String get name => _name;
  int? get age => _age;
  int? get coupon => _coupon;

  JobModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _age = json['age'];
    _coupon = json['coupon'];
    //product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name" : _name, // 왜냐면 Map 이니깐..
      "age" : _age,
      "coupon" : _coupon,
      //"product": this.product?.toJson() // 여기서 다른 이름 json 으로 되어 있었다...
    };
  }

}
