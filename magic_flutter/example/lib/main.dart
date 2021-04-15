import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_flutter/magic_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Magic SDK Sample",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: InitializeApp(),
    );
  }
}

class InitializeApp extends StatelessWidget {
  // TODO: Replace with your publisher key
  final publisherKey = "pk_live_F6875E92A3144E89";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magic plugin sample"),
      ),
      body: FutureBuilder(
        future: Magic.initializeMagic(publisherKey: publisherKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // if (snapshot.hasData) {
              return LoginPage();
            // }
            return Container(
              alignment: Alignment.center,
              child: Text("Something went wrong. Failed to initialize Magic"),
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller:   TextEditingController.fromValue(
                TextEditingValue(
                  text: "jerry@magic.link"
                )
              ),
              decoration: InputDecoration(
                hintText: "Enter your email id",
              ),
              validator: (value) {
                if (!value!.isValidEmail) return "Enter a valid email";
                return null;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("LogIn"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await Magic.loginWithMagicLink(email: emailController.text);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((e as PlatformException).message!),
          ),
        );
      }
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: FutureBuilder<GetMetaDataResponse>(
        future: Magic.getMetaData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Container(
                alignment: Alignment.center,
                child: Text('Something went wrong while fetching data'),
              );

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text('Email address'),
                    subtitle: Text(snapshot.data!.email),
                  ),
                  ListTile(
                    title: Text('Public address'),
                    subtitle: Text(snapshot.data!.publicAddress),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

extension EmailValidator on String {
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}
