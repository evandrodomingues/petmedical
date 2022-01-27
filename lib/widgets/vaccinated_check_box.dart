// Copyright (c) 2021 Razeware LLC

import 'package:flutter/material.dart';

class VaccinatedCheckBox extends StatefulWidget {
  final String name;
  final bool value;
  final Function(bool?) onChanged;
  const VaccinatedCheckBox(
      {Key? key,
      required this.name,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  _VaccinatedCheckBoxState createState() => _VaccinatedCheckBoxState();
}

class _VaccinatedCheckBoxState extends State<VaccinatedCheckBox> {
  late bool checked;

  @override
  void initState() {
    checked = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.name),
        contentPadding: const EdgeInsets.only(left: 0.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: checked,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              checked = value;
              widget.onChanged(value);
            });
          }
        });
  }
}
