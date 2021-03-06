import 'package:Notey/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepository {
  final CollectionReference _notesCollection;
  final String uid;

  NoteRepository({String uid})
      : _notesCollection =
            FirebaseFirestore.instance.collection('users/$uid/notes'),
        this.uid = uid;

  Future addNote(Note note) async {
    try {
      DocumentReference documentReference =
          await _notesCollection.add(note.toMap());
      String docId = documentReference.id;
      note.id = docId;
      await updateNote(note);
      return docId;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateNote(Note note) async {
    note.lastModified = Timestamp.now();
    return await _notesCollection.doc(note.id).set(note.toMap());
  }

  Stream<List<Note>> notes() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.
      map((doc) => Note.fromMap(doc.data())).toList();
    });
  }

  Future deleteNote(Note note) async {
    return  _notesCollection.doc(note.id).delete();
  }

}
