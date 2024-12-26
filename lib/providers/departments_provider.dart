import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart';

final departmentsProvider = Provider((ref) {
  return [
    const Department(id: "1", name: "It", icon: Icons.computer, color: Colors.pink),
    const Department(id: "2", name: "Finance", icon: Icons.currency_bitcoin, color: Colors.blue),
    const Department(id: "3", name: "Law", icon: Icons.menu_book, color: Colors.green),
    const Department(id: "4", name: "Medical", icon: Icons.medical_services, color: Colors.yellow),
  ];
});
