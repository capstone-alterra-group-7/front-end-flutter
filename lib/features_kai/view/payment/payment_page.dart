import 'dart:async';
import 'package:capstone_project_tripease/features_kai/view/payment/status_payment.dart';
import 'package:capstone_project_tripease/features_kai/view_model/order_ticket/order_train_provider.dart';
import 'package:capstone_project_tripease/features_kai/view_model/carriage/payment_provider.dart';
import 'package:capstone_project_tripease/features_kai/view_model/station/depature_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/order_train_model.dart';
import '../../view_model/order_ticket/response_order_train_provider.dart';
import '../../view_model/station/station_provider.dart';
import '../../view_model/timer/time_payment_provider.dart';
import '../../view_model/train/train_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.timerText,
      required this.imageUrl,
      required this.isPaymentVA});

  final bool isPaymentVA;
  final String imageUrl;
  final TimerPaymentProvider timerText;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isDropdownOpened = false;
  TimerPaymentProvider timerText = TimerPaymentProvider();
  Timer? countdownTimer;
  List<String> payWithOther = [
    '1. Pilih opsi pembayaran dengan OVO/Gopay/Minimarket dan lainnya pada halaman pembayaran.',
    '2. Setelah itu klik tombol bayar.',
    '3. Anda akan diarahkan ke aplikasi yang dipilih untuk melakukan pembayaran. Pastikan nomor yang terhubung dengan akun dompet digital yang akan digunakan pembayaran.',
    '4. Jika akun dompet digital telah terhubung dengan benar, masukan PIN pada halaman pembayaran.',
    '5. Tunggu hingga muncul notifikasi yang mengkonfirmasi bahwa pembayaran telah berhasil dilakukan.',
  ];

  List<String> payWithVA = [
    '1. Buka aplikasi perbankan Anda dan pilih menu pembayaran atau transfer.',
    '2. Pilih opsi pembayaran Virtual Account atau VA.',
    '3. Masukan nomor VA.',
    '4. Masukan jumlah pembayaran yang sesuai dengan tagihan yang diterima.',
    '5. Pilih rekenening atau kartu debit/kredit anda yang digunakan untuk melakukan pembayaran.',
    '6. Cek kembali informasi yang anda masukan, pastikan nomor VA dan jumlah pembayaran sudah benar.',
    '7. Konfirmasi pembayaran dengan memasukan kode OTP yang dikirimkan nomor telepon atau email terdaftar anda.',
    '8. Tunggu beberapa saat hingga proses pembayaran selesai dan terkonfirmasi.',
    '9. Simpan bukti pembayaran sebagai referensi untuk memudahkan proses verifikasi pembayaran oleh platform pemesanan.'
  ];

  @override
  void initState() {
    super.initState();
    TimerPaymentProvider timerPaymentOther =
        Provider.of<TimerPaymentProvider>(context, listen: false);
    timerPaymentOther.stopCountDown();
    timerPaymentOther.startCountDown(context);
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (timerPaymentOther.isTimeUp()) {
          countdownTimer?.cancel();

          Navigator.of(context).pop();
          showDialogWithContext(context);
        }
      },
    );
  }

  Future<dynamic> showDialogWithContext(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          title: Text('Time Up'),
          content: Text('The time has run out.'),
        );
      },
    );
  }

  Future<void> order() async {
    final orderTrain =
        Provider.of<PostOrderTrainProvider>(context, listen: false);

    PostOrderTrainModel postOrder = PostOrderTrainModel(
      emailOrder: orderTrain.getEmail,
      nameOrder: orderTrain.getName,
      paymentId: 1,
      phoneNumberOrder: orderTrain.getPhoneNumber,
      quantityAdult: orderTrain.getQuantityAdult,
      quantityInfant: orderTrain.getQuantityInfant,
      ticketTravelerDetailDeparture: orderTrain.getTicketTravelerDetail,
      travelerDetail: orderTrain.travelerDetail,
      withReturn: false,
    );

    await orderTrain.postOrderTrain(postOrder);
  }

  // void cekData() {
  //   final orderTrain =
  //       Provider.of<PostOrderTrainProvider>(context, listen: false);
  //   print('email : ${orderTrain.getEmail}');
  //   print('name : ${orderTrain.getName}');
  //   print('paymentID : ${orderTrain.getPaymentId}');
  //   print('notelp : ${orderTrain.getPhoneNumber}');
  //   print('return : ${orderTrain.getWithReturn}');
  //   print('adut : ${orderTrain.getQuantityAdult}');
  //   print('infant : ${orderTrain.getQuantityInfant}');
  //   print('tkt traveler dtl : ${orderTrain.getTicketTravelerDetail![0].date}');
  //   print(
  //       'tkt traveler dtl : ${orderTrain.getTicketTravelerDetail![0].stationDestinationId}');
  //   print(
  //       'tkt traveler dtl : ${orderTrain.getTicketTravelerDetail![0].stationOriginId}');
  //   print(
  //       'tkt traveler dtl : ${orderTrain.getTicketTravelerDetail![0].trainCarriageId}');
  //   print(
  //       'tkt traveler dtl : ${orderTrain.getTicketTravelerDetail![0].trainSeatId}');
  //   print('traveler dtl : ${orderTrain.travelerDetail![0].fullName}');
  //   print('traveler dtl : ${orderTrain.travelerDetail![0].idCardNumber}');
  //   print('traveler dtl : ${orderTrain.travelerDetail![0].title}');
  // }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final departureProv =
        Provider.of<DepartureViewModel>(context, listen: false);
    final postOrderProv =
        Provider.of<PostOrderTrainProvider>(context, listen: false);
    final paymentProv = Provider.of<PaymentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: GoogleFonts.openSans(
              fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Waktu Pembayaran',
                  style: GoogleFonts.openSans(
                      fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                Consumer<TimerPaymentProvider>(
                  builder: (context, timerSeat, _) {
                    return Text(timerSeat.timer,
                        style: GoogleFonts.openSans(
                            fontSize: 14.sp, fontWeight: FontWeight.w600));
                  },
                ),
              ],
            ),
            Container(
              height: 80.h,
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              color: const Color.fromARGB(255, 226, 228, 232),
              child: widget.isPaymentVA
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          paymentProv.getImageUrl!,
                          height: 60.h,
                          width: 60.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nomor Virtual Account',
                              style: GoogleFonts.openSans(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              paymentProv.getAccountNumber!,
                              style: GoogleFonts.openSans(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.content_copy,
                          size: 13,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 40.w,
                          height: 40.h,
                          child: Image.asset(
                            widget.imageUrl,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Biaya',
                              style: GoogleFonts.openSans(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                                '${departureProv.departure[departureProv.selectedDepartIndex as int].price}'),
                          ],
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpened = !isDropdownOpened;
                });
              },
              child: SizedBox(
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Cara Pembayaran',
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(isDropdownOpened
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: isDropdownOpened,
                child: SizedBox(
                    height: 420.h,
                    width: 304.w,
                    child: widget.isPaymentVA
                        ? ListView.builder(
                            itemCount: payWithVA.length,
                            itemBuilder: (BuildContext context, int index) {
                              String itemVA = payWithVA[index];
                              return ListTile(
                                title: Text(
                                  itemVA,
                                  maxLines: 19,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: payWithOther.length,
                            itemBuilder: (BuildContext context, int index) {
                              String itemOther = payWithOther[index];
                              return ListTile(
                                title: Text(
                                  itemOther,
                                  maxLines: 19,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          )),
              ),
            ),
            if (isDropdownOpened)
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ElevatedButton(
              onPressed: () async {
                order();

                if (postOrderProv.getStatusCode == '201') {
                  var departureProv =
                      Provider.of<DepartureViewModel>(context, listen: false);
                  var responseOrderProv =
                      Provider.of<ResponseOrderTrainProvider>(context,
                          listen: false);
                  var trainId = departureProv
                      .departure[departureProv.selectedDepartIndex as int]
                      .trainId;
                  var ticketId = postOrderProv.getTicketOrderId;

                  await responseOrderProv.getResponseOrder(ticketId, trainId);

                  if (context.mounted) {
                    print('success code : ${postOrderProv.getStatusCode}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Berhasil melakukan order Tiket KA',
                        ),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentStatus(),
                      ),
                      (route) => false,
                    );
                  }
                } else if (postOrderProv.getStatusCode == '400') {
                  print('failed code : ${postOrderProv.getStatusCode}');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Kesalahan Input Data order.',
                        ),
                      ),
                    );
                  }
                } else if (postOrderProv.getStatusCode == '401') {
                  print('failed code : ${postOrderProv.getStatusCode}');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                          child: Text(
                            'Internal Server error.',
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(252, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                primary: const Color(0XFF0080FF),
              ),
              child: Text(
                'Bayar',
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Warna teks putih
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
