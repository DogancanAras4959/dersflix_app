import 'dart:ui';

import 'package:dersflix_app/provider/student_provider.dart';
import 'package:dersflix_app/screens/onboding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../datas/students.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var txtname = TextEditingController();
  var txtokul = TextEditingController();
  var txtsinif = TextEditingController();
  var txttel = TextEditingController();
  var txttck = TextEditingController();
  var txtalan = TextEditingController();
  var txtsube = TextEditingController();
  var txtveliname = TextEditingController();
  var txtvelitel = TextEditingController();
  var txtveliadres = TextEditingController();
  var txtuser = TextEditingController();
  var txtpassword = TextEditingController();
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  tapped(int step) {
    setState(() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _currentStep = step;
      }
    });
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  void dispose() {
    txtokul.dispose();
    txtname.dispose();
    txtsinif.dispose();
    txttel.dispose();
    txttck.dispose();
    txtalan.dispose();
    txtsube.dispose();
    txtveliname.dispose();
    txtvelitel.dispose();
    txtveliadres.dispose();
    txtuser.dispose();
    txtpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                "Öğrenci Kaydı",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: appleBackgroundColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1,
                  0.9
                ],
                colors: [
                  Color(0xFFFF5530),
                  Color(0xFFD53C1A),
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Stepper(
                      steps: stepList(
                          context,
                          _currentStep,
                          txtname,
                          txtalan,
                          txtokul,
                          txtsinif,
                          txtsube,
                          txttck,
                          txttel,
                          txtveliadres,
                          txtveliname,
                          txtvelitel,
                          txtuser,
                          txtpassword),
                      onStepContinue: continued,
                      onStepTapped: (step) => tapped(step),
                      onStepCancel: cancel,
                      currentStep: _currentStep,
                      physics: const ClampingScrollPhysics(),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails controls) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _currentStep == 3
                              ? []
                              : <Widget>[
                                  if (_currentStep == 0)
                                    const SizedBox(
                                      height: 0,
                                    )
                                  else
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            250, 96, 40, 109),
                                      ),
                                      onPressed: controls.onStepCancel,
                                      child: const Text('Geri',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          250, 96, 40, 109),
                                    ),
                                    onPressed: controls.onStepContinue,
                                    child: const Text('İleri',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Step> stepList(
  BuildContext context,
  int _currentStep,
  TextEditingController txtname,
  TextEditingController txtalan,
  TextEditingController txtokul,
  TextEditingController txtsinif,
  TextEditingController txtsube,
  TextEditingController txttck,
  TextEditingController txttel,
  TextEditingController txtveliadres,
  TextEditingController txtveliname,
  TextEditingController txtvelitel,
  TextEditingController txtuser,
  TextEditingController txtpassword,
) {
  final studentProvider = Provider.of<StudentProvider>(context);

  return <Step>[
    Step(
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 0,
      title: const Text('Öğrenci Bilgileri',
          style: TextStyle(color: Colors.white)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autocorrect: false,
            controller: txtname,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Adınızı Soyadınızı giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autocorrect: false,
            controller: txttck,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'TC Kimlik No giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autocorrect: false,
            controller: txtsube,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Kayıtlı Şubenizi Giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autocorrect: false,
            controller: txttel,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Telefon Numaranızı Giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            keyboardType: TextInputType.phone,
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
        ],
      ),
    ),
    Step(
        state: _currentStep <= 1 ? StepState.editing : StepState.complete,
        isActive: _currentStep >= 1,
        title:
            const Text('Okul Bilgileri', style: TextStyle(color: Colors.white)),
        content: Column(
          children: [
            TextFormField(
              autocorrect: false,
              controller: txtsinif,
              decoration: InputDecoration(
                  errorStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintText: 'Sınıfınızı Giriniz...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.person_outline)),
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'Bu alan zorunludur!';
              },
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              autocorrect: false,
              controller: txtalan,
              decoration: InputDecoration(
                  errorStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintText: 'Alanınızı Giriniz...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.person_outline)),
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'Bu alan zorunludur!';
              },
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              autocorrect: false,
              controller: txtokul,
              decoration: InputDecoration(
                  errorStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintText: 'Okulunuzu Giriniz...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.person_outline)),
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'Bu alan zorunludur!';
              },
            ),
          ],
        )),
    Step(
      state: _currentStep <= 2 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 2,
      title:
          const Text('Veli Bilgileri', style: TextStyle(color: Colors.white)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autocorrect: false,
            controller: txtveliname,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Veli Adı Soyadını giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autocorrect: false,
            controller: txtvelitel,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Telefon Numarasını Giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.multiline,
            controller: txtveliadres,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Adres Giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: _currentStep >= 0,
      state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
      title: const Text(
        'Oturum Bilgileri',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autocorrect: false,
            controller: txtuser,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Kullanıcı adınızı giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autocorrect: false,
            controller: txtpassword,
            obscureText: true,
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                hintText: 'Şifrenizi giriniz...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.person_outline)),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            disabledColor: Colors.grey,
            color: buttonColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Kayıt Ol',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
            onPressed: () {
              StudentsModel model = StudentsModel(
                school: txtokul.text,
                isActive: true,
                image: 'image.png',
                studentName: txtname.text,
                countryId: txttck.text,
                classLevel: txtsinif.text,
                branch: txtsube.text,
                phone: txttel.text,
                area: txtalan.text,
                parentName: txtveliname.text,
                parentPhone: txtvelitel.text,
                parentAddress: txtveliadres.text,
                userId: 1,
                id: null,
                user: null,
                userName: txtuser.text,
                password: txtpassword.text,
              );
              studentProvider.insertStudentProvider(model);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Kayıt işlemi yapılıyor, veriler işleniyor...')),
              );

              _showDialog(context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Giriş Ekranına Geri Dön',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ];
}

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack, {super.key});

  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Giriş Ekranına Dön"),
              onPressed: () {
                continueCallBack();
              },
            ),
          ],
        ));
  }
}

_showDialog(BuildContext context) {
  continueCallBack() => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      };

  BlurryDialog alert = BlurryDialog(
      "Başarılı", "Kayıt İşlemi başarıyla tamamlandı!", continueCallBack);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
