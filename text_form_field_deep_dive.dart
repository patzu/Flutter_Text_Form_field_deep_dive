import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

main() {
  return runApp(TextFormFieldDeepDive());
}

class TextFormFieldDeepDive extends StatefulWidget {
  const TextFormFieldDeepDive({Key? key}) : super(key: key);

  @override
  _TextFormFieldDeepDiveState createState() => _TextFormFieldDeepDiveState();
}

class _TextFormFieldDeepDiveState extends State<TextFormFieldDeepDive> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var obscured = true;

  var formKey = GlobalKey<FormState>();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () => SystemNavigator.pop(),
              label: Text('Close'),
              icon: Icon(
                Icons.close,
              ),
            )
          ],
          title: Text(
            'TextFormFieldDeepDive',
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              TextFormField(
                validator: (value) => value!.isEmpty
                    ? 'Email cannot be empty!'
                    : value.isValidEmail()
                        ? null
                        : "Wrong email format!",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'test@test.com',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  suffixIcon: emailController.text.isEmpty
                      ? Container(width: 0)
                      : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => emailController.clear(),
                        ),
                ),
                controller: emailController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 24,
              ),
              buildPasswordTextField(),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid) {
                    print(emailController.text);
                    print(passwordController.text);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPasswordTextField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      obscureText: obscured,
      validator: (value) {
        if (value!.length < 7) {
          return 'Password must be at least 7 character!';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        errorText: passwordController.text.length < 5 &&
                passwordController.text.isNotEmpty
            ? 'Password must be at least 6 letter.'
            : null,
        hintText: 'Your password...',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.password),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: obscured ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          onPressed: () {
            obscured = obscured ? false : true;
            setState(() {});
          },
        ),
      ),
    );
  }
}
