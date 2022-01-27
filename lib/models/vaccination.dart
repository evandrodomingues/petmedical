// Copyright (c) 2021 Razeware LLC

import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  //
  // 1 - Defina seus campos: Nome da vacinação, data em que foi dada e se esta vacinação foi finalizada.

  final String vaccination;
  final DateTime date;
  bool? done;

  // 2 - Construtor para a classe com parâmetros, onde a vacinação é obrigatória e as demais são opcionais.

  Vaccination(this.vaccination, {required this.date, this.done});

  // 3 - Um construtor de fábrica para criar uma vacinação de JSON.

  factory Vaccination.fromJson(Map<String, dynamic> json) =>
      _vaccinationFromJson(json);

  // 4 - Transforme essa vacinação em um mapa de pares chave/valor.

  Map<String, dynamic> toJson() => _vaccinationToJson(this);

  @override
  String toString() => 'Vaccination<$vaccination>';
}

// 1
// _vaccinationFromJson transforma um mapa de valores do Firestore em uma classe de vacinação.

Vaccination _vaccinationFromJson(Map<String, dynamic> json) {
  return Vaccination(
    json['vaccination'] as String,
    date: (json['date'] as Timestamp).toDate(),
    done: json['done'] as bool,
  );
}

// 2
// _vaccinationToJson converte a classe de vacinação em um mapa de pares chave/valor.

Map<String, dynamic> _vaccinationToJson(Vaccination instance) =>
    <String, dynamic>{
      'vaccination': instance.vaccination,
      'date': instance.date,
      'done': instance.done,
    };
