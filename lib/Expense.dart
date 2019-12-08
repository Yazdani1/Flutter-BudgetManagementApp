import 'package:flutter/material.dart';
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
                          onTap: () => shoCuportionDialog(context,note),
                        ),
                      ],

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
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => AddExpenseNote()));
        },
      ),

    );
  }

  shoCuportionDialog(BuildContext context,ExpenseNote note) {
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Edit",
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              new CupertinoActionSheetAction(
                  onPressed: () async{
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

}
