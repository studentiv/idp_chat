import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SignButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) => Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.lightBlueAccent, Colors.indigo],
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      );
}

class Logo extends StatelessWidget {
  const Logo();

  @override
  Widget build(BuildContext context) => Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue.shade700, Colors.indigo],
          ),
        ),
        child: Center(
          child: Icon(Icons.chat_bubble, size: 40, color: Colors.white),
        ),
      );
}

class DefaultTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChange;

  const DefaultTextField(this.onChange, this.hintText);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: TextFormField(
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
}

class PasswordField extends StatefulWidget {
  final Function(String) onChange;

  const PasswordField(this.onChange);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: TextFormField(
          onChanged: widget.onChange,
          obscureText: _obscureText,
          decoration: InputDecoration(
              suffixIcon: IconTheme(
                data: IconThemeData(color: Colors.grey),
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                  icon: Icon(Icons.remove_red_eye),
                ),
              ),
              suffixIconColor: Colors.grey,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey)),
        ),
      );
}

class FacebookLabel extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const FacebookLabel(this.text, this.onTap);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.indigoAccent,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: Colors.indigo,
                  child: Center(
                    child: SvgPicture.asset(
                      'images/facebook.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class GoogleLabel extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GoogleLabel(this.text, this.onTap);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Center(
                  child: SvgPicture.asset('images/google.svg', width: 30),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
