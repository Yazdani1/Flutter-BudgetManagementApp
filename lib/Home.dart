import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {


  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getallPost();
    });
  }


  Future getallPost()async{
    var fr=Firestore.instance;
    QuerySnapshot snapshot= await fr.collection("note").getDocuments();
    return snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Budget"),
        backgroundColor: Colors.green,
      ),

      body: FutureBuilder(
          future: getallPost(),
        builder: (context, snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return RefreshIndicator(
                onRefresh: getRefresh,
                child: ListView.builder(
                  itemCount: (snapshot.data.length),
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      height: 150.0,
                      child: Card(
                        elevation: 10.0,
                        child: Column(
                          children: <Widget>[

                            Text(snapshot.data[index].data["title"]),
                            SizedBox(height: 10.0,),
                            Text(snapshot.data[index].data["des"])

                          ],
                        ),
                      ),
                    );
                  }
                ),
              );
            }

        }
      ),

    );
  }
}


