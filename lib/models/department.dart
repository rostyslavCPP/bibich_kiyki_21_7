import 'package:flutter/material.dart';

enum Department { finance, law, it, medical }

const Map<Department, String> departmentNames = {
  Department.finance: 'Finance',
  Department.law: 'Law',
  Department.it: 'IT',
  Department.medical: 'Medical',
};

const Map<Department, IconData> departmentIcons = {
  Department.finance: Icons.attach_money,
  Department.law: Icons.scale,
  Department.it: Icons.devices_other,
  Department.medical: Icons.local_hospital,
};

const Map<Department, Color> departmentColors = {
  Department.finance: Colors.green,
  Department.law: Colors.red,
  Department.it: Colors.blue,
  Department.medical: Colors.purple,
};
