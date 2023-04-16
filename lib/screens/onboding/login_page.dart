import 'dart:ui';

import 'package:dersflix_app/constants.dart';
import 'package:dersflix_app/provider/student_provider.dart';
import 'package:dersflix_app/screens/onboding/into_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../entryPoint/entry_point.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtCorrect = TextEditingController();
  var txtPassword = TextEditingController();
  var checkBoxValue = true;

  @override
  void dispose() {
    txtCorrect.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  void _onRememberMeChanged(bool? newValue) => setState(() {
        checkBoxValue = newValue!;

        if (checkBoxValue) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appleBackgroundColor,
      body: SafeArea(
        child: Container(
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
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, bottom: 0.0, top: 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hoşgeldiniz,',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Hesabınızda oturum açın!',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      personIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  loginForm(context, txtCorrect, txtPassword),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form loginForm(BuildContext context, TextEditingController txtCorrect,
      TextEditingController txtPassword) {
    final user = Provider.of<UserProvider>(context);
    user.getUsers();

    final students = Provider.of<StudentProvider>(context);
    students.getStudents();

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            controller: txtCorrect,
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
            controller: txtPassword,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              hintText: '*********',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  _passwordVisible = !_passwordVisible;
                },
              ),
            ),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Bu alan zorunludur!';
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Şifreni mi unuttun?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: checkBoxValue,
                    onChanged: _onRememberMeChanged,
                    activeColor: Colors.white,
                    checkColor: Colors.black54,
                  ),
                  const Text("Beni Hatırla",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
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
                    'Giriş Yap',
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
              var userHave = user.userList;
              var studentHave = students.studentList;

              if (userHave
                      .where((e) => e.userName == txtCorrect.text)
                      .isNotEmpty &&
                  userHave
                      .where((e) => e.password == txtPassword.text)
                      .isNotEmpty) {
                if (userHave.where((e) => e.isActive).any((element) => true)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EntryPoint(txtCorrect.text, true, "teacher"),
                    ),
                  );
                }
              } else if (studentHave
                      .where((e) => e.userName == txtCorrect.text)
                      .isNotEmpty &&
                  studentHave
                      .where((e) => e.password == txtPassword.text)
                      .isNotEmpty) {
                if (studentHave
                    .where((e) => e.isActive)
                    .any((element) => true)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EntryPoint(txtCorrect.text, true, "student"),
                    ),
                  );
                }
              } else {
                _showDialog(context);
              }
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardingScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Öğrenci Kaydı Oluştur",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Column personIcon() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: const [
      Icon(
        Icons.account_circle_rounded,
        color: Colors.white,
        size: 50,
      ),
    ],
  );
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
              child: const Text("Kapat"),
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
        Navigator.of(context).pop(),
      };

  BlurryDialog alert = BlurryDialog("Başarısız Giriş",
      "Kullanıcı adınız veya şifreniz hatalı!", continueCallBack);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
