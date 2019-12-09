import 'package:flutter/material.dart';
import 'Note.dart';
import 'FirestoreService.dart';
import 'package:intl/intl.dart';


class AddNote extends StatefulWidget {

  final Note note;

  const AddNote({Key key, this.note}) : super(key: key);



  @override
  _AddNoteState createState() => new _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final DateTime _currenttime=new DateTime.now();

  GlobalKey<FormState>_globalKey=GlobalKey<FormState>();

  TextEditingController title;
  TextEditingController description;
  TextEditingController amount;

  @override
  void initState() {
    super.initState();
    title=TextEditingController(text: isEditing ? widget.note.title : '');
    description=TextEditingController(text: isEditing ? widget.note.description: '');
    amount=TextEditingController(text: isEditing ? widget.note.amount : '');
  }

  get isEditing => widget.note != null;


  @override
  Widget build(BuildContext context) {

    String formateDate= new DateFormat.yMMMd().format(_currenttime);

    return new Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Update your data" : "Add your data"),
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
                      child: Text(isEditing ? "UPDATE" : "SAVE",
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
                            if(isEditing){
                              Note note=Note(
                                  title: title.text,
                                  description: description.text,
                                  amount: amount.text,
                                  id: widget.note.id,
                                  date: formateDate
                              );
                              Navigator.of(context).pop();
                              await FirestoreService().updateNote(note);
                            }else{
                              Note note=Note(
                                  title: title.text,
                                  description: description.text,
                                  amount: amount.text,
                                  date: formateDate
                              );
                              Navigator.of(context).pop();
                              await FirestoreService().addNote(note);
                            }
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


