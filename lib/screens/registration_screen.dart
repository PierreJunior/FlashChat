import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
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
  final bool _saving = false;
  late FToast fToast;
  late String error = ' ';
  bool _btnActive = false;
  late String email;
  late String password;
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  RegExp passCheck = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  String wrongPass = 'Password should contain a small letter and a Number';
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
      // _saving = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (!mounted) return;
      Navigator.pushNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      // _saving = false;
      if (e.code == 'weak-password') {
        errorMessage(e, wrongPass);
      } else if (e.code == 'invalid-email') {
        errorMessage(e, e.message.toString());
      } else {
        errorMessage(e, e.message.toString());
      }
    }
  }

  void errorMessage(FirebaseAuthException e, String message) {
    fToast.showToast(
        child: Text(message),
        toastDuration: const Duration(seconds: 5),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 150,
            left: 16,
            right: 16,
            child: child,
          );
        });
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
                  obscureText: false,
                  validator: Validators.compose([
                    Validators.required('Password is required'),
                    Validators.patternRegExp(
                        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"),
                        wrongPass),
                  ]),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter your password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    colour: Colors.blueAccent,
                    pressed: () {
                      setState(() {
                        emptyForm() == false
                            ? fToast.showToast(
                                child: const Text(
                                    "Email or Password can't be empty"),
                                toastDuration: const Duration(seconds: 5),
                                positionedToastBuilder: (context, child) {
                                  return Positioned(
                                    bottom: 170,
                                    left: 16,
                                    right: 16,
                                    child: child,
                                  );
                                })
                            : () {
                                registerCheck();
                              };
                      });
                    },
                    title: 'Register')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
