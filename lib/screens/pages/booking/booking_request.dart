import 'package:date_format/date_format.dart';
import 'package:dersflix_app/datas/bookingReq.dart';
import 'package:dersflix_app/provider/booking_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/student_provider.dart';
import '../../../provider/study_provider.dart';
import '../../../provider/user_provider.dart';
import 'book_detail_list.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({Key? key}) : super(key: key);

  @override
  State<BookingRequest> createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  int _activeStepIndex = 0;
  final _formKey = GlobalKey<FormState>();

  double? height;
  double? width;
  String? setTime, setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedValueDate = DateTime.now();

  TimeOfDay selectedValueTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String? selectedValueStudy;
  String? selectedValueStudent;
  String? selectedValueTeachers;
  String? selectedValueTip;

  @override
  void initState() {
    dateController.text = DateFormat("dd-MM-yyyy").format(DateTime.now());
    timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingRequestProvider = Provider.of<BookingReqProvider>(context);

    final studyProvider = Provider.of<StudyProvider>(context);
    studyProvider.getStudies();
    var studyList = studyProvider.studyList;

    final studentProvider = Provider.of<StudentProvider>(context);
    studentProvider.getStudents();
    var studentList = studentProvider.studentList;

    final teacherProvider = Provider.of<UserProvider>(context);
    teacherProvider.getUsers();
    var teacherList = teacherProvider.userList;

    Future<void> selectDate(context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedValueDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null) {
        setState(() {
          selectedValueDate = picked;
          dateController.text =
              DateFormat("dd-MM-yyyy").format(selectedValueDate);
        });
      }
    }

    Future<void> _selectTime(context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedValueTime,
      );
      if (picked != null) {
        setState(() {
          selectedValueTime = picked;
          _hour = selectedValueTime.hour.toString();
          _minute = selectedValueTime.minute.toString();
          _time = "$_hour: + ${_minute!}";
          timeController.text = _time!;
          timeController.text = formatDate(
              DateTime(2019, 08, 1, selectedValueTime.hour,
                  selectedValueTime.minute),
              [hh, ':', nn]).toString();
        });
      }
    }

    List<DropdownMenuItem<String>> dropdownItemsStudies = studyList
        .map(
          (items) => DropdownMenuItem<String>(
            value: items.studyName,
            child: Text(
              items.studyName,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        )
        .toList();

    List<DropdownMenuItem<String>> dropdownItemsStudents = studentList
        .map(
          (items) => DropdownMenuItem<String>(
            value: items.studentName,
            child: Text(
              items.studentName,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        )
        .toList();

    List<DropdownMenuItem<String>> dropdownItemsTeacher = teacherList
        .map(
          (items) => DropdownMenuItem<String>(
            value: items.displayName,
            child: Text(
              items.displayName,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        )
        .toList();

    List<Step> stepList() => [
          Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Talebi Oluştur'),
            content: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: const [
                            Text(
                              "Randevunuzu aşağıdaki bilgileri doldurarak oluşturun!",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Öğrenci Seç",
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              hint: const Text("Bir öğrenci seçin"),
                              dropdownColor: Colors.white,
                              items: dropdownItemsStudents,
                              elevation: 2,
                              value: selectedValueStudent,
                              isDense: true,
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? "Seçim yapınız" : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValueStudent = newValue!;
                                });
                              },
                              onSaved: (value) => setState(() {
                                selectedValueStudent = value.toString();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Öğretmen Seç",
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              hint: const Text("Bir öğretmen seçin"),
                              dropdownColor: Colors.white,
                              items: dropdownItemsTeacher,
                              isDense: true,
                              elevation: 2,
                              isExpanded: true,
                              value: selectedValueTeachers,
                              validator: (value) =>
                                  value == null ? "Seçim yapınız" : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValueTeachers = newValue!;
                                });
                              },
                              onSaved: (value) => setState(() {
                                selectedValueTeachers = value.toString();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Ders Seç",
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              hint: const Text("Bir ders seçin"),
                              dropdownColor: Colors.white,
                              items: dropdownItemsStudies,
                              elevation: 2,
                              value: selectedValueStudy,
                              isDense: true,
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? "Seçim yapınız" : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValueStudy = newValue!;
                                });
                              },
                              onSaved: (value) => setState(() {
                                selectedValueStudy = value.toString();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Konu Seç",
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              hint: const Text("Bir konu seçin"),
                              dropdownColor: Colors.white,
                              items: dropdownItemsTeacher,
                              isDense: true,
                              elevation: 2,
                              isExpanded: true,
                              value: selectedValueTeachers,
                              validator: (value) =>
                                  value == null ? "Seçim yapınız" : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValueTip = newValue!;
                                });
                              },
                              onSaved: (value) => setState(() {
                                selectedValueTip = value.toString();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Şube Seç",
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              hint: const Text("Bir şube seçin"),
                              dropdownColor: Colors.white,
                              items: dropdownItemsTeacher,
                              isDense: true,
                              elevation: 2,
                              isExpanded: true,
                              value: selectedValueTeachers,
                              validator: (value) =>
                                  value == null ? "Seçim yapınız" : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValueTip = newValue!;
                                });
                              },
                              onSaved: (value) => setState(() {
                                selectedValueTip = value.toString();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 18),
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: dateController,
                                      onSaved: (String? val) {
                                        setDate = val;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Tarih Seç",
                                        labelStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _selectTime(context);
                                    },
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 18),
                                      onSaved: (String? val) {
                                        setTime = val;
                                      },
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: timeController,
                                      decoration: InputDecoration(
                                        labelText: "Saat Seç",
                                        labelStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // labelText: 'Time',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Bitir'),
            content: Center(
              child: Container(
                width: 350,
                height: MediaQuery.of(context).size.height - 210,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: selectedValueStudent != null &&
                        selectedValueTeachers != null &&
                        selectedValueStudy != null &&
                        selectedValueTip != null &&
                        setTime != null &&
                        setDate != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Randevu Oluşturma İşlemi Tamamlandı!",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Öğrenci",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left),
                                  Text(selectedValueStudent!,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Zaman",
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left),
                                  Text('${setDate!} ${setTime!}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Ders",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                      textAlign: TextAlign.left),
                                  Text(selectedValueStudy!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Öğretmen",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                      textAlign: TextAlign.left),
                                  Text(selectedValueTeachers!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      textAlign: TextAlign.right),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Bookings()));
                                    },
                                    child: const Text(
                                      "Randevulara Dön",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(),
              ),
            ),
          ),
        ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Randevu Oluşturma"),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.green,
                  background: Colors.red,
                  secondary: Colors.green,
                ),
          ),
          child: Stepper(
            type: StepperType.horizontal,
            steps: stepList(),
            currentStep: _activeStepIndex,
            onStepContinue: () {
              if (_activeStepIndex < (stepList().length - 1)) {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _activeStepIndex += 1;

                    BookingReq model = BookingReq(
                      id: null,
                      bookingTime: "$setDate $setTime",
                      studyName: selectedValueStudy.toString(),
                      studentName: selectedValueStudent.toString(),
                      teacherName: selectedValueTeachers.toString(),
                      content: selectedValueTip.toString(),
                      tip: selectedValueTip.toString(),
                      place: selectedValueTip.toString(),
                    );

                    bookingRequestProvider.insertBookingRequestProvider(model);
                  }
                });
              }
            },
            onStepCancel: () {
              if (_activeStepIndex == 0) {
                return;
              }
              setState(() {
                _activeStepIndex -= 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _activeStepIndex = index;
                }
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _activeStepIndex == 1
                    ? []
                    : <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(250, 96, 40, 109),
                          ),
                          onPressed: controls.onStepCancel,
                          child: const Text('Geri',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(250, 96, 40, 109),
                          ),
                          onPressed: controls.onStepContinue,
                          child: const Text('Tamamla',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
              );
            },
          ),
        ),
      ),
    );
  }
}
