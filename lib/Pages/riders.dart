import 'package:flutter/material.dart';

class Riders extends StatefulWidget {
  const Riders({Key? key}) : super(key: key);

  @override
  State<Riders> createState() => _RidersState();
}

class _RidersState extends State<Riders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riders',
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text("display all recorded riders"),
          )
        ],
      ),
    );
  }
}
