import 'package:flutter/material.dart';
import 'package:login_study/join.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Center(
            child: SizedBox(
          width: screenWidth * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "로그인",
                style: TextStyle(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      fixedSize: Size.fromWidth(screenWidth),
                      textStyle: TextStyle(
                        fontSize: 20,
                      )),
                  child: Text('로그인'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JoinPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      fixedSize: Size.fromWidth(screenWidth),
                      textStyle: TextStyle(
                        fontSize: 20,
                      )),
                  child: Text('회원가입'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
