import 'package:flutter/material.dart';
import 'Note.dart';
import 'FirestoreService.dart';


class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => new _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  GlobalKey<FormState>_globalKey=GlobalKey<FormState>();

  TextEditingController title;
  TextEditingController description;

  @override
  void initState() {
    super.initState();
    title=TextEditingController(text: '');
    description=TextEditingController(text: '');
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Add your Data"),
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
                            Note note=Note(title: title.text,description: description.text);

                            await FirestoreService().addNote(note);

                          }catch(e){
                            print(e);
                          }
                          Navigator.of(context).pop();
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


