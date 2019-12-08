import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AddIncomeNote.dart';
import 'FirestoreService.dart';
import 'Note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'AddExpenseNote.dart';
import 'FirestoreExpense.dart';
import 'ExpenseNote.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => new _ExpenseState();
}

class _ExpenseState extends State<Expense> {

  Note expenseNote;

  final DateTime _currenttime = new DateTime.now();

  GlobalKey<FormState>_globalKey = GlobalKey<FormState>();

  TextEditingController title;
  TextEditingController description;
  TextEditingController amount;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: isEdating ? expenseNote.title:'');
    description = TextEditingController(text: isEdating ? expenseNote.description:'');
    amount = TextEditingController(text: isEdating ? expenseNote.amount:'');
  }

  get isEdating => expenseNote!= null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StreamBuilder(
          stream: FirestoreExpense().getNote(),
          builder: (context, AsyncSnapshot <List<ExpenseNote>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    ExpenseNote note = snapshot.data[index];
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      key: ValueKey(index),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit & Delete',
                          foregroundColor: Colors.white,
                          color: Color(0xFF272B4A),
                          icon: Icons.more_horiz,
                          onTap: () => shoCuportionDialog(context, note),
                        ),
                      ],
                      child: InkWell(
                        onTap: () {
                          customDialog(
                              context, note.title, note.description,
                              note.amount);
                        },
                        child: Container(
                          margin: EdgeInsets.all(7.0),
                          height: 150.0,
                          color: Color(0xFF272B4A),
                          child: Card(
                            elevation: 10.0,
                            color: Color(0xFF272B4A),
                            child: Row(
                              children: <Widget>[

                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: CircleAvatar(
                                                  child: Text(
                                                    note.title.toUpperCase()[0],
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.amber,
                                                  foregroundColor: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 7.0,),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  note.title.toUpperCase(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 7.0,),
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: Text(note.date,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.0,),
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: Text(note.description,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.white
                                            ),),
                                        )

                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(width: 6.0,),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(note.amount,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.amber
                                          ),
                                        ),
                                        SizedBox(width: 3.0,),
                                        Icon(Icons.arrow_downward,
                                          size: 25.0,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
          }
      ),

      backgroundColor: Color(0xFF222240),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>AddExpenseNote()));
        },
      ),

    );
  }

  shoCuportionDialog(BuildContext context, ExpenseNote note) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: new Text("Edit and Delete",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            message: new Text("Either edit your data or delete your data",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
              ),
            ),
            cancelButton: new CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Cancel")
            ),
            actions: <Widget>[
              new CupertinoActionSheetAction(
                onPressed: () async{
                  Navigator.of(context).pop();
                },
                child: new Text("Edit",
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              new CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await FirestoreExpense().deleteNote(note.id);
                  },
                  child: new Text("Delete",
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  )
              ),
            ],
          );
        }
    );
  }

  customDialog(BuildContext context, String title, String description,
      String amount) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF222240),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      height: 75.0,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            //Colors.black[100],
                            Colors.deepOrange[900],
                            Colors.blueGrey[700],
                          ],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(amount, style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                            ),),
                            SizedBox(width: 6.0,),
                            Icon(Icons.arrow_downward, color: Colors.red,
                              size: 25.0,)
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(title,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),),
                    ),
                    SizedBox(height: 10.0,),

                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(description,
                        style: TextStyle(fontSize: 17.0, color: Colors.white),),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }


}
