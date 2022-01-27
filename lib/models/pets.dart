// Copyright (c) 2021 Razeware LLC

import 'package:cloud_firestore/cloud_firestore.dart';

import 'vaccination.dart';

class Pet {
  //
  // Defina seus campos: Nome do animal de estimação, notas e o tipo de animal de estimação.
  String name;
  String? notes;
  String type;

  // Lista de vacinas para este animal de estimação.

  List<Vaccination> vaccinations;

  // Um ID de referência a um documento do Firestore que representa esse animal de estimação.

  String? referenceId;

  // Construtor para a classe com parâmetros, onde o nome do animal de estimação, tipo de animal de estimação e vacinas são obrigatórios e os outros são opcionais.

  Pet(this.name,
      {this.notes,
      required this.type,
      this.referenceId,
      required this.vaccinations});

  // Um construtor de fábrica para criar um animal de estimação a partir de um Firestore DocumentSnapshot. Você deseja salvar o ID de referência para atualizar o documento posteriormente.

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pet.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  // Um construtor de fábrica para criar um Pet a partir de JSON.

  factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

  // Transforme este animal de estimação em um mapa de pares chave/valor.

  Map<String, dynamic> toJson() => _petToJson(this);

  @override
  String toString() => 'Pet<$name>';
}

// Adicione uma função para converter um mapa de pares chave/valor em um animal de estimação.

Pet _petFromJson(Map<String, dynamic> json) {
  return Pet(json['name'] as String,
      notes: json['notes'] as String?,
      type: json['type'] as String,
      vaccinations:
          _convertVaccinations(json['vaccinations'] as List<dynamic>));
}

// Adicione outra função para converter uma lista de mapas em uma lista de vacinas.

List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
  final vaccinations = <Vaccination>[];

  for (final vaccination in vaccinationMap) {
    vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
  }
  return vaccinations;
}

// Converta um animal de estimação em um mapa de pares chave/valor.

Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'type': instance.type,
      'vaccinations': _vaccinationList(instance.vaccinations),
    };

// Converta uma lista de vacinas em uma lista de valores mapeados.

List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
  if (vaccinations == null) {
    return null;
  }
  final vaccinationMap = <Map<String, dynamic>>[];
  for (var vaccination in vaccinations) {
    vaccinationMap.add(vaccination.toJson());
  }
  return vaccinationMap;
}
