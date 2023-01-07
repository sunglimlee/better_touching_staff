// 이렇게 클래스를 여러개 한꺼번 두어도 된다.
class CurrentUserJobModel {
  late String _uid;
  late String _name;
  late String? _age;
  late String? _coupon;

  CurrentUserJobModel(
      {required String uid,
      required String name,
      String? age,
      String? coupon}) {
    _uid = uid;
    _name = name;
    _age = age;
    _coupon = coupon;
  }

  String get uid => _uid;

  String? get coupon => _coupon;

  String? get age => _age;

  String get name => _name;

  CurrentUserJobModel.fromJson(
      {required String uid, required Map<String, dynamic> json}) {
    _uid = uid;
    _name = json['name'];
    _age = json['age'];
    _coupon = json['coupon'];
    //product = ProductModel.fromJson(json['product']);
  }

  // 이건 uid 가 필요가 없다.
  Map<String, dynamic> toJson() {
    return {
      "name": _name, // 왜냐면 Map 이니깐..
      "age": _age,
      "coupon": _coupon,
      //"product": this.product?.toJson() // 여기서 다른 이름 json 으로 되어 있었다...
    };
  }
}
