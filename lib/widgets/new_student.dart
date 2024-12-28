import 'package:flutter/material.dart';
import '../models/students.dart';
import '../models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

class CreateOrEditStudent extends ConsumerStatefulWidget {
  final int? studentIndex;

  const CreateOrEditStudent({
    super.key,
    this.studentIndex
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateOrEditStudentState();
}

class _CreateOrEditStudentState extends ConsumerState<CreateOrEditStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _scoreController = TextEditingController();
  Department? _selectedDepartment;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider).students[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _scoreController.text = student.grade.toString();
      _selectedGender = student.gender;
      _selectedDepartment = student.department;
    }
  }

  void enterStudent() async {
     final grade = int.tryParse(_scoreController.text);

    if (grade == null || _selectedDepartment == null || _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.studentIndex != null) {
      await ref.read(studentsProvider.notifier).edit(
            widget.studentIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            grade,
          );
    } else {
      await ref.read(studentsProvider.notifier).add(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            grade,
          );
    }

    if (!context.mounted) return;

    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Department>(
              value: _selectedDepartment,
              decoration: const InputDecoration(labelText: 'Department'),
              items: Department.values.map((dept) {
                return DropdownMenuItem(
                  value: dept,
                  child: Row(
                    children: [
                      Icon(departmentIcons[dept], color: departmentColors[dept]),
                      const SizedBox(width: 8),
                      Text(departmentNames[dept]!),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedDepartment = value),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Gender>(
              value: _selectedGender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: Gender.values.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender == Gender.male ? 'Male' : 'Female'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _scoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Grade (0-100)'),
              onChanged: (value) {
                if (int.tryParse(value) == null) {
                  _scoreController.text = '0';
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: enterStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
