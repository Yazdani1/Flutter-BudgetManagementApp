import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'FirestoreService.dart';
import 'Note.dart';
import 'AddNote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Budget"),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder(
          stream: FirestoreService().getNote(),
          builder: (context, AsyncSnapshot<List<Note>> snapshot){
            if(snapshot.hasError || !snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  Note note=snapshot.data[index];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    height: 150.0,
                    child: Card(
                      elevation: 10.0,
                      child: Column(
                        children: <Widget>[

                          Text(note.title,style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                          ),
                          ),
                          SizedBox(height: 10.0,),

                          Text(note.description,style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrange
                          ),)

                        ],
                      ),
                    ),
                  );
                }
              );
            }
      }
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>AddNote()));
        },
      ),


    );
  }
}


