import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/firebase/firebase_services.dart';


class FavoritoService {

  // Para salvar a collection dentro do usuário logado
  get _users => Firestore.instance.collection("users");
  get _carros => _users.document(firebaseUserUid).collection("carros");

  // Para salvar apenas com a collection de carros
//  get _carros => Firestore.instance.collection("carros");

  get stream => _carros.snapshots();

  Future<bool> favoritar(Carro c) async {

    DocumentReference docRef = _carros.document("${c.id}");

    DocumentSnapshot doc = await docRef.get();

    final exists = doc.exists;

    if(exists) {
      // Remove dos favoritos
      docRef.delete();

      return false;
    } else {
      // Adiciona nos favoritos
      docRef.setData(c.toMap());

      return true;
    }
  }

  Future<bool> isFavorito(Carro c) async {

    DocumentReference docRef = _carros.document("${c.id}");

    DocumentSnapshot doc = await docRef.get();

    final exists = doc.exists;

    return exists;
  }

  Future<bool> deleteCarros() async {
    print("Delete carros do usuário logado: $firebaseUserUid");

    // Deleta os carros
    final query = await _carros.getDocuments();
    for(DocumentSnapshot doc in query.documents) {
      await doc.reference.delete();
    }

    // Deleta a referencia do usuário
    _users.document(firebaseUserUid).delete();

    return true;
  }
}