import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:style_snap/src/core/constants.dart';

class ResponseScreen extends StatelessWidget {
  final String response;
  const ResponseScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kSilverGray.withOpacity(0.8),
          centerTitle: false,
          title: const Text(
            "STYLEsnap",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ).copyWith(top: MediaQuery.of(context).size.height * 0.13),
            child: ListTile(
              title: Text(response),
            ),
          ),
        ));
  }
}
