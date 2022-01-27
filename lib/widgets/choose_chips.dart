// Copyright (c) 2021 Razeware LLC

import 'package:flutter/material.dart';

class ChooseType extends StatelessWidget {
  const ChooseType({
    required this.title,
    required this.options,
    required this.onOptionTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final List<CategoryOption> options;
  final ValueChanged<CategoryOption> onOptionTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(
                height: 12,
              ),
              _OptionList(
                options: options,
                onOptionTap: onOptionTap,
              ),
            ],
          ),
        ),
      );
}

class _OptionList extends StatelessWidget {
  const _OptionList({
    required this.options,
    required this.onOptionTap,
    Key? key,
  }) : super(key: key);
  final List<CategoryOption> options;
  final ValueChanged<CategoryOption> onOptionTap;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 10,
        children: [
          ...options
              .map(
                (option) => FilterChip(
                  label: Text(
                    option.name,
                    style: TextStyle(
                      color: option.isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  onSelected: (_) => onOptionTap(option),
                  selected: option.isSelected,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue[300],
                  checkmarkColor: Colors.white,
                ),
              )
              .toList(),
        ],
      );
}

class CategoryOption {
  CategoryOption({
    required this.type,
    required this.name,
    required this.isSelected,
  });
  final String type;
  final String name;
  bool isSelected;
}
