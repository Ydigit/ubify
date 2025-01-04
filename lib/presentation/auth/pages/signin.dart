import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/data/models/auth/signin_user_req.dart';
import 'package:ubify/domain/usecases/auth/signin.dart';
import 'package:ubify/presentation/auth/pages/signup.dart';
import 'package:ubify/presentation/root/pages/root.dart';
import 'package:ubify/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this way keyboard doenst oversize
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _signupText(context),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signInText(),
            _signInInputFieldsSpace(),
            // _userNameOrEmailFielf(context),
            _emailField(context),
            _inputFieldsSpace(),
            _passwordField(context),
            _signInInputFieldsSpace(),
            BasicAppButton(
                onPressed: () async {
                  //async bcs I need to wait until conclude the call method
                  //Program does not continue until I have the return
                  //Result is Either, so we define next nav based on this
                  //returns the either l or r
                  var result = await sl<SigninUseCase>().call(
                    //create instance userReq
                    params: SigninUserReq(
                      //.text access to text component not the string repr of the obj
                      //toString here is redundant
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                    ),
                  );
                  result.fold(
                    //left FAIL display message
                    (l) {
                      //carregar content
                      var snackbar = SnackBar(
                        content: Text(l),
                        behavior: SnackBarBehavior.floating,
                      );
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
                title: "Sign In"),
          ],
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      "Sign In",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  //BUILDCONTEXT context lets us get access to the current theme and widget tree
  Widget _userNameOrEmailFielf(BuildContext context) {
    //TO ACCESS THE CURRENT THEME
    //as it is alredy defined I dont need to define anythin
    //and theme is alredy choosed
    return TextField(
      // controller: _email,
      decoration: const InputDecoration(hintText: "Enter Username or Email")
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

  Widget _signInInputFieldsSpace() {
    return const SizedBox(
      height: 50,
    );
  }

  Widget _inputFieldsSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Not a Member?",
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
                    builder: (BuildContext context) => SignupPage(),
                  ));
            },
            child: const Text(
              "Register Now!",
            ),
          )
        ],
      ),
    );
  }
}
