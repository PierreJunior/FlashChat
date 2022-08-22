import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late FToast fToast;
  late String error = ' ';
  late String email;
  late String password;
  RegExp passCheck = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  String wrongPass = 'Password should contain a small letter and a Number';
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                validator: Validators.compose([
                  Validators.required('Email is required'),
                  Validators.email('Invalid email address'),
                ]),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(labelText: 'Email'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
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
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          if (!mounted) return;
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        //error = e.message.toString();
                        fToast.showToast(
                            child: Text('pierre'),
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
                    }
                  },
                  title: 'Register')
            ],
          ),
        ),
      ),
    );
  }
}
