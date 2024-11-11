class VechileDetails {
  String? vechileId;
  String? email;
  String? driverName;
  String? uid;
  int? pertolAllownaceAmount;
  int? vechileServiceAmount;

  VechileDetails({this.vechileId, this.driverName, this.email,this.uid});

  VechileDetails.fromJson(Map<String, dynamic> json) {
    driverName = json['driverName'];
    email = json['email'];
    vechileId = json['vechileId'];
    uid=json["uid"];
    pertolAllownaceAmount=json["pertolAllownaceAmount"];
    vechileServiceAmount=json["vechileServiceAmount"];
  }

  Map<String, dynamic> toJosn() {
    return {
      "driverName": driverName,
      "email": email,
      "vechileID": vechileId,
      "uid":uid,
      "vechileServiceAmount":vechileServiceAmount,
      "pertolAllownaceAmount":pertolAllownaceAmount,
    }..removeWhere((key, value) => value == null);
  }
}
