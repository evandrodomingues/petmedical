// Copyright (c) 2021 Razeware LLC

import 'package:flutter/material.dart';

import 'models/pets.dart';
import 'models/vaccination.dart';

class VaccinationList extends StatelessWidget {
  final Pet pet;
  final Widget Function(Vaccination) buildRow;
  const VaccinationList({Key? key, required this.pet, required this.buildRow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 6.0),
        const Text(
          'Vaccinations',
          style: TextStyle(fontSize: 16.0),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: pet.vaccinations.length,
            itemBuilder: (BuildContext context, int index) {
              return buildRow(
                pet.vaccinations[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
