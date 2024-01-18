import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/widget/input/button.dart';
import 'package:showd_delivery/widget/input/email.dart';
import 'package:showd_delivery/widget/input/password.dart';
import 'package:showd_delivery/widget/input/username.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordCheckFocusNode = FocusNode();

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
                          "สมัครสมาชิก",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "ChoDelivery แอพสั่งซื้อสินค้าจากร้านโชห่วยใกล้บ้านคุณ สะดวกสบาย เพียงแค่ไม่กี่คลิ๊ก สมัครสมาชิกกับเรา แล้วไปเริ่มต้นชีวิตสะดวกสบายได้เลย",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildDivider("สมัครสมาชิกด้วยอีเมล์"),
                        const SizedBox(height: 16),
                        UsernameInput(controller: usernameController, focusNode: usernameFocusNode, nextFocusNode: emailFocusNode),
                        const SizedBox(height: 16),
                        EmailInput(controller: emailController, focusNode: emailFocusNode, nextFocusNode: passwordFocusNode),
                        const SizedBox(height: 16),
                        PasswordInput(controller: passwordController, checkController: passwordCheckController, focusNode: passwordFocusNode, nextFocusNode: passwordCheckFocusNode),
                        const SizedBox(height: 16),
                        PasswordInput(controller: passwordCheckController, checkController: passwordController, action: TextInputAction.done, focusNode: passwordCheckFocusNode),
                        const SizedBox(height: 16),
                        buildButton(),
                        buildHaveAccount(),
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
        text: 'สมัครสมาชิก',
        onClicked: register,
      );

  void register() {
    final form = formKey.currentState!;
    if (form.validate()) {
      TextInput.finishAutofillContext();
      final username = usernameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      Auth.initRegisterEmail(email, password, username);
    }
  }

  Widget buildHaveAccount() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('มีบัญชีอยู่แล้ว ? '),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
              ),
            ),
          ],
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
