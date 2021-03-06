import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/login/login_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class LoginScreen extends ResponsiveWidget<LoginScreenController> {
  @override
  String get tag => 'login_controller';

  @override
  init() {
    Get.put(LoginScreenController(), tag: tag);
  }

  @override
  Widget phone() {
    final context = screen.context;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Heading3(
                title: "Login \nInto Your Account",
                color: Palette.black,
                lineHeight: 1.4,
              ),
              const SizedBox(
                height: 36.0,
              ),
              const SizedBox(
                height: 32.0,
              ),
              Container(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ParagraphMedium(
                        title: "Email Address",
                        color: Palette.black3,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        enabled: true,
                        controller: controller.inputController,
                        cursorColor: Palette.black,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          color: Palette.gray2,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 20.0,
                          ),
                          fillColor: Palette.gray7,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.gray2,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Palette.secondary_red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.email = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ParagraphMedium(
                        title: "Password",
                        color: Palette.black3,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Obx(
                        () => TextFormField(
                          enabled: !controller.isSigningIn.value,
                          controller: controller.passwordController,
                          cursorColor: Palette.black,
                          obscureText: controller.obscurePassword.value,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            color: Palette.gray2,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 20.0,
                            ),
                            fillColor: Palette.gray6,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.gray2,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Palette.secondary_red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            suffixIcon: IconButton(
                              icon: controller.obscurePassword.value
                                  ? SvgPicture.asset(
                                      Assets.eye,
                                      color: Palette.gray4,
                                      semanticsLabel: 'Eye On',
                                      width: 20.0,
                                      height: 20.0,
                                    )
                                  : SvgPicture.asset(
                                      Assets.eyeOff,
                                      color: Palette.black2,
                                      semanticsLabel: 'Eye Off',
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                              onPressed: () => controller.obscurePassword.toggle(),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            controller.password = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => CustomButton(
                                title: 'Sign In',
                                color: Palette.black,
                                textColor: Colors.white,
                                height: 60.0,
                                minWidth: 164.0,
                                isLoading: controller.isSigningIn.value,
                                onTap: controller.isSigningIn.value == true
                                    ? () {}
                                    : () async {
                                        FocusScope.of(context).unfocus();

                                        if (controller.formKey.currentState.validate()) {
                                          print(controller.inputController.text);

                                          await controller.signIn();
                                        }
                                      },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      Row(
                        children: [
                          ParagraphMedium(
                            title: "Dont have an account ? ",
                            color: Palette.black3,
                          ),
                          GestureDetector(
                            onTap: () => Get.offAndToNamed("/register"),
                            child: ParagraphMedium(
                              title: "Register",
                              color: Palette.primary,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
