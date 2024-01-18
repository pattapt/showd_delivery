import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/widget/input/button.dart';
import 'package:showd_delivery/widget/input/email.dart';
import 'package:showd_delivery/widget/input/password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SingleChildScrollView(
          child: Center(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Lottie.asset(
                          "assets/animation/a-0001.json",
                          width: 290,
                          fit: BoxFit.fill,
                        ),
                        const Text(
                          "เข้าสู่ระบบ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "ChoDelivery แอพสั่งซื้อสินค้าจากร้านโชห่วยใกล้บ้านคุณ สะดวกสบาย เพียงแค่ไม่กี่คลิ๊ก",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildDivider("เข้าสู่ระบบด้วยอีเมล์"),
                        const SizedBox(height: 16),
                        EmailInput(controller: emailController, focusNode: emailFocusNode, nextFocusNode: passwordFocusNode),
                        const SizedBox(height: 16),
                        PasswordInput(controller: passwordController, focusNode: passwordFocusNode, action: TextInputAction.done),
                        const SizedBox(height: 16),
                        buildButton(),
                        buildNoAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() => ButtonCSGAME(
        text: 'เข้าสู่ระบบ',
        onClicked: login,
      );

  void login() async {
    final form = formKey.currentState!;
    if (form.validate()) {
      TextInput.finishAutofillContext();
      final email = emailController.text;
      final password = passwordController.text;
      await Auth.initLoginEmail(email, password);
    }
  }

  Widget buildNoAccount() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ยังไม่มีบัญชีใช้หรือไม่ ? '),
            GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushNamed('/register', arguments: false);
              },
              child: const Text(
                'สมัครสมาชิกเลย',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      );

  Widget buildForgotPassword() => Container(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed('/forgot-password');
            },
            child: const Text(
              'ลืมรหัสผ่าน',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      );

  Widget buildDivider(String text) => Row(
        children: [
          const Expanded(child: Divider()),
          const SizedBox(width: 10),
          Text(text, style: GoogleFonts.prompt(fontWeight: FontWeight.w300)),
          const SizedBox(width: 10),
          const Expanded(child: Divider()),
        ],
      );
}
