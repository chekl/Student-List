import 'package:flutter/material.dart';

class Department {

  const Department({
    required this.id,
    required this.name,
    this.color = Colors.white,
    required this.icon,
  });

  final String id, name;
  final IconData icon;
  final Color color;
}