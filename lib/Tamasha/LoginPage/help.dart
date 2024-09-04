import 'package:flutter/material.dart';

class HelpDialog extends StatefulWidget {
  @override
  _HelpDialogState createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  final TextEditingController issueController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String selectedContactMethod = 'Email';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      title: const Text(
        'Need Help?',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Write your issue in detail.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: TextField(
                controller: issueController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Write Your Issue Here',
                  hintStyle: TextStyle(color: Colors.white30, fontSize: 14),
                  // labelText: 'Write your issue here',
                  alignLabelWithHint: true,
                  // labelStyle: TextStyle(color: Colors.white30, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Contact Details',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 6),
                Text(
                  '(Phone/Email)',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  activeColor: Colors.white,
                  value: 'Email',
                  groupValue: selectedContactMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedContactMethod = value!;
                      contactController.clear();
                    });
                  },
                ),
                const Text('Email'),
                Radio<String>(
                  activeColor: Colors.white,
                  value: 'Phone',
                  groupValue: selectedContactMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedContactMethod = value!;
                      contactController.clear();
                    });
                  },
                ),
                const Text('Phone'),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: TextField(
                controller: contactController,
                decoration: InputDecoration(
                  hintText: selectedContactMethod == 'Email'
                      ? 'example@jazz.pk'
                      : '92XXXXXXXXX',
                  hintStyle:
                      const TextStyle(color: Colors.white30, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle send action here
              },
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Usage in a button press:
void _showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return HelpDialog();
    },
  );
}
