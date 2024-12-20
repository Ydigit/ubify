import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/app_theme.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/domain/usecases/auth/signup.dart';
import 'package:ubify/presentation/auth/pages/signin.dart';
import 'package:ubify/presentation/root/pages/root.dart';
import 'package:ubify/service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  //controllers for textfield spaces
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      //logo in appbar
      //we will pass one widget to BasicAppBar
      appBar: BasicAppBar(
        //removes cosnt from scaffold bcs tittle depends on external assets
        //so we remove it to construct in real time compilation
        title: SvgPicture.asset(
          AppVectors.blackSpotifyLogo,
          width: 70,
          height: 70,
        ),
      ),
      //dist from the appbar
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            _registerInputFieldsSpace(),
            _fullNameField(context),
            _InputFieldsSpace(),
            _emailField(context),
            _InputFieldsSpace(),
            _passwordField(context),
            _InputFieldsSpace(),
            BasicAppButton(
                onPressed: () async {
                  //async bcs I need to wait until conclude the call method
                  //Program does not continue until I have the return
                  //Result is Either, so we define next nav based on this
                  //returns the either l or r
                  var result = await sl<SignupUseCase>().call(
                    //create instance userReq
                    params: CreateUserReq(
                      //.text access to text component not the string repr of the obj
                      //toString here is redundant
                      fullName: _fullName.text.toString(),
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                    ),
                  );
                  result.fold(
                    //left FAIL display message
                    (l) {
                      //carregar content
                      var snackbar = SnackBar(content: Text(l));
                      //render the snackbarrelated with scafflold and context
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    //right we got SUCCESS
                    //nav
                    (r) {
                      //remove until for no back arrow usage
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const RootPage(),
                          ),
                          //all routes are erased
                          (route) => false);
                    },
                  );
                },
                title: "Create Acounte"),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  //BUILDCONTEXT context lets us get access to the current theme and widget tree
  Widget _fullNameField(BuildContext context) {
    //TO ACCESS THE CURRENT THEME
    //as it is alredy defined I dont need to define anythin
    //and theme is alredy choosed
    return TextField(
      //controllers access to the textfield states
      controller: _fullName,
      decoration: const InputDecoration(hintText: "Full Name")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
    //APLLY defaults it for
    //use the propertyes from the context's theme on  context.inputDecorationTheme
    //like color edges border for the dark and light theme
    //if not defined we will define this input Decorations
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Enter Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: "Enter Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerInputFieldsSpace() {
    return const SizedBox(
      height: 50,
    );
  }

  Widget _InputFieldsSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Do you alredy have an account?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const SigninPage()));
            },
            child: const Text(
              "Sign in",
            ),
          )
        ],
      ),
    );
  }
}
