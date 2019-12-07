import 'package:cloud_firestore/cloud_firestore.dart';
import 'ExpenseNote.dart';
class FirestoreExpense{

  static final FirestoreExpense _firestoreService = FirestoreExpense
      ._internal();

  FirestoreExpense._internal();

  factory FirestoreExpense(){
    return _firestoreService;
  }

  Firestore db = Firestore.instance;

  Stream<List<ExpenseNote>> getNote() {
    return db.collection("expensenote").snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => ExpenseNote.getExpenseData(doc.data, doc.documentID))
            .toList()
    );
  }

  Future<void>addExpenseNote(ExpenseNote note){
  return db.collection("expensenote").add(note.addExpenseNote());
  }

  Future<void>deleteNote(String id){
  return db.collection("expensenote").document(id).delete();
  }

  Future<void>updateNote(ExpenseNote note){
  return db.collection("expensenote").document(note.id).updateData(note.addExpenseNote());
  }



}