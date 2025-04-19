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
import 'package:task_out/features/auth/presentation/widgets/login_image.dart';
import 'package:task_out/features/auth/presentation/widgets/back_button_icon.dart';
import 'package:task_out/routes/routes.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final emailValidation = InputValidator.validateEmail(email);
    final passwordValidation = InputValidator.validatePassword(password);

    setState(() {
      _emailError = emailValidation;
      _passwordError = passwordValidation;
    });

    if (emailValidation == null && passwordValidation == null) {
      await ref.read(authStateProvider.notifier).signIn(email, password);
      _passwordController.clear();
      _emailController.clear();
    }
  }

  void _resetPassword() async {
    final email = _emailController.text.trim();

    final emailValidation = InputValidator.validateEmail(email);

    setState(() {
      _emailError = emailValidation;
    });

    if (emailValidation == null) {
      await ref.read(authStateProvider.notifier).resetPassword(email);
      _emailController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset link sent to $email')),
        );
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

                const LoginImage(),

                Padding(
                  padding: EdgeInsets.only(right: AppSizes.paddingXl * 4),
                  child: WelcomeTextSection(
                    onSignUpTap:
                        () => context.pushReplacement(AppRoutes.register),
                  ),
                ),

                20.h,

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
                  onTap: isLoading ? null : _login,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusSm / 2,
                  ),
                  backgroundColor: AppColors.mainColor,
                  width: AppSizes.blockWidth * 93,
                  padding: EdgeInsets.all(AppSizes.paddingSm * 1.2),
                  child: Center(
                    child: CustomText(
                      isLoading ? 'Logging in...' : 'Login',
                      color: Colors.white,
                      fontSize: AppSizes.textMd,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                30.h,
                GestureDetector(
                  onTap: isLoading ? null : _resetPassword,
                  child: CustomText(
                    'Forgot Password',
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w700,
                    underline: true,
                  ),
                ),
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
