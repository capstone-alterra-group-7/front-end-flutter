import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_1/main_page.dart';
import 'package:provider/provider.dart';

import '../../features_order/utils/images.dart';
import '../../features_order/view_model/provider/train/train_order_detail_provider.dart';

class OrderKaiCancelledPage extends StatelessWidget {
  const OrderKaiCancelledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: AppBar(
          toolbarHeight: 48.h,
          title: Text(
            'Rincian Pesanan',
            style: GoogleFonts.openSans(
                fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
            },
          ),
        ),
      ),
      body: Consumer<TrainOrderDetailProvider>(
        builder: (context, orderDetail, child) {
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 18.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xEEEA817B),
                    ),
                    color: const Color(0xEEEA817B).withOpacity(0.3),
                  ),
                  height: 40.h,
                  width: 328.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/cancel.svg',
                          width: 20.w,
                          height: 20.h,
                          color: const Color(0xEEDB2D24)),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'Pesanan Dibatalkan',
                        style: GoogleFonts.openSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xEEDB2D24),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                    width: 328.w,
                    child: Card(
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 4.sp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Detail Pesanan',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0080FF))),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 8.sp),
                                    height: 79.h,
                                    width: 79.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.r),
                                      child: train2,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              orderDetail.getStationOrigin ??
                                                  '',
                                              style: GoogleFonts.openSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Icon(Icons.arrow_forward,
                                              size: 14.sp),
                                          Text(
                                              orderDetail
                                                      .getStationDestination ??
                                                  '',
                                              style: GoogleFonts.openSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.train_outlined,
                                            size: 12.sp,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(orderDetail.getNameTrain ?? '',
                                              style: GoogleFonts.openSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.event_seat_outlined,
                                              size: 12.sp),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(orderDetail.getClassTrain ?? '',
                                              style: GoogleFonts.openSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month_outlined,
                                              size: 12.sp),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(orderDetail.getDateTime ?? '',
                                              style: GoogleFonts.openSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1.sp,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nomor Pesanan: ',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Expanded(
                                    child: Text(
                                      orderDetail.getTicketOrderCode ?? '',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                    width: 328.w,
                    child: Card(
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 4.sp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Metode Pembayaran',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0080FF))),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(orderDetail.getTypePayment ?? '',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Image.network(
                                      orderDetail.getImagePayment ?? '',
                                      width: 22.59.w,
                                      height: 16.h)
                                ],
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                    width: 328.w,
                    child: Card(
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 4.sp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Informasi Pesanan',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0080FF))),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Waktu Pemesanan',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(orderDetail.getCreatedAt ?? '',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Waktu Pembayaran',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(orderDetail.getUpdatedAt ?? '',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Waktu Check-in',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text('26-04-2023, 14:00',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1.sp,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Alasan Pembatalan',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text('Dibatalkan pemesan',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: 328.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Ajukan Pengembalian Dana',
                      style: GoogleFonts.openSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: 328.w,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xEEE1E4EA),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Hubungi Bantuan',
                      style: GoogleFonts.openSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xEE0080FF)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
