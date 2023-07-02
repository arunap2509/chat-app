
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String placeholder;
  final bool isPassword;
  final TextEditingController controller;
  const InputField({
    super.key,
    required this.placeholder,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool showPassword = false;
  toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        obscureText: !widget.isPassword
            ? false
            : showPassword
                ? false
                : true,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: TextStyle(
            color: Colors.green.shade300,
          ),
          labelText: widget.placeholder,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: toggleShowPassword,
                  child: showPassword
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.black54,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black54,
                        ),
                )
              : null,
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
