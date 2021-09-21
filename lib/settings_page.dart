import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Scheduled Restaurant Recommendation'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) => Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.scheduledRestaurant(value);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
