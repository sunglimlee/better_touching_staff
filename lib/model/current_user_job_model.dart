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
}
