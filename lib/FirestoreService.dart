import 'package:cloud_firestore/cloud_firestore.dart';
import 'Note.dart';

class FirestoreService {

  static final FirestoreService _firestoreService = FirestoreService
      ._internal();

  FirestoreService._internal();

  factory FirestoreService(){
    return _firestoreService;
  }

  Firestore db = Firestore.instance;

  Stream<List<Note>> getNote() {
    return db.collection("note").snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Note.fromMap(doc.data, doc.documentID))
            .toList()
    );
  }

  Future<void>addNote(Note note){
  return db.collection("note").add(note.addNote());
  }

  Future<void>deleteNote(String id){
    return db.collection("note").document(id).delete();
  }

  Future<void>updateNote(Note note){
    return db.collection("note").document(note.id).updateData(note.addNote());
  }



}