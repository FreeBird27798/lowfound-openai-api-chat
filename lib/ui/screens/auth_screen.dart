import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';
import 'package:lowfound_openai_api_chat/model/user.dart';
import 'package:lowfound_openai_api_chat/providers/users_provider.dart';
import 'package:lowfound_openai_api_chat/storage/preferences/app_pref_controller.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/app_elevated_button.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/app_text_field.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/app_text.dart';
import 'package:lowfound_openai_api_chat/utils/helpers.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with Helpers {
  bool _loginButtonEnabled = false;
  bool _signUpButtonEnabled = false;

  late TextEditingController _loginUserNameTextEditingController;
  late TextEditingController _loginPasswordTextEditingController;
  late TextEditingController _signupUserNameTextEditingController;
  late TextEditingController _signupPasswordTextEditingController;
  late UsersProvider _usersProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginUserNameTextEditingController = TextEditingController();
    _loginPasswordTextEditingController = TextEditingController();
    _signupUserNameTextEditingController = TextEditingController();
    _signupPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginUserNameTextEditingController.dispose();
    _loginPasswordTextEditingController.dispose();
    _signupUserNameTextEditingController.dispose();
    _signupPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _usersProvider = UsersProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        toolbarHeight: 80,
        elevation: 2,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: AppText(
            label: "LowFound OpenAI API Chat",
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 12),
            alignment: AlignmentDirectional.center,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: greyColor,
                          spreadRadius: 0,
                          blurRadius: 18,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/wallpaper.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.21),
                      )
                    ],
                  ),
                  child: AppTextField(
                    enablePadding: true,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                    textEditingController: _loginUserNameTextEditingController,
                    onChanged: (value) => validateLoginForm(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.21),
                      )
                    ],
                  ),
                  child: AppTextField(
                    enablePadding: true,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: _loginPasswordTextEditingController,
                    onChanged: (value) => validateLoginForm(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                AppElevatedButton(
                  enabled: _loginButtonEnabled,
                  text: 'Login',
                  onPressed: () => performLogin(),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'or sign up if you don’t have an account yet',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 24,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.21),
                      )
                    ],
                  ),
                  child: AppTextField(
                    enablePadding: true,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                    textEditingController: _signupUserNameTextEditingController,
                    onChanged: (value) => validateSignUpForm(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.21),
                      )
                    ],
                  ),
                  child: AppTextField(
                    enablePadding: true,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textEditingController: _signupPasswordTextEditingController,
                    onChanged: (value) => validateSignUpForm(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                AppElevatedButton(
                  enabled: _signUpButtonEnabled,
                  text: 'Sign Up',
                  onPressed: () => performCreateAccount(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Login
  bool checkLoginData() {
    return _loginUserNameTextEditingController.text.isNotEmpty &&
        _loginPasswordTextEditingController.text.isNotEmpty;
  }

  void validateLoginForm() {
    updateLoginEnableStatus(checkLoginData());
  }

  void updateLoginEnableStatus(bool status) {
    setState(() {
      _loginButtonEnabled = status;
      _signupUserNameTextEditingController.clear();
      _signupPasswordTextEditingController.clear();
    });
  }

  Future<void> performLogin() async {
    if (checkLoginData()) {
      await login();
    }
  }

  Future<void> login() async {
    bool status = await _usersProvider.login(
        username: _loginUserNameTextEditingController.text,
        password: _loginPasswordTextEditingController.text);
    if (status) {
      Navigator.pushReplacementNamed(context, '/chat_screen');
      showSnackBar(context, message: 'Logged In Successfully');
    } else {
      showSnackBar(context,
          message: 'Login failed, check your credentials!', error: true);
    }
  }

  //Sign Up
  bool checkSignUpData() {
    return _signupUserNameTextEditingController.text.isNotEmpty &&
        _signupPasswordTextEditingController.text.isNotEmpty;
  }

  void validateSignUpForm() {
    updateSignUpEnableStatus(checkSignUpData());
  }

  void updateSignUpEnableStatus(bool status) {
    setState(() {
      _signUpButtonEnabled = status;
      _loginUserNameTextEditingController.clear();
      _loginPasswordTextEditingController.clear();
    });
  }

  Future<void> performCreateAccount() async {
    if (checkSignUpData()) {
      await createAccount();
    }
  }

  Future<void> createAccount() async {
    bool status = await _usersProvider.createAccount(user: user);
    if (status) {
      Navigator.pushReplacementNamed(context, '/chat_screen');
      showSnackBar(context, message: 'Account Created Successfully ${user.id}');
    } else {
      showSnackBar(context,
          message: 'Something went wrong, Please check the requirements!',
          error: true);
    }
  }

  User get user {
    User user = User();
    user.id = AppPrefController().user.id;
    user.username = _signupUserNameTextEditingController.text;
    user.password = _signupPasswordTextEditingController.text;
    return user;
  }
}
