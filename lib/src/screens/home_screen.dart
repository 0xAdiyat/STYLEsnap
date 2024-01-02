import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:style_snap/src/core/constants.dart';
import 'package:style_snap/src/screens/response_screen.dart';
import '../core/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _imageFile;
  String selectedOccasion = '';
  bool showError = false;
  bool isAnalyzing = false;
  bool isPortraitPersonImage = false;

  final gemini = Gemini.instance;

  Future<void> selectImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        _imageFile = File(res.files.first.path!);
        showError = false;
      });
    }
  }

  Future<String> imageAnalyzer(String text, File image) async {
    String result = "";
    setState(() {
      isAnalyzing = true;
    });

    try {
      final value = await gemini.textAndImage(
        text: text,
        images: [
          image.readAsBytesSync(),
        ],
      );

      setState(() {
        result = value!.content!.parts![0].text!;
      });
    } catch (e) {
      log('textAndImageInput', error: e);
    } finally {
      setState(() {
        isAnalyzing = false;
      });
    }

    return result;
  }

  Future<void> startAnalyzing() async {
    if (selectedOccasion.isEmpty || _imageFile == null || isAnalyzing) {
      setState(() {
        showError = true;
      });
      return;
    } else {
      bool containsPerson = await containsSingleOrPortraitPerson(_imageFile!);

      print("contains person $containsPerson");

      if (!containsPerson) {
        setState(() {
          showError = true;
          _imageFile = null;
        });
        return;
      } else {
        setState(() {
          showError = false;
        });

        String res = await imageAnalyzer(
            "Analyze my outfit in this picture and tell me some clothing styles and necessary adjustment required that would look better in $selectedOccasion look",
            _imageFile!);

        setState(() {
          _imageFile = null;
        });

        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResponseScreen(response: res)));
        }
      }
    }
  }

  Future<bool> containsSingleOrPortraitPerson(File imageFile) async {
    String result = await imageAnalyzer(
        "Analyze the image and determine if there is exactly one visible human figure present. Return TRUE if only one person is detected, and FALSE otherwise",
        imageFile);

    if (!result.contains("TRUE")) {
      setState(() {
        isPortraitPersonImage = false;
      });
    } else {
      setState(() {
        isPortraitPersonImage = true;
      });
    }

    return isPortraitPersonImage;
  }

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
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ImageUploadSection(
              onPressed: selectImage,
              imageFile: _imageFile,
            ),
          ),
          Positioned(
            bottom: -20,
            right: 124,
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                color: kPlatinumWhite.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -12,
            right: 64,
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: kPlatinumWhite.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 320,
              width: 320,
              decoration: const BoxDecoration(
                color: kPlatinumWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'What occasion is this outfit for?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      buildOccasionChip('Casual'),
                      buildOccasionChip('Formal'),
                      buildOccasionChip('Work'),
                      // Add more occasion chips as needed
                    ],
                  ),
                  if (showError) const SizedBox(height: 16),
                  if (showError)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: const BoxDecoration(color: kWhite),
                      child: Text(
                        'Please select an occasion and upload an image.',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kErrorColor),
                      ),
                    ),
                  if (isAnalyzing) const SizedBox(height: 16),
                  if (isAnalyzing) const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: isAnalyzing ? null : startAnalyzing,
                    child: const Text("Start Analyzer"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOccasionChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedOccasion == label,
      onSelected: (selected) {
        setState(() {
          selectedOccasion = selected ? label : '';
        });
      },
    );
  }
}

class ImageUploadSection extends StatelessWidget {
  final VoidCallback onPressed;
  final File? imageFile;
  const ImageUploadSection(
      {super.key, required this.onPressed, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return imageFile != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              imageFile!,
              fit: BoxFit.cover,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0)
                .copyWith(bottom: MediaQuery.of(context).size.height * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, size: 40),
                  onPressed: onPressed,
                ),
                const SizedBox(width: 8),
                Text(
                  "Upload a picture (full body for best results)",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
  }
}
