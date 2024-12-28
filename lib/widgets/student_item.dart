import 'package:flutter/material.dart';
import '../models/students.dart';
import '../models/department.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const StudentCard({
    super.key,
    required this.student,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final color = student.gender == Gender.male
        ? departmentColors[student.department]!.withOpacity(0.3)
        : Colors.pinkAccent.withOpacity(0.2);

    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: departmentColors[student.department],
          child: Icon(departmentIcons[student.department], color: Colors.white),
        ),
        title: Text('${student.firstName} ${student.lastName}'),
        subtitle: Text(
          'Score: ${student.grade}',
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
