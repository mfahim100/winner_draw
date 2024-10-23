

class RequestModel {


 String? userUid;
 String? name;
 String? screenShotUrl;
 String? phoneNumber;
 int? date;


 RequestModel({
   this.userUid,
   this.name,
   this.screenShotUrl,
   this.phoneNumber,
   this.date,
});


 RequestModel.fromMap(Map<String,dynamic> map){

    userUid= map['userUid'];
    name= map['name'];
    screenShotUrl= map['screenShotUrl'];
    phoneNumber= map['phoneNumber'];
    date= map['date'];



  }




Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map['userUid'] = userUid;
    map['name'] = name;
    map['screenShotUrl'] = screenShotUrl;
    map['phoneNumber'] = phoneNumber;
    map['date'] = date;
    return map;

}





}




