// Copyright (c) 2021 Razeware LLC

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pet_medical/repositories/data_repository.dart';

import 'models/pets.dart';
import 'add_vaccination.dart';
import 'vaccination_list.dart';
import 'widgets/text_field.dart';
import 'models/vaccination.dart';
import 'widgets/choose_chips.dart';

class PetDetail extends StatefulWidget {
  final Pet pet;

  const PetDetail({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  //
  // Adiciona o repositorio de dados

  final DataRepository repository = DataRepository();

  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late List<CategoryOption> animalTypes;
  late String name;
  late String type;
  String? notes;

  @override
  void initState() {
    type = widget.pet.type;
    name = widget.pet.name;
    animalTypes = [
      CategoryOption(type: 'cat', name: 'Cat', isSelected: type == 'cat'),
      CategoryOption(type: 'dog', name: 'Dog', isSelected: type == 'dog'),
      CategoryOption(type: 'other', name: 'Other', isSelected: type == 'other'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: double.infinity,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'Pet Name',
                initialValue: widget.pet.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input name';
                  }
                },
                inputType: TextInputType.name,
                onChanged: (value) => name = value ?? name,
              ),
              ChooseType(
                title: 'Animal Type',
                options: animalTypes,
                onOptionTap: (value) {
                  setState(
                    () {
                      for (var element in animalTypes) {
                        type = value.type;
                        element.isSelected = element.type == value.type;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20.0),
              UserTextField(
                name: 'notes',
                initialValue: widget.pet.notes ?? '',
                validator: (value) {},
                inputType: TextInputType.text,
                onChanged: (value) => notes = value,
              ),
              VaccinationList(pet: widget.pet, buildRow: buildRow),
              FloatingActionButton(
                onPressed: () {
                  _addVaccination(
                    widget.pet,
                    () {
                      setState(
                        () {},
                      );
                    },
                  );
                },
                tooltip: 'Add Vaccination',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () {
                      Navigator.of(context).pop();
                      repository.deletePet(widget.pet);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        widget.pet.name = name;
                        widget.pet.type = type;
                        widget.pet.notes = notes ?? widget.pet.notes;

                        repository.updatePet(widget.pet);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(Vaccination vaccination) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(vaccination.vaccination),
        ),
        Text(
          dateFormat.format(vaccination.date),
        ),
        Checkbox(
          value: vaccination.done ?? false,
          onChanged: (newValue) {
            setState(
              () {
                vaccination.done = newValue;
              },
            );
          },
        )
      ],
    );
  }

  void _addVaccination(Pet pet, Function callback) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AddVaccination(pet: pet, callback: callback);
      },
    );
  }
}
