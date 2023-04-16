import 'package:dersflix_app/datas/booking.dart';
import 'package:dersflix_app/datas/students.dart';
import 'package:dersflix_app/model/lessons.dart';
import 'package:dersflix_app/provider/student_provider.dart';
import 'package:dersflix_app/provider/user_provider.dart';
import 'package:dersflix_app/screens/home/components/header_section.dart';
import 'package:dersflix_app/screens/home/components/lesson_list.dart';
import 'package:dersflix_app/screens/home/components/program_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datas/users.dart';
import '../../model/items.dart';
import '../../provider/booking_provider.dart';
import '../pages/accountpackages/package_detail_list.dart';
import '../pages/booking/book_detail_list.dart';
import '../pages/exams/exam_detail_list.dart';
import '../pages/messages/messages_detail_list.dart';
import '../pages/students/students_detail_list.dart';
import '../pages/studies/studies_detail_list.dart';
import '../pages/teachers/teacher_detail.dart';
import 'components/page_item_list.dart';
import 'components/teachers_list.dart';
import 'components/title_section.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.username, this.role, {super.key});

  final String username, role;

  @override
  State<HomePage> createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    bookingProvider.getBookings();

    List<Booking> bookingListByOne =
        bookingProvider.bookingList.cast<Booking>();
    bookingListByOne.sort((a, b) => b.bookingTime.compareTo(a.bookingTime));

    final userProvider = Provider.of<UserProvider>(context);
    userProvider.getUsers();
    var userList = userProvider.userList;

    final studentProvider = Provider.of<StudentProvider>(context);
    var studentList = studentProvider.studentList;

    Users? userData = userList
        .cast<Users?>()
        .firstWhere((e) => e!.userName == widget.username, orElse: () => null);

    StudentsModel? dataStudent = studentList.cast<StudentsModel?>().firstWhere(
        (element) => element!.userName == widget.username,
        orElse: () => null);

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              HeaderSection(userData != null
                  ? userData.displayName
                  : dataStudent!.studentName),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      width: 75,
                      height: 75,
                      margin: const EdgeInsets.only(top: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: const Color.fromARGB(250, 96, 40, 109),
                      ),
                      child: const Text(
                        "Öğretmenlerimiz",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ...userList
                        .map(
                          (item) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TeacherDetail()));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: TeacherList(
                                      title: item.displayName,
                                      image: item.image))),
                        )
                        .toList(),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TitleSection(
                title: 'Yaklaşan Randevunuz',
                color: Color.fromARGB(250, 96, 40, 109),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 2),
                  shrinkWrap: true,
                  children: bookingListByOne
                      .take(1)
                      .map(
                        (item) => ProgramCard(
                          title: item.studyName,
                          time: item.bookingTime,
                        ),
                      )
                      .toList()),
              const SizedBox(
                height: 15,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 13,
                    crossAxisCount: 2,
                    childAspectRatio: 5.5 / 2),
                children: itemsHome
                    .map(
                      (items) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              switch (items.title) {
                                case "Öğrenciler":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Students()));
                                  break;

                                case "Sınavlar":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Exams()));
                                  break;

                                case "Dersler":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Studies()));
                                  break;

                                case "Randevular":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Bookings()));
                                  break;

                                case "Mesajlar":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Messages()));
                                  break;

                                case "Paketler":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Package()));
                                  break;
                              }
                            },
                            child: PageItemList(
                              title: items.title,
                              imageAsset: items.image,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              const TitleSection(
                title: 'Yaklaşan Sınavlar',
                color: Color.fromARGB(250, 96, 40, 109),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: lessonList
                      .map(
                        (items) => LessonList(
                            Name: items.Name,
                            assetImage: items.Image,
                            TextColor: items.TextColor),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
