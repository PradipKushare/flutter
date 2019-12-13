import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flamedemo/Login/login.dart';
import 'package:dio/dio.dart';
 
// import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/services.dart';


 class RegisterView extends StatefulWidget {
   _SendSMS createState() => new _SendSMS();
 }
 class _SendSMS extends State{

      bool _validatfname = false;
      bool _validatlname = false;
      bool _validatemail = false;
      bool _validatpassword = false;
      bool _validatemobile = false;
      bool _validatebirthdate = false;

      TextEditingController _fnameController = TextEditingController();
      TextEditingController _lnameController = TextEditingController();
      TextEditingController _emailController = TextEditingController();
      TextEditingController _passwordController = TextEditingController();
      TextEditingController _mobileController = TextEditingController();
      TextEditingController _birthdateController = TextEditingController();

_goRegister(String fname, String lname, String birthdate,String email,String password,String mobile) async {

   setState(() {
  _validatfname = _fnameController.text.isEmpty ? _validatfname = true : _validatfname = false;
  _validatlname = _lnameController.text.isEmpty ? _validatlname = true : _validatlname = false;
  _validatebirthdate = _birthdateController.text.isEmpty ? _validatebirthdate = true : _validatebirthdate = false;
  _validatemail = _emailValidation(_emailController.text)  ? _validatemail = true : _validatemail = false;
  _validatpassword = _passwordController.text.isEmpty ? _validatpassword = true : _validatpassword = false;
  _validatemobile = _mobileValidation(_mobileController.text) ? _validatemobile = true : _validatemobile = false;
    });


  if (!_validatfname && !_validatlname && !_validatemail && !_validatpassword && !_validatemobile) {
   
   try {
      Dio dio = new Dio();
      Map post_data = {'firstname': fname, 
                        'lastname': lname,
                        'dob':birthdate,
                        'mobile_no':mobile,
                        'email':email,
                        'password':password};

      var response = await dio.post("http://192.168.1.110:4400/users/register", data: post_data);
      var data = json.decode(response.toString());
       if(data["success"]){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            ); 
      }else{
        print('ERORRRRRR');
      }    
    } catch (error) {
      print(error);
      }   
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

  _mobileValidation(value){
    if (value.length < 10){
        return true;
    } else{
      return false; 
    }
}

 void _goLogin(){
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );  
}

void _clearValue(){
    setState(() {
          _fnameController.text = '';
          _lnameController.text = '' ;
          _birthdateController.text = '' ;
          _emailController.text = '' ;
          _passwordController.text = '' ;
          _mobileController.text = '' ;

          _validatfname = false;
          _validatlname = false;
          _validatebirthdate = false;
          _validatemail = false;
          _validatpassword = false;
          _validatemobile = false;
       });
}

void _setValues(flag){
  switch (flag) {
    case 'fname' : {
        setState(() { _validatfname = false; });
      break;
    }
    case 'lname' : {
       setState(() { _validatlname = false; });
      break;
    }
    case 'email' : {
       setState(() { _validatemail = false; });
      break;
    }
    case 'password' : {
       setState(() { _validatpassword = false; });
      break;
    }
    case 'mobile' : {
       setState(() { _validatemobile = false; });
      break;
    }
    default:{
     return null;
    }
  }
}


Widget build(BuildContext context) {
      
    return Scaffold(
      body: SafeArea(child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 80.0),
          TextField(
            onChanged: (text) {
                _setValues('fname');
              },
            keyboardType: TextInputType.text,
            controller: _fnameController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                
                hintText: 'Enter first name',
                errorText: _validatfname ? 'enter your first name' : null,
                labelText: 'First Name',
                filled: true,
                
            ),
          ),
            SizedBox(height: 12.0),
          TextField(
            onChanged: (text) {
                _setValues('lname');
              },
            keyboardType: TextInputType.text,
            controller: _lnameController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                
                hintText: 'Enter last name',
                errorText: _validatlname ? 'Enter last name' : null,
                labelText: 'Last name',
                filled: true,
                
            ),
          ),
           SizedBox(height: 12.0),
        
          DateTimePickerFormField(
            controller: _birthdateController,
              inputType: InputType.date,
              editable: false,
               format: DateFormat("yyyy-MM-dd"),
                 initialDate: DateTime.now(),
                 firstDate: DateTime(1970),
               lastDate: DateTime.now(),
              decoration: InputDecoration(
                 fillColor: Colors.red,
                 border: InputBorder.none,
                 focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                  errorText: _validatebirthdate ? 'select your birthdate' : null,
                  labelText: 'Select birthdate', 
                  hasFloatingPlaceholder: false
              ),
            
            ),
     
    
        SizedBox(height: 12.0),
          TextField(
            onChanged: (text) {
                _setValues('email');
              },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                hintText: 'Enter E-mail Id',
                errorText: _validatemail ? 'Enter valid email address' : null,
                labelText: 'Email Address',
                filled: true,
                
            ),
          ),
            SizedBox(height: 12.0),
          TextField(
            onChanged: (text) {
                _setValues('password');
              },
            keyboardType: TextInputType.text,
            controller: _passwordController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                
                hintText: 'Enter password',
                errorText: _validatpassword ? 'Enter strong password' : null,
                labelText: 'Password',
                filled: true,
                
            ),
            obscureText: true,
          ),
            SizedBox(height: 12.0),
            
          TextField(
            onChanged: (text) {
                _setValues('mobile');
              },
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: _mobileController,
            decoration: InputDecoration(
              counterText: "",
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                 enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                
                hintText: 'Enter mobile',
                errorText: _validatemobile ? 'mobile should be 10 digit' : null,
                labelText: 'Mobile number',
                filled: true,
                
            ),
          ),
          SizedBox(height: 12.0),
          
          ButtonBar(children: <Widget>[
            FlatButton(
              child: Text('Back'),
              onPressed: (){
                  _goLogin();
              },
            ),
            FlatButton(
              child: Text('CANCEL'),
              onPressed: (){
                  _clearValue();
              },
            ),
            RaisedButton(
              child: Text('REGISTER'),
              textColor: Colors.blueAccent,
               padding: const EdgeInsets.all(0.0),
               
              onPressed: (){
               _goRegister( _fnameController.text,
                            _lnameController.text,
                            _birthdateController.text,
                            _emailController.text,
                            _passwordController.text,
                            _mobileController.text);
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
