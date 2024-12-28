import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart';
import '../widgets/department_item.dart';
import '../providers/students_provider.dart';

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.watch(studentsProvider);

    if (currentState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Map<Department, int> departmentStudentCounts = {};
    for (var department in Department.values) {
      departmentStudentCounts[department] =
          currentState.students.where((s) => s.department == department).length;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: Department.values.length,
          itemBuilder: (context, index) {
            final department = Department.values[index];
            final studentCount = departmentStudentCounts[department] ?? 0;

            return Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${departmentNames[department]}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: DepartmentItem(
                  name: departmentNames[department]!,
                  studentCount: studentCount,
                  color: departmentColors[department]!,
                  icon: departmentIcons[department]!,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
