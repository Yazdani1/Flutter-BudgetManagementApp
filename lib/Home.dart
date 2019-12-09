import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'FirestoreService.dart';
import 'Note.dart';
import 'AddIncomeNote.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Expense.dart';
import 'Income.dart';
import 'Chart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  int _selectPage=1;
  final pageOptions=[

    Expense(),
    Income(),

  ];



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Budget Management"),
        backgroundColor: Color(0xFF272B4A),
      ),


      body: pageOptions[_selectPage],

      backgroundColor: Color(0xFF222240),

      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Color(0xFF222240),
        color: Color(0xFF272B4A),
        index: 1,
        animationDuration: Duration(milliseconds: 100),
        items: <Widget>[
          Icon(Icons.remove, size: 30, color: Colors.white,),
          Icon(Icons.add, size: 30, color: Colors.white,),
        ],
        onTap: (int index){
          setState(() {
            _selectPage=index;
          });
        },
      ),

//      body: StreamBuilder(
//          stream: FirestoreService().getNote(),
//          builder: (context, AsyncSnapshot<List<Note>> snapshot){
//            if(snapshot.hasError || !snapshot.hasData){
//              return Center(
//                child: CircularProgressIndicator(),
//              );
//            }else{
//              return ListView.builder(
//                itemCount: snapshot.data.length,
//                itemBuilder: (context,index){
//                  Note note=snapshot.data[index];
//                  return Container(
//                    margin: EdgeInsets.all(8.0),
//                    height: 150.0,
//                    child: Card(
//                      elevation: 10.0,
//                      child: Column(
//                        children: <Widget>[
//
//                          Text(note.title,style: TextStyle(
//                            fontSize: 20.0,
//                            color: Colors.black
//                          ),
//                          ),
//                          SizedBox(height: 10.0,),
//
//                          Text(note.description,style: TextStyle(
//                            fontSize: 18.0,
//                            color: Colors.deepOrange
//                          ),)
//
//                        ],
//                      ),
//                    ),
//                  );
//                }
//              );
//            }
//      }
//      ),
    
    );
  }
}


