import 'dart:io';

import 'package:flutter/material.dart';

class KNameField extends StatefulWidget {
  const KNameField({Key? key, required this.onEdit}) : super(key: key);
  final void Function(String) onEdit;
  @override
  State<KNameField> createState() => _KNameFieldState();
}

class _KNameFieldState extends State<KNameField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: "name"),
      onChanged: widget.onEdit,
    );
  }
}

class KEmailField extends StatefulWidget {
  const KEmailField({Key? key, required this.onEdit}) : super(key: key);
  final void Function(String) onEdit;
  @override
  State<KEmailField> createState() => _KEmailFieldState();
}

class _KEmailFieldState extends State<KEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: "email"),
      onChanged: widget.onEdit,
    );
  }
}

class KPasswordField extends StatefulWidget {
  const KPasswordField({Key? key, required this.onEdit}) : super(key: key);
  final void Function(String) onEdit;
  @override
  State<KPasswordField> createState() => _KPasswordFieldState();
}

class _KPasswordFieldState extends State<KPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: "password"),
      onChanged: widget.onEdit,
    );
  }
}

class KImageContainer extends StatefulWidget {
  const KImageContainer(
      {Key? key,
      required this.width,
      required this.height,
      required this.profileFile})
      : super(key: key);
  final double width;
  final double height;
  final File? profileFile;
  @override
  State<KImageContainer> createState() => _KImageContainerState();
}

class _KImageContainerState extends State<KImageContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
          decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: widget.profileFile == null
              ? Image.asset('images/default.png').image
              : FileImage(widget.profileFile!),
        ),
      )),
    );
  }
}

class KUploadButton extends StatefulWidget {
  const KUploadButton({Key? key, required this.onTap, required this.verticalPadding, required this.horizontalPadding}) : super(key: key);
  final void Function() onTap;
  final double horizontalPadding;
  final double verticalPadding;
  @override
  State<KUploadButton> createState() => _KUploadButtonState();
}

class _KUploadButtonState extends State<KUploadButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Upload"), Icon(Icons.upload)],
        ),
      ),
    );
  }
}

class KCaptureButton extends StatefulWidget {
  const KCaptureButton({Key? key, required this.onTap, required this.horizontalPadding, required this.verticalPadding}) : super(key: key);
  final void Function() onTap;
  final double horizontalPadding;
  final double verticalPadding;
  @override
  State<KCaptureButton> createState() => _KCaptureButtonState();
}

class _KCaptureButtonState extends State<KCaptureButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Capture"), Icon(Icons.camera_alt_rounded)],
        ),
      ),
    );
  }
}
