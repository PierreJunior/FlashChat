import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  late String error = ' ';
  bool _btnActive = false;
  late String email;
  late String password;
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordRepeat = TextEditingController();
  RegExp passCheck = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  String wrongPass = "Your password must be at least 8 characters including a \n lowercase letter, an uppercase letter, and a number";

  @override
  void initState() {
    super.initState();
  }

  bool emptyForm() {
    if (_controllerPassword.text.isEmpty || _controllerEmail.text.isEmpty) {
      _btnActive;
    } else {
      _btnActive = true;
    }
    return _btnActive;
  }

  void registerCheck() async {
    try {
      _saving = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (!mounted) return;
      Navigator.pushNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      _saving = false;
      //error = e.message.toString();
      showNotification(e.message.toString(), 5, Colors.red);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                      labelText: 'Enter your Email'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validatePassword(value),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                      password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter your password'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _controllerPasswordRepeat,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validatePasswordRepeat(value),
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter your password again'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    colour: Colors.blueAccent,
                    pressed: () async {
                      if (_formKey.currentState!.validate()){
                        registerCheck();
                      }
                    },
                    title: 'Register')
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

  String? validatePasswordRepeat(String? value) {
    if (value == null || value.isEmpty || !passCheck.hasMatch(value) || value != password)
    {
      return 'Password does not match';
    }
    return null;
  }
}
