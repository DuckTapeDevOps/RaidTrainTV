import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:url_launcher/url_launcher.dart';


class RaidTrains extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for data
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error, if any
          return Text('Error: ${snapshot.error}');
        } else {
          return buildContent(snapshot.data ?? []);
        }
      },
    );
  }

  Future<List> fetchData() async {
    var yamlString = await rootBundle.loadString('assets/raid_trains.yaml');
    var yamlList = loadYaml(yamlString);

    return yamlList;
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  
  Widget buildContent(List hostsData) {
    return ListView.builder(
      itemCount: hostsData.length,
      itemBuilder: (context, index) {
        Map hostData = hostsData[index];
        String host = hostData['host'];
        List<Map> raids = List<Map>.from(hostData['raids']);

        return Card(
          margin: EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: Text(
              'Host: $host',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            children: raids.map<Widget>((raid) {
              String raidName = raid['name'];
              List events = List<Map>.from(raid['events']);

              return ExpansionTile(
                title: Text(
                  raidName,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                children: events.map<Widget>((event) {
                  return ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Time: ${event['time']}'),
                    subtitle: GestureDetector(
                      child: Text('User: ${event['user']}',
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                      onTap: () {
                        _launchURL('https://www.twitch.tv/${event['user']}');
                      },
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
