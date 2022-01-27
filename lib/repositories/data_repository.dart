import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pets.dart';

class DataRepository {
  //
  // Sua coleção de nível superior é chamada de animais de estimação .
  // Você armazenou uma referência a isso na collectionvariável.

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('pets');

  // Use o método de instantâneos para obter um fluxo de instantâneos.
  // Isso escuta as atualizações automaticamente.

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // Adicione um novo animal de estimação. Isso retorna um futuro se você quiser esperar pelo resultado.
  // Observe que add criará automaticamente um novo ID de documento para Pet.

  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  // Atualize sua classe de estimação no banco de dados.
  // Semelhante a adicionar um novo animal de estimação, esse método usa a referência
  // de coleção para atualizar um animal de estimação existente usando seu ID.

  void updatePet(Pet pet) async {
    await collection.doc(pet.referenceId).update(pet.toJson());
  }

  // Exclua sua classe de estimação do banco de dados.
  // O mesmo que atualizar, exceto que o animal de estimação
  // é excluído usando seu ID.

  void deletePet(Pet pet) async {
    await collection.doc(pet.referenceId).delete();
  }
}
