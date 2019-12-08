import 'package:flutter/material.dart';
import 'Note.dart';
import 'FirestoreService.dart';
import 'package:intl/intl.dart';
import 'ExpenseNote.dart';
import 'FirestoreExpense.dart';


class AddExpenseNote extends StatefulWidget {
  @override
  _AddExpenseNote createState() => new _AddExpenseNote();
}

class _AddExpenseNote extends State<AddExpenseNote> {

  final DateTime _currenttime=new DateTime.now();

  GlobalKey<FormState>_globalKey=GlobalKey<FormState>();

  TextEditingController title;
  TextEditingController description;
  TextEditingController amount;

  @override
  void initState() {
    super.initState();
    title=TextEditingController(text: '');
    description=TextEditingController(text: '');
    amount=TextEditingController(text: '');
  }



  @override
  Widget build(BuildContext context) {

    String formateDate= new DateFormat.yMMMd().format(_currenttime);

    return new Scaffold(
      appBar: AppBar(
        title: Text("Expense Data"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[

                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Title can not empty";
                    }
                  },
                ),
                SizedBox(height: 10.0,),

                TextFormField(
                  controller: description,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Description can not empty";
                    }
                  },
                ),
                SizedBox(height: 6.0,),
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Amount can not be empty";
                    }
                  },
                ),
                SizedBox(height: 15.0,),
                ButtonTheme(
                  height: 60.0,
                  minWidth: MediaQuery.of(context).size.width/1,
                  child: RaisedButton(
                    child: Text("SAVE",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),
                    ),
                    shape: StadiumBorder(),
                    color: Colors.deepOrange,
                    onPressed: ()async{
                      if(_globalKey.currentState.validate()){
                        try{
                          ExpenseNote note=ExpenseNote(
                              title: title.text,
                              description: description.text,
                              amount: amount.text,
                              date: formateDate
                          );
                          Navigator.of(context).pop();
                          await FirestoreExpense().addExpenseNote(note);

                        }catch(e){
                          print(e);
                        }

                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




