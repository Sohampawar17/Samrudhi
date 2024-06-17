import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Registration Forms',
            style: TextStyle(fontSize: 24.0, fontFamily: 'Arial'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.store, color: Colors.blue),
                  title: Text(
                    'Retailer Form',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    var apiUrl = "$baseurl/retailer-distribution/new";
                    Uri url = Uri.parse(apiUrl);
                    // Convert Uri to String

                    if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.local_shipping, color: Colors.green),
                  title: Text(
                    'Supplier Form',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    var apiUrl = "$baseurl/supplier-registration/new";
                    Uri url = Uri.parse(apiUrl);
                    // Convert Uri to String

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.business, color: Colors.orange),
                  title: Text(
                    'Distributor Form',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    var apiUrl = "$baseurl/distributor-registration/new";
                    Uri url = Uri.parse(apiUrl);
                    // Convert Uri to String

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
