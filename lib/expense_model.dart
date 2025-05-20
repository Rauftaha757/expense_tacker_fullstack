import 'dart:ffi';

class expense_model{
  String note;
  String date;
  String ? percentage;
  String ? id;
  double salary;
  double amount;

  expense_model({
   required this.amount,required this.date,required this.note,this.percentage,this.id,required this.salary
});
// sending to db and backend converting objet into json
  Map<String,dynamic> tojson(){
    return {
    "note":note,
    "date":date,
    "salary":salary,
      "amount":amount
  };
  }


  factory expense_model.fromjson(Map<String,dynamic> json){
    return expense_model(
      note: json['note'],
      amount: json['amount'],
      date:json['date'],
      salary: json['salary'],
      percentage: json['percentage'],
      id:json["_id"],
    );
  }
}

