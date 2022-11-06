import 'package:app/function/user_func.dart';
import 'package:app/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class regscreen extends StatefulWidget {
  const regscreen({super.key});

  @override
  State<regscreen> createState() => _regscreenState();
}

class _regscreenState extends State<regscreen> {
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  bool hidepass = true;

  //1st Name
  final FnameEditingController = new TextEditingController();
  //2nd name
  final LnameEditingController = new TextEditingController();
  //Email
  final EmailEditingController = new TextEditingController();
  //pass
  final passEditingController = new TextEditingController();
  //Cpass
  final CpassEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Fname
    final FnameField = TextFormField(
      autofocus: false,
      controller: FnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (Value) {
        RegExp rgx = new RegExp(r'^.{4,}$');
        if (Value!.isEmpty) {
          return ("First name can't be empty");
        }
        if (!rgx.hasMatch(Value)) {
          return ("Enter valid name ");
        }
        return null;
      },
      onSaved: (value) {
        FnameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.people),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //Lname
    final LnameField = TextFormField(
      autofocus: false,
      controller: LnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (Value) {
        if (Value!.isEmpty) {
          return ("Last name required");
        }
        return null;
      },
      onSaved: (value) {
        LnameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.people),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //email
    final EmailnameField = TextFormField(
      autofocus: false,
      controller: EmailEditingController,
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
        EmailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // password
    final PassnameField = TextFormField(
      autofocus: false,
      obscureText: hidepass,
      controller: passEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (Value) {
        RegExp rgx = new RegExp(r'^.{10,}$');
        if (Value!.isEmpty) {
          return ("Password is Required");
        }
        if (!rgx.hasMatch(Value)) {
          return ("Use valid password \n password contains 8 latters");
        }
        return null;
      },
      onSaved: (value) {
        passEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffix: GestureDetector(
            onTap: (() => setState(() => hidepass = !hidepass)),
            child: Icon(hidepass ? Icons.visibility_off : Icons.visibility),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    //Confirm Password
    final CpassnameField = TextFormField(
      autofocus: false,
      obscureText: hidepass,
      controller: CpassEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (CpassEditingController.text != passEditingController.text) {
          return "Password didn't match";
        }
        return null;
      },
      onSaved: (value) => CpassEditingController.text = value!,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) => signUp,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffix: GestureDetector(
            onTap: (() => setState(() => hidepass = !hidepass)),
            child: Icon(hidepass ? Icons.visibility_off : Icons.visibility),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final SignupBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 14, 99, 237),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(EmailEditingController.text, passEditingController.text);
        },
        child: Text(
          "SignUp",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            //go to login section
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    FnameField,
                    SizedBox(
                      height: 15,
                    ),
                    LnameField,
                    SizedBox(
                      height: 15,
                    ),
                    EmailnameField,
                    SizedBox(
                      height: 15,
                    ),
                    PassnameField,
                    SizedBox(
                      height: 15,
                    ),
                    CpassnameField,
                    SizedBox(
                      height: 40,
                    ),
                    SignupBtn,
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((er) {
        Fluttertoast.showToast(msg: er!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //call firestore/userfunc/sending the values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;

    UserFunc userFunc = UserFunc();

    //write all the value
    userFunc.email = user!.email;
    userFunc.uid = user.uid; //get UID
    userFunc.password = passEditingController.text;
    userFunc.firstName = FnameEditingController.text;
    userFunc.lastName = LnameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userFunc.toMap());
    Fluttertoast.showToast(msg: "Successfully Created Account");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => home()), (route) => false);
  }
}
