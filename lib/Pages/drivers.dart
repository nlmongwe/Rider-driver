import 'package:flutter/material.dart';

class Drivers extends StatefulWidget {
  const Drivers({Key? key}) : super(key: key);

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Drivers",
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text("display all recorded drivers"),
          )
        ],
      ),
    );
  }
}
