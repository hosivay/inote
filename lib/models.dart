import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:auto_size_text/auto_size_text.dart';

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}

Widget autoSizeTextWidget(BuildContext context, String textNote) {
  return AutoSizeText(
    textNote,
    textDirection: isRTL(textNote) ? TextDirection.rtl : TextDirection.ltr,
    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    minFontSize: 9,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

Future<dynamic> infoDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('info'),
        backgroundColor: Colors.teal.shade100,
        content: const Text(
            'Developer : Hosivay\ninstagram: @hosivay\nGithub: @hosivay\nTelegram: @hosivay\nVersion 1.0.2'),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
