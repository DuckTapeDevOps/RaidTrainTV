import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yaml/yaml.dart';
import 'package:url_launcher/url_launcher.dart';



String convertToLocaleTime(String eventTime) {
    // Convert event time to DateTime object
    DateTime dateTime = DateFormat("EEEE, MMMM d, y HH:mm").parse(eventTime);
    // Format DateTime object to local time
    String formattedDateTime = DateFormat.yMMMMd().add_jm().format(dateTime.toLocal());
    return formattedDateTime;
  }

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

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
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
                  String convertedTime = convertToLocaleTime(event['time']);
                  return ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Time: $convertedTime'),
                    subtitle: GestureDetector(
                      child: Text('${event['user']}',
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                      onTap: () {
                        _launchURL(Uri.parse('https://www.${event['link']}'));
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
