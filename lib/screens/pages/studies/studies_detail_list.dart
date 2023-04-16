import 'package:dersflix_app/provider/study_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Studies extends StatefulWidget {
  const Studies({Key? key}) : super(key: key);

  @override
  State<Studies> createState() => _ExamsState();
}

class _ExamsState extends State<Studies> {
  @override
  Widget build(BuildContext context) {
    final studies = Provider.of<StudyProvider>(context);
    studies.getStudies();
    var studyList = studies.studyList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dersler",
        ),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: studyList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(studyList[index].studyName),
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
