class Note{

  final String title;
  final String description;
  final String id;
  final String amount;
  final String date;

  Note({this.title,this.description,this.id,this.amount,this.date});

  Note.getIncomeData(Map<String,dynamic>data, String id):

      title=data["title"],
      description=data["description"],
      id=id,
      amount=data["amount"],
      date=data["date"];

  Map<String, dynamic>addIncomeNote(){
    return{
      "title":title,
      "description":description,
      "amount":amount,
      "date":date
    };
  }









}