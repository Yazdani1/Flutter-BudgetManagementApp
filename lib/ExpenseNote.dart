class ExpenseNote{

  final String title;
  final String description;
  final String id;
  final String amount;
  final String date;

  ExpenseNote({this.title,this.description,this.id,this.amount,this.date});

  ExpenseNote.getExpenseData(Map<String,dynamic>data, String id):

        title=data["title"],
        description=data["description"],
        id=id,
        amount=data["amount"],
        date=data["date"];

  Map<String, dynamic>addExpenseNote(){
    return{
      "title":title,
      "description":description,
      "amount":amount,
      "date":date
    };
  }








}