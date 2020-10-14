import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/google_text_button.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:Notey/shared/widgets/sign_in_email_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Header(
                  title: 'Welcome',
                  subtitle: 'Take notes and sync them across all your devices.',
                ),
                SizedBox(height:40),
                SvgPicture.asset('assets/welcome_illustration.svg',height: size.height*0.4,),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GoogleTextButton(),
                      SizedBox(height:20),
                      SignInEmailButton(),
                      SizedBox(height:30),
                      Footer(
                        text: 'Not a member?',
                        actionText: 'Sign up',
                        onPressed: ()=> print('Sign up'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}