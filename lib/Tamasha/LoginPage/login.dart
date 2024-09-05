import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamasha_bp/Tamasha/LoginPage/help.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const SizedBox(),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return HelpDialog();
                  },
                );
              },
              child: const Text("Help",
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
          title: const Center(
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.text_fields_rounded,
              size: 200,
            ),
            const Text('Apna network select karen'),
            SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.javascript,
                  size: 50,
                ),
                Icon(
                  Icons.javascript,
                  size: 50,
                ),
                Icon(
                  Icons.javascript,
                  size: 50,
                ),
                Icon(
                  Icons.javascript,
                  size: 50,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  _FixedLengthInputFormatter(),
                ],
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 39, 39, 39),
                  hintText: "3XXX XXXXXX",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  prefixText: '+92 | ',
                  prefixStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 120, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "By logging in you agree to our "),
                      TextSpan(
                        text: "Terms & Conditions ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 120, 241),
                        ),
                      ),
                      TextSpan(text: "and \n"),
                      TextSpan(
                        text: "Privacy Policy ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 120, 241),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   "By logging in you agree to our Terms & Conditions and\nPrivacy Policy",
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text("Terms & Conditions"),
                // ),
                // Text("and"),
              ],
            ),
            const SizedBox(height: 10),
            // TextButton(onPressed: () {}, child: Text("Privacy Policy")),
          ],
        ));
  }
}

class _FixedLengthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Ensure the total length with prefix does not exceed 14 (4 for '+92 | ' and 10 for digits)
    if (newValue.text.length > 14) {
      return oldValue;
    }
    return newValue;
  }
}
