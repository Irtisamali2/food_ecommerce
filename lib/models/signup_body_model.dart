class SignUpBody{
  String name;
  String email;
  String phone;
  String password;
  SignUpBody({
    required this.name,
     required this.email, 
     required this.phone, 
     required this.password
  });
  //object to json format for server
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data= Map<String, dynamic>();
    data['f_name']=this.name;
    data["phone"]=this.phone;
    data["email"]=this.email;
    data["password"]=this.password;

    return data;
  }
}