import 'package:flamedemo/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flamedemo/components/app_button.dart';
import 'package:flamedemo/components/custom_text_field.dart';
import 'package:flamedemo/components/login_component.dart';
import 'package:flamedemo/components/logo_widget.dart';
import 'package:flamedemo/utils/colors.dart';
import 'package:flamedemo/utils/screen_util.dart';
import 'package:flamedemo/utils/strings.dart';
import 'package:flamedemo/utils/text_styles.dart';
import 'package:flamedemo/drawerList.dart';
import 'package:flamedemo/Register/tmp_register.dart';
import 'package:flamedemo/Loader/apploader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';


final storage = new FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('LoginScreen');
  GlobalKey<ScaffoldState> _loginKey = new GlobalObjectKey<ScaffoldState>('');


    TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  

  bool _screenUtilActive = true;

  final _loginFormKey = GlobalKey<FormState>();

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  setScreenSize(BuildContext context)async {
    if (_loginFormKey.currentState.validate()) {
       try {
    Dialogs.showLoadingDialog(context, _loginKey);//invoking login
        Dio dio = new Dio();
        Map postdata = {'username': _usernameController.text, 
                        'password':_passwordController.text};

      var response = await dio.post(Constants.ApiURL+'login', data: postdata);
      var data = json.decode(response.toString());
       if(data["success"]){
        Navigator.of(_loginKey.currentContext,rootNavigator: true).pop();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrawerPage()),
            ); 
      }else{
        Navigator.of(_loginKey.currentContext,rootNavigator: true).pop();
        var dispmsg = data["msg"];
                Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(dispmsg,textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0),),
                      duration: Duration(seconds:3),
                       backgroundColor: Colors.redAccent
              ));
         }    
       } catch (error) {
          print(error);
      } 
     } 
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Builder(
           builder: (context) => 
            Form(
          key: _loginFormKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BackgroundImageWidget(
                color: AppColors.primary,
              ),
              ListView(
                children: <Widget>[
                  Center(
                    child: AppLogoWidget(
                      margin: EdgeInsets.only(top: Constant.sizeXXXL),
                      padding: Constant.spacingAllSmall,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Constant.screenWidthTenth),
                    child: Text(
                      AppStrings.appName,
                      style: TextStyles.appName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: Constant.sizeMedium,
                  ),
                
                  Container(
                    height: Constant.sizeMedium,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),
                    child: AppTextFormField(
                      focusNode: _emailFocusNode,
                      hintText: AppLabels.email,
                      
                      validator: (value) {
                          var pattern  = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                            if (!pattern){
                            return AppStrings.enterValidEmail;
                          } else{
                            return null;
                          }
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: _usernameController,  
                      icon: Icons.email,

                    ),
                  ),
                  Container(
                    height: Constant.sizeLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),
                    child: AppTextFormField(
                      focusNode: _passwordFocusNode,
                      hintText: AppLabels.password,
                      validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid password';
                          }
                          return null;
                        },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      icon: Icons.lock,
                      obscureText: true,

                    ),
                  ),
                  Container(
                    height: Constant.sizeLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),
                    child: AppButton(
                      onTap: () => setScreenSize(context),
                      text: AppLabels.Login,
                    ),
                  ),
                  Container(
                    height: Constant.sizeLarge,
                  ),
          

                   new InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterView()),
                          ); 
                        },
                        child: new Padding(
                          
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),

                    child: Text(
                      'New customer? Register here',
                        style: TextStyle(color: Colors.lightBlue,fontSize: 12.0),
                         textAlign: TextAlign.center,
                          ),
                        ),
                          
                      ),

                  
               
                ],
              ),
            ],
          ),
        ),
      ),
     ),
    );
  }
}
