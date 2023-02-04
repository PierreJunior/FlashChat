import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  late String email;
  late String password;
  late String messag = ' ';
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  RegExp passCheck = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  String wrongPass = "The password that you've entered is incorrect.";

  @override
  void initState() {
    super.initState();
  }

  void showNotification(String message, int duration, Color color) {
    Flushbar(
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: duration),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  void loginCheck() async {
    try {
      _saving = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.pushNamed(context, ChatScreen.id);
      _saving = false;
    } on FirebaseAuthException catch (e) {
      _saving = false;
      if (e.message != null) {
        messag = e.message!;
      }
      showNotification(messag, 5, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  controller: _controllerEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.compose([
                    Validators.required('Email is required'),
                    Validators.email('Invalid email address'),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  validator: (value) => validatePassword(value),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password'),
                ),
                //Text(messag),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    colour: Colors.lightBlueAccent,
                    pressed: () async {
                      if (_formkey.currentState!.validate()) {
                        loginCheck();
                      }
                    },
                    title: 'Log In')
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || !passCheck.hasMatch(value))
    {
      return wrongPass;
    }
    return null;
  }
}
