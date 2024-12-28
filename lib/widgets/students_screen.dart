import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/students.dart';
import '../widgets/new_student.dart';
import '../widgets/student_item.dart';
import '../providers/students_provider.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void _showNewStudentModal(BuildContext context, WidgetRef ref,
      {int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateOrEditStudent(studentIndex: index,),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    return Scaffold(
      body: students.students.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No students available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemCount: students.students.length,
              itemBuilder: (context, index) {
                final student = students.students[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StudentCard(
                    student: student,
                    onDelete: () {
                      ref.read(studentsProvider.notifier).remove(index);
                      final container = ProviderScope.containerOf(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Student deleted'),
                          action: SnackBarAction(
                            label: 'Restore',
                            onPressed: () {
                              container.read(studentsProvider.notifier).restore();
                            },
                          ),
                        ),
                      ).closed.then((value) {
                        if (value != SnackBarClosedReason.action) {
                          ref.read(studentsProvider.notifier).getRid();
                        }
                      });
                    },
                    onEdit: () => _showNewStudentModal(
                      context,
                      ref,
                      index: index,
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          border: const Border(
            top: BorderSide(color: Colors.indigo, width: 1),
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: () => _showNewStudentModal(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.add, size: 20),
          label: const Text(
            'Add New Student',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
