import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_map/login/controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/gmapimg.png',
                height: 140,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Sign In',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 7, 21, 73),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              ' Email',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 7, 21, 73),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      size: 18,
                      color: Color.fromARGB(255, 7, 21, 73),
                    ),
                    hintText: 'Enter email',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              ' Password',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 7, 21, 73),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Obx(
              () {
                return Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: controller.password,
                      obscureText: controller.showhidepassword.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 18,
                          color: Color.fromARGB(255, 7, 21, 73),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.showHidePassword();
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                            size: 18,
                            color: Color.fromARGB(255, 7, 21, 73),
                          ),
                        ),
                        hintText: 'Enter password',
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () {
                return controller.isloading.isTrue
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          controller.performlogin();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 7, 21, 73),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50),
                          ),
                        ),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                        ),
                      );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Don't have an account ? ",
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 7, 21, 73),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed('/register');
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 7, 21, 73),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
