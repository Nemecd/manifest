import 'package:flutter/material.dart';
import 'package:manifest/ReportScreen.dart';

class DetailScreen extends StatefulWidget {
  final String origination;
  final String destination;
  final String dateTime;
  final String? waybillNumber;
  const DetailScreen(
      {super.key,
      required this.origination,
      required this.destination,
      required this.dateTime,
      this.waybillNumber});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Details Screen')),
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
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Origination',
                    style: TextStyle(fontSize: 15, fontFamily: 'Inter')),
                Text(widget.origination,
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        color: Color(0xFFa0a0a4))),
                const Text('Destination',
                    style: TextStyle(fontSize: 15, fontFamily: 'Inter')),
                Text(widget.destination,
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        color: Color(0xFFa0a0a4))),
                const Text('Date and Time',
                    style: TextStyle(fontSize: 15, fontFamily: 'Inter')),
                Text(widget.dateTime,
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        color: Color(0xFFa0a0a4))),
                if (widget.waybillNumber != null)
                  Text('Waybill Number: ${widget.waybillNumber}',
                      style:
                          const TextStyle(fontSize: 50, fontFamily: 'Inter')),
                Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const ReportScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 48.0),
                        ),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Reduce the border radius
                          ),
                        ),
                      ),
                      child: loading
                          ? Container(
                              width: 24,
                              height: 24,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white), // Set the color of the stroke
                              ),
                            )
                          : const Text(
                              'Report',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const ReportScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 48.0),
                        ),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color(0XFF1e65ff)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Reduce the border radius
                          ),
                        ),
                      ),
                      child: loading
                          ? Container(
                              width: 24,
                              height: 24,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white), // Set the color of the stroke
                              ),
                            )
                          : const Text(
                              'Report',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )),
                )
              ],
            ),
          ),
        ));
  }
}
