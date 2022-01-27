// Copyright (c) 2021 Razeware LLC

import 'package:flutter/material.dart';

import 'models/pets.dart';
import 'widgets/text_field.dart';
import 'models/vaccination.dart';
import 'widgets/date_picker.dart';
import 'widgets/vaccinated_check_box.dart';

class AddVaccination extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddVaccination({Key? key, required this.pet, required this.callback})
      : super(key: key);
  @override
  _AddVaccinationState createState() => _AddVaccinationState();
}

class _AddVaccinationState extends State<AddVaccination> {
  final _formKey = GlobalKey<FormState>();

  late Pet pet;
  var done = false;
  var vaccination = '';
  late DateTime vaccinationDate;

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Vaccination'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                UserTextField(
                  name: 'vaccination',
                  initialValue: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Vaccination Name';
                    }
                  },
                  inputType: TextInputType.text,
                  onChanged: (value) {
                    if (value != null) {
                      vaccination = value;
                    }
                  },
                ),
                DatePicker(
                    name: 'Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Vaccination Date';
                      }
                    },
                    onChanged: (text) {
                      vaccinationDate = text;
                    }),
                VaccinatedCheckBox(
                    name: 'Given',
                    value: done,
                    onChanged: (text) {
                      done = text ?? done;
                    }),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                  final newVaccination = Vaccination(vaccination,
                      date: vaccinationDate, done: done);
                  pet.vaccinations.add(newVaccination);
                }
                widget.callback();
              },
              child: const Text('Add')),
        ]);
  }
}
