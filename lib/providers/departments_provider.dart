import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/data/dummy_data.dart';

final departmentsProvider = Provider((ref) {
  return availableDepartments;
});
