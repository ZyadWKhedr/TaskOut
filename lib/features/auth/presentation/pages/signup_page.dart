import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/extensions/spacing_extension.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/utils/input_validator.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';
import 'package:task_out/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_out/features/auth/presentation/widgets/animated_button.dart';
import 'package:task_out/features/auth/presentation/widgets/text_input_field.dart';
import 'package:task_out/features/auth/presentation/widgets/welcome_text_section.dart';
import 'package:task_out/features/auth/presentation/widgets/back_button_icon.dart';
import 'package:task_out/routes/routes.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignupPage> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  void _signup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final nameValidation = InputValidator.validateName(name);
    final emailValidation = InputValidator.validateEmail(email);
    final passwordValidation = InputValidator.validatePassword(password);

    setState(() {
      _nameError = nameValidation;
      _emailError = emailValidation;
      _passwordError = passwordValidation;
    });

    if (nameValidation == null &&
        emailValidation == null &&
        passwordValidation == null) {
      try {
        await ref
            .read(authStateProvider.notifier)
            .signUp(name, email, password);

        _passwordController.clear();
        _emailController.clear();
        _nameController.clear();

        if (mounted) context.pushReplacement(AppRoutes.login);
      } catch (e, st) {
        log('SIGN UP ERROR: $e');
        log('STACKTRACE: $st');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign up failed: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authStateProvider).isLoading;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(AppSizes.paddingXl * 2)),

                Padding(
                  padding: EdgeInsets.only(right: AppSizes.paddingXl * 2.5),
                  child: WelcomeTextSection(
                    onActionTap: () => context.pushReplacement(AppRoutes.login),
                    title: 'Create an account',
                    message: 'Enter your account details below or ',
                    actionText: 'log in',
                  ),
                ),

                20.h,

                _buildInputField(
                  controller: _nameController,
                  hintText: 'Username',
                  errorText: _nameError,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onChanged: () => setState(() => _nameError = null),
                ),

                _buildInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: () => setState(() => _emailError = null),
                ),

                _buildInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  errorText: _passwordError,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onChanged: () => setState(() => _passwordError = null),
                ),

                18.h,

                AnimatedButton(
                  onTap: isLoading ? null : _signup,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusSm / 2,
                  ),
                  backgroundColor: AppColors.mainColor,
                  width: AppSizes.blockWidth * 93,
                  padding: EdgeInsets.all(AppSizes.paddingSm * 1.2),
                  child: Center(
                    child: CustomText(
                      isLoading ? 'Signing Up...' : 'Sign Up',
                      color: Colors.white,
                      fontSize: AppSizes.textMd,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                30.h,
              ],
            ),
          ),

          Positioned(
            top: AppSizes.blockHeight * 5,
            left: AppSizes.blockWidth * 5,
            child: const CustomBackButtonIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool isPassword = false,
    required VoidCallback onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingMd / 1.5),
      child: TextInputField(
        hintText: hintText,
        controller: controller,
        errorText: errorText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        isPasswordField: isPassword,
        onChanged: (_) => onChanged(),
      ),
    );
  }
}
