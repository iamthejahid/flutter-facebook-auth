import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_auth_test/local_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FaceBook Auth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  bool _isShow = false;
  @override
  void initState() {
    super.initState();
    _logCheck();
  }

  void _logCheck() async {
    await GetUserLocalStorage()
        .isLogin()
        .then((value) => setState(() => _isShow = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 10,
              color: _isShow ? Colors.red : Colors.green,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                FacebookAuth.instance.login(
                    permissions: ["public_profile", "email"]).then((value) {
                  print(value.status);
                  FacebookAuth.instance.getUserData().then((userData) {
                    print(userData);
                    setState(() {
                      _isLoggedIn = true;
                      _userObj = userData;
                    });
                  });
                });
              },
              child: Text("Log In"),
            ),
            if (_isLoggedIn)
              Column(
                children: [
                  Image.network(_userObj['picture']['data']['url']),
                  Text(_userObj['name']),
                  // Text(_userObj['email']),
                  Text("s")
                ],
              ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                await FacebookAuth.instance.logOut().then((value) {
                  print("pew pew");
                });
                setState(() {
                  _isLoggedIn = false;
                });
              },
              child: Text("Log out"),
            ),
            FloatingActionButton(
              onPressed: () {
                SetUserLocalStorage().isLogin(false);
              },
              tooltip: 'Increment',
              child: Icon(Icons.facebook_outlined),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SetUserLocalStorage().isLogin(true);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
