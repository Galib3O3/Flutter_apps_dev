import 'package:app/forgot.dart';
import 'package:app/home.dart';
import 'package:app/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidepass = true;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final eField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Email Required");
          //regex for mail varification
        }
        //regex for email varifivation
        if (!RegExp("^[a-z0-9]+@(gmail|yahoo|lus.ac.bd|hotmail|).[a-z]{2,3}")
            .hasMatch(value)) {
          return ("Oops! Enter the valid mail");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    ); // email field
    final pField = TextFormField(
      autofocus: false,
      obscureText: hidepass,
      controller: passwordController,
      validator: (Value) {
        RegExp rgx = new RegExp(r'^.{10,}$');
        if (Value!.isEmpty) {
          return ("Password is Required");
        }
        if (!rgx.hasMatch(Value)) {
          return ("Use valid password \n password contains 10 latters");
        }
        return null;
      },
      onSaved: (newvalue) => passwordController.text = newvalue!,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) => SignIn,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffix: GestureDetector(
            onTap: (() => setState(() => hidepass = !hidepass)),
            child: Icon(hidepass ? Icons.visibility : Icons.visibility_off),
          ),
          //suffixIcon: ,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final loginBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 14, 99, 237),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          SignIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "img/sv.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    eField,
                    SizedBox(
                      height: 25,
                    ),
                    pField,
                    SizedBox(
                      height: 35,
                    ),
                    loginBtn,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forgotPass(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: Colors.blueAccent[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("           Don't have any Account  ?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => regscreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login
  Future<void> SignIn(String email, String Pass) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: Pass)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Congrats Login Successfully"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => home())),
              })
          .catchError((err) {
        Fluttertoast.showToast(msg: err!.message);
      });
    }
  }
}
