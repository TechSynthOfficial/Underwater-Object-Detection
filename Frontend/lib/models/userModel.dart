class UserModel {
  String? Uid;
  String? Name;
  String? Email;
  String? Company;
  String? Researcher;
  String? Pic;

  UserModel ({this.Uid,this.Name,this.Email,this.Company,this.Researcher,this.Pic});

  UserModel.fromMap(Map<String,dynamic> map){
    Uid = map['Uid'];
    Name = map['Name'];
    Email = map['Email'];
    Company = map['Company'];
    Researcher = map['Researcher'];
    Pic = map['Pic'];
  }

  Map<String,dynamic> toMap(){
    return {
      "Uid":Uid,
      "Name": Name,
      "Email": Email,
      "Company": Company,
      "Researcher":Researcher,
      "Pic": Pic
    };
  }

}