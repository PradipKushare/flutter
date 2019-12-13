import 'package:flamedemo/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flamedemo/components/app_button.dart';
import 'package:flamedemo/components/custom_text_field.dart';
import 'package:flamedemo/components/login_component.dart';
import 'package:flamedemo/components/logo_widget.dart';
import 'package:flamedemo/utils/colors.dart';
import 'package:flamedemo/utils/screen_util.dart';
import 'package:flamedemo/utils/strings.dart';
import 'package:flamedemo/utils/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:flamedemo/Loader/apploader.dart';
import '../constants.dart';

class RegisterView extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalObjectKey<ScaffoldState>('Register');
  GlobalKey<ScaffoldState> riKey1 = new GlobalObjectKey<ScaffoldState>('');

      TextEditingController _nameController = TextEditingController();
      TextEditingController _emailController = TextEditingController();
      TextEditingController _passwordController = TextEditingController();
      TextEditingController _mobileController = TextEditingController();
  final LocalStorage storage = new LocalStorage('dob_data');

  final _loginFormKey = GlobalKey<FormState>();
  String myDob;

  FocusNode _emailFocusNode;
  FocusNode _nameFocusNode;
  FocusNode _mobileFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
    _nameFocusNode = new FocusNode();
    _mobileFocusNode = new FocusNode();

  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  setScreenSize(BuildContext context)async {
    if (_loginFormKey.currentState.validate()) {
       try {
    Dialogs.showLoadingDialog(context, riKey1);//invoking login
      var getdob = storage.getItem('dob');
        Dio dio = new Dio();
        Map postdata = {'firstname': _nameController.text, 
                        'dob':getdob,
                        'mobile_no':_mobileController.text,
                        'email':_emailController.text,
                        'password':_passwordController.text};

      var response = await dio.post(Constants.ApiURL+'register', data: postdata);
      var data = json.decode(response.toString());
       if(data["success"]){
        Navigator.of(riKey1.currentContext,rootNavigator: true).pop();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            ); 
      }else{
        Navigator.of(riKey1.currentContext,rootNavigator: true).pop();
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
                     padding: Constant.spacingAllSmall,
                    ),
                  ),
                 
                  Padding(
                    
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),
                    child: AppTextFormField(
                      focusNode: _nameFocusNode,
                      hintText: AppLabels.username,
                      validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,  
                      icon: Icons.supervised_user_circle,

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
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: _emailController,
                      icon: Icons.lock,

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
                    child: new GetDate(),
                  ),
                   Container(
                    height: Constant.sizeLarge,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constant.screenWidthTenth,
                    ),
                    child: AppTextFormField(
                      maxLength: 10,
                      focusNode: _mobileFocusNode,
                      hintText: AppLabels.mobile,
                      validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter 10 dogit mobile no';
                          }
                          return null;
                        },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: _mobileController,
                      icon: Icons.mobile_screen_share,

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
                      text: AppLabels.Register,
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

class GetDate extends StatefulWidget{
    HomePage createState()=> HomePage();
}

class HomePage extends State<GetDate>{

  final LocalStorage storage = new LocalStorage('dob_data');

      TextEditingController _birthdateController = TextEditingController();

Future showDialog(context) async {

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2017),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019),
    );
String formattedDate = DateFormat('dd/MM/yyyy').format(picked);

    if(picked != null) setState(() => _birthdateController.text = formattedDate);
    storage.setItem('dob', formattedDate);
}



  
  @override
  Widget build(BuildContext context) {
 return  Container(
            decoration: BoxDecoration(
           border: Border.all(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(Constant.sizeSmall))),
        child :InkWell(
        onTap: () {
          showDialog(context);   // Call Function that has showDatePicker()
        },
            child: IgnorePointer(
            child: new TextFormField(
            controller: _birthdateController,
            decoration: InputDecoration(
            hasFloatingPlaceholder: false,
            icon: Icon(Icons.calendar_today,
            size: Constant.texIconSize,
          ),
          hintText: 'Select Birthdate',
          errorMaxLines: 1,
          errorStyle: TextStyles.errorStyle,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
            maxLength: 10,
          ),
        ),
      ),
    );
  }
}
