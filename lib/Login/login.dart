import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'package:flamedemo/drawerList.dart';

 class LoginView extends StatefulWidget {
   _SendSMS createState() => new _SendSMS();
 }
 class _SendSMS extends State{

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _validateemail = false;
  bool _validatepassword = false;

  void _goLogin(){
    setState(() {
          _validateemail =  _emailValidation(_usernameController.text)  ? _validateemail = true : _validateemail = false; 
          _validatepassword = _passwordController.text.isEmpty ? _validatepassword = true : _validatepassword = false;
    });

    if (!_validateemail && !_validatepassword) {
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DrawerPage()),
      );    
    } 
}

  _emailValidation(value){
    bool  pattern  = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
      if (!pattern){
        return true;
    } else{
      return false; 
    }
}

void _clearValue(){
    setState(() { _usernameController.text = '';  _passwordController.text = '' ;
                  _validateemail= false; _validatepassword = false;});
}

void _setValues(flag){
  if (flag == 'email') {
    setState(() { _validateemail = false;});
  }else{
    setState(() { _validatepassword = false;});
  }
}

Widget build(BuildContext context) {
      
    return Scaffold(
      body: SafeArea(child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 80.0),
          Column(children: <Widget>[
           Image.asset('assets/images/logo.png'),
            SizedBox(height: 15.0),
          ],),
          SizedBox(height: 80.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _usernameController,
              onChanged: (text) {
                _setValues('email');
              },
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                ),
                
                hintText: 'Enter E-mail Id',
                errorText: _validateemail ? 'Enter valid email address' : null,
                labelText: 'Email Address',
                filled: true,
                
            ),
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            onChanged: (text) {
                _setValues('password');
              },
            decoration: InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            ),
            hintText: 'Enter password',
            errorText: _validatepassword ? 'Enter strong password' : null,
            labelText: 'Password',
            filled: true,
          ),
           obscureText: true,
          ),
         Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.pink),
          ButtonBar(children: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: (){
                  _clearValue();
              },
            ),
            RaisedButton(
              child: Text('NEXT'),
              textColor: Colors.blueAccent,
               padding: const EdgeInsets.all(0.0), 
              onPressed: (){
                   _goLogin();
              },
            )
          ],
          )
        ],
      )
     ),
    );
  }
}