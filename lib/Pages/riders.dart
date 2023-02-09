import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_driver/AppAuth/userAuth.dart';
import 'package:rider_driver/Database/appDatabase.dart';
import 'package:rider_driver/Utill/constants.dart';

class Riders extends StatefulWidget {
  const Riders({Key? key}) : super(key: key);
  @override
  State<Riders> createState() => _RidersState();
}

class _RidersState extends State<Riders> {
  final Database _database = Database();
  User? loggedInPerson;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    loggedInPerson = UserAuthentication.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riders',
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
              IconButton(onPressed: _createRide, icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: StreamBuilder(
                  stream: _database.getRidesData(),
                  builder: (BuildContext context, rideStream) {
                    if (rideStream.hasData) {
                      return KTripCards(
                          stream: rideStream, user: loggedInPerson);
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text('Riders will appear here'),
                          SizedBox(height: 5),
                          Icon(Icons.directions_walk),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void _createRide() {
    _database.saveRiderData(loggedInPerson!.email.toString());
  }
}
