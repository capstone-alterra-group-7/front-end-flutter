import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_1/detail_hotel/model/detail_hotel_model.dart';
import 'package:hotel_1/payment_final/view/payment_final_view.dart';

import '../../list_hotel/model/list_hotel_model.dart';
import '../../payment_hotel/model/payment_page_model.dart';

class PaymentResultPage extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final Room room;
  final ListHotel list;

  const PaymentResultPage({Key? key, required this.paymentMethod, required this.room, required this.list}) : super(key: key);

  @override
  _PaymentResultPageState createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  late Timer _timer;
  int _secondsRemaining = 300;

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          showPopup();
        }
      });
    });
  }

  void showPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Waktu Pembayaran Habis'),
          content: Text('Silakan kembali ke halaman sebelumnya.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the previous page
              },
            ),
          ],
        );
      },
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final minutesString = minutes.toString().padLeft(2, '0');
    final secondsString = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesString:$secondsString';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Waktu Pembayaran',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.04,
                          ),
                        ),
                        Text(
                          formatTime(_secondsRemaining),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32,),
                  Container(
                    width: 280,
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            widget.paymentMethod.imageAsset,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Container(
                          child: Column(
                            children: [
                              // Number / Total
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  ExpansionTile(
                    title: Text(
                      'Cara Pembayaran',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.025,
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Column(
                          children: [
                            for (final howTo in widget.paymentMethod.howTo)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      howTo,
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        letterSpacing: 0.04,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6,)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  DividerTheme(
                    data: DividerThemeData(
                      color: Colors.black,      // Set the color to black
                      thickness: 1.0,           // Increase or decrease the thickness as desired
                    ),
                    child: Divider(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
          child: Container(
            height: 56.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentFinal(room: widget.room, list: widget.list, paymentMethod: widget.paymentMethod,),
                  ),
                );
              },
              child: Text(
                'Bayar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
