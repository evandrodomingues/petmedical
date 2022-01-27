// Copyright (c) 2021 Razeware LLC

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'repositories/data_repository.dart';
import 'add_pet_dialog.dart';
import 'models/pets.dart';
import 'pet_card.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final DataRepository repository = DataRepository();

  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
      ),

      // O StreamBuilder primeiro verifica se você tem algum dado.
      // Caso contrário, ele mostrará um indicador de progresso.
      // Caso contrário, ele chamará _buildList.

      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          return _buildList(context, snapshot.data?.docs ?? []);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPet();
        },
        tooltip: 'Add Pet',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addPet() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddPetDialog();
      },
    );
  }

  // 1
  // Método para construir a lista de pets na tela do aplicativo.

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),

      // 2
      // Mapeia a lista de dados, cria um novo item de lista para cada um e transforma isso
      // em uma lista que o parâmetro child precisa.

      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  // 3
  // Método que cria cartões de animais de estimação individuais no arquivo ListView.
  // Tem DocumentSnapshotcomo parâmetro

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 4
    // Cria uma classe Pet a partir do instantâneo passado.

    final pet = Pet.fromSnapshot(snapshot);

    return PetCard(pet: pet, boldStyle: boldStyle);
  }
}
