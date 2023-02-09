import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_driver/Database/appDatabase.dart';

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
  const KUploadButton(
      {Key? key,
      required this.onTap,
      required this.verticalPadding,
      required this.horizontalPadding})
      : super(key: key);
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
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
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
  const KCaptureButton(
      {Key? key,
      required this.onTap,
      required this.horizontalPadding,
      required this.verticalPadding})
      : super(key: key);
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
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
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

class KFooterNavButtons extends StatefulWidget {
  const KFooterNavButtons({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final void Function() onTap;
  final String title;
  @override
  State<KFooterNavButtons> createState() => _KFooterNavButtonsState();
}

class _KFooterNavButtonsState extends State<KFooterNavButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Text(widget.title.toString()),
    );
  }
}

class KTripCards extends StatefulWidget {
  const KTripCards({Key? key, required this.stream, required this.user})
      : super(key: key);
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> stream;
  final User? user;
  @override
  State<KTripCards> createState() => _KTripCardsState();
}

class _KTripCardsState extends State<KTripCards> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.stream.data!.size,
        itemBuilder: (BuildContext context, index) {
          if (widget.stream.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      KCardAvatar(
                        imageUrl: widget.stream.data?.docs[index]['image'],
                        user: widget.user,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Text(
                                    widget.stream.data?.docs[index]['name'],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.person_sharp,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                KCardLabel(
                                    icon: Icons.pin_drop,
                                    label: widget.stream.data?.docs[index]
                                        ['from']),
                                KCardLabel(
                                    icon: Icons.drive_eta,
                                    label: widget.stream.data?.docs[index]
                                        ['to']),
                                KCardLabel(
                                    icon: Icons.watch_outlined,
                                    label: widget.stream.data?.docs[index]
                                        ['pickUpTime']),
                                KCardLabel(
                                    icon: Icons.money,
                                    label: widget.stream.data?.docs[index]
                                        ['pay'])
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

class KCardLabel extends StatelessWidget {
  const KCardLabel({Key? key, required this.icon, required this.label})
      : super(key: key);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 2),
        Text(label),
      ],
    );
  }
}

class KCardAvatar extends StatefulWidget {
  const KCardAvatar({Key? key, required this.imageUrl, required this.user})
      : super(key: key);
  final String imageUrl;
  final User? user;
  @override
  State<KCardAvatar> createState() => _KCardAvatarState();
}

class _KCardAvatarState extends State<KCardAvatar> {
  bool online = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: 75,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: online == true ? Colors.green : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(widget.imageUrl), fit: BoxFit.fill),
          ),
        ));
  }

  Future<void> _isOnline() async {
    Database database = Database();
    String? loginUrl =
        await database.downloadUserImage(widget.user!.email.toString());
    if (loginUrl == widget.imageUrl) {
      print('green');
      _setOnline(true);
    }
    print('grey');
    _setOnline(false);
  }

  void _setOnline(bool state) {
    setState(() {
      online = state;
    });
  }
}
