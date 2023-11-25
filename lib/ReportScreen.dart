import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late bool loading;

  Map<String, Map<String, bool>> itemSelection = {
    'Over Speeding': {'Yes': false, 'No': false},
    'Answering calls': {'Yes': false, 'No': false},
    'Reckles Driving': {'Yes': false, 'No': false},
    'MisUnderstood the route':{'Yes': false, 'No': false},
    'Time Wasting' : {'Yes': false, 'No': false},
    'Parked for Eating': {'Yes': false, 'No': false},
    // Add other items here
  };
   final otherCtrl = TextEditingController();
  // ... Other variables for text field controllers and methods

  void updateSelection(String item, String option, bool value) {
    setState(() {
      itemSelection[item] = {
        'Yes': option == 'Yes' ? value : !value,
        'No': option == 'No' ? value : !value,
      };
    });
  }

  Widget buildCheckboxRow(String item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Over Speeding'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Answering calls'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Reckless Driving'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('MisUnderstood the Route'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Time Wasting'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Parked for Eating'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Car Breakdown'),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: itemSelection[item]!['Yes'],
                  onChanged: (value) =>
                      updateSelection(item, 'Yes', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('Yes'),
                const SizedBox(width: 8),
                Checkbox(
                  value: itemSelection[item]!['No'],
                  onChanged: (value) =>
                      updateSelection(item, 'No', value ?? false),
                ),
                const SizedBox(width: 8),
                const Text('No'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: otherCtrl,
          decoration: const InputDecoration(
            hintText: 'Enter other concerns and observation',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: const Color(0xFFf6fafd),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: Color(
                0xFFf6fafd), // Set the background color using a BoxDecoration
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemSelection.keys
                  .map<Widget>((String item) => buildCheckboxRow(item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
