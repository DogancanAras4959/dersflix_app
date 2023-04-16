import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/student_provider.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    final students = Provider.of<StudentProvider>(context);
    students.getStudents();
    var studentList = students.studentList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Öğrenciler",
        ),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(studentList[index].studentName),
                  subtitle: Text("${studentList[index].classLevel}. Sınıf"),
                  leading: const Icon(
                    Icons.account_circle_rounded,
                    size: 40,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
