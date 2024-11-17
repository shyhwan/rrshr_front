import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login_study/main.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: JoinForm(),
    ));
  }
}

class JoinForm extends StatefulWidget {
  const JoinForm({super.key});

  @override
  State<JoinForm> createState() {
    // TODO: implement createState
    return JoinFormState();
  }
}

class JoinFormState extends State<JoinForm> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();
  final TextEditingController confirmPswdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final logger = Logger();
  Future<void> submitData() async {
    final id = idController.text;
    final pswd = pswdController.text;
    final confirmPswd = confirmPswdController.text;
    final phone = phoneController.text;

    if (pswd != confirmPswd) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }

    final url = Uri.parse('http://192.168.132.1:8081/joinUser');
    try {
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': id,
          'password': pswd,
          'phone': phone,
        }),
      );
      print(res.statusCode);

      logger.d('/** Response Status **************************/');
      logger.d(res.statusCode);
      logger.d('/*********************************************/');

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입 되었습니다.')),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입에 문제가 발생하였습니다.')),
        );
      }
    } catch (ex) {
      print(ex);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러 발생: $ex')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '회원가입',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          TextField(
            controller: idController,
            decoration: InputDecoration(
                label: Text('아이디'),
                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
          ),
          TextField(
            controller: pswdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호',
            ),
          ),
          TextField(
            controller: confirmPswdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호 확인',
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: '핸드폰번호',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: screenWidth,
            child: ElevatedButton(
              onPressed: submitData,
              child: Text('제출'),
            ),
          ),
        ],
      ),
    );
  }
}
