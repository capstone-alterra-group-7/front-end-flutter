import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:capstone_project_tripease/features_pesanan/view/widgets/hotel/card/card_return_canceled.dart';
import 'package:capstone_project_tripease/features_pesanan/view/widgets/hotel/card/card_return_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../features_rincian_pesanan_hotel/view/pesanan_kembali_berhasil.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../utils/icons.dart';
import '../../../utils/images.dart';
import '../../../view_model/provider/data_provider.dart';
import 'card/card_active.dart';
import 'card/card_canceled.dart';
import 'card/card_finished.dart';
import 'card/card_return_proses.dart';
import 'card/card_wait.dart';
import '../card_hotel.dart';

class Hotel extends StatelessWidget {
  const Hotel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    tabProvider.setActiveTabIndex(0);

    ScreenUtil.init(context);

    return Container(
      color: background,
      child: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.5),
                          spreadRadius: 1.w,
                          blurRadius: 5.w,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: ButtonsTabBar(
                        radius: 50.0.r,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        backgroundColor: mainBlue,
                        unselectedBackgroundColor: background,
                        labelStyle: myTextTheme.labelLarge,
                        unselectedLabelStyle: myTextTheme.labelMedium,
                        borderColor: grey,
                        borderWidth: .3.w,
                        tabs: const [
                          Tab(text: 'Semua'),
                          Tab(text: 'Menunggu'),
                          Tab(text: 'Aktif'),
                          Tab(text: 'Selesai'),
                          Tab(text: 'Dibatalkan'),
                          Tab(text: 'Pengembalian'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: CardHotel.cardHotel.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PesananKembaliBerhasil(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: background,
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.5),
                                      spreadRadius: 1.w,
                                      blurRadius: 3.w,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                // height:205.h,
                                width: 350.w,
                                child: Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CardHotel.cardHotel[index].icon,
                                          SizedBox(width: 5.w),
                                          Text(
                                            CardHotel.cardHotel[index].title,
                                            style: myTextTheme.titleLarge,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            child: SizedBox.fromSize(
                                              size: Size.fromRadius(48.r),
                                              child: CardHotel
                                                  .cardHotel[index].image,
                                            ),
                                          ),
                                          SizedBox(width: 20.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  CardHotel
                                                      .cardHotel[index].name,
                                                  style:
                                                      myTextTheme.displayMedium,
                                                ),
                                                SizedBox(height: 10.h),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CardHotel
                                                            .cardHotel[index]
                                                            .location,
                                                        SizedBox(width: 10.w),
                                                        Expanded(
                                                          child: Text(
                                                            CardHotel
                                                                .cardHotel[
                                                                    index]
                                                                .nameLocation,
                                                            style: myTextTheme
                                                                .headlineSmall,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        CardHotel
                                                            .cardHotel[index]
                                                            .bed,
                                                        SizedBox(width: 10.w),
                                                        Expanded(
                                                          child: Text(
                                                            CardHotel
                                                                .cardHotel[
                                                                    index]
                                                                .nameBed,
                                                            style: myTextTheme
                                                                .headlineSmall,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        CardHotel
                                                            .cardHotel[index]
                                                            .bedTime,
                                                        SizedBox(width: 10.w),
                                                        Expanded(
                                                          child: Text(
                                                            CardHotel
                                                                .cardHotel[
                                                                    index]
                                                                .nameBedTime,
                                                            style: myTextTheme
                                                                .headlineSmall,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        CardHotel
                                                            .cardHotel[index]
                                                            .dateTime,
                                                        SizedBox(width: 10.w),
                                                        Expanded(
                                                          child: Text(
                                                            CardHotel
                                                                .cardHotel[
                                                                    index]
                                                                .nameDateTime,
                                                            style: myTextTheme
                                                                .headlineSmall,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      const Divider(
                                        color: black,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Nomor Pesanan :',
                                              style: myTextTheme.bodySmall,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              CardHotel
                                                  .cardHotel[index].noPesanan,
                                              style: myTextTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    // children: [
                    // CardActiveHotel(
                    //   icon: iconCheck,
                    //   title: 'SUDAH BAYAR',
                    //   name: 'Shibuya Shabu',
                    //   image: shibuya,
                    //   iconLocation: iconLocation,
                    //   titleLocation: 'Bangkok - Thailand',
                    //   iconBed: iconBed,
                    //   titleBed: 'Exclusive Room',
                    //   iconBedTime: iconBedTime,
                    //   titleBedTime: '1 Night',
                    //   iconDate: iconDate,
                    //   titleDate: '26 April 2023 - 22 April 2023',
                    //   nomorPesanan: '60985827',
                    // ),
                    // CardCanceledHotel(
                    //   icon: iconCencel,
                    //   title: 'PESANAN DIBATALKAN',
                    //   name: 'Everyday',
                    //   image: everyday,
                    //   iconLocation: iconLocation,
                    //   titleLocation: 'Jl. Soekarno Hatta, Malang',
                    //   iconBed: iconBed,
                    //   titleBed: 'Standard Room',
                    //   iconBedTime: iconBedTime,
                    //   titleBedTime: '2 Night',
                    //   iconDate: iconDate,
                    //   titleDate: '05 Mei 2023 - 07 Mei 2023',
                    //   nomorPesanan: '53243434',
                    // ),
                    // CardReturnFinishHotel(
                    //   icon: iconCheck,
                    //   title: 'BERHASIL DIKEMBALIKAN',
                    //   name: 'Shibuya Shabu',
                    //   image: shibuya,
                    //   iconLocation: iconLocation,
                    //   titleLocation: 'Bangkok - Thailand',
                    //   iconBed: iconBed,
                    //   titleBed: 'Exclusive Room',
                    //   iconBedTime: iconBedTime,
                    //   titleBedTime: '1 Night',
                    //   iconDate: iconDate,
                    //   titleDate: '26 April 2023 - 22 April 2023',
                    //   nomorPesanan: '60985827',
                    // ),
                    // ],
                  ),
                  ListView(
                    children: [
                      // CardWaitHotel(
                      //   icon: iconSchedule,
                      //   title: 'MENUNGGU PEMBAYARAN - ',
                      //   time: '38:24',
                      //   name: 'Everyday',
                      //   image: everyday,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Jl. Soekarno Hatta, Malang',
                      //   iconBed: iconBed,
                      //   titleBed: 'Standard Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '2 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '05 Mei 2023 - 07 Mei 2023',
                      //   nomorPesanan: '53243434',
                      // ),
                    ],
                  ),
                  ListView(
                    children: [
                      // CardActiveHotel(
                      //   icon: iconCheck,
                      //   title: 'Sudah Bayar',
                      //   name: 'Shibuya Shabu',
                      //   image: shibuya,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Bangkok - Thailand',
                      //   iconBed: iconBed,
                      //   titleBed: 'Exclusive Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '1 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '26 April 2023 - 22 April 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                    ],
                  ),
                  ListView(
                    children: [
                      // CardFinishedHotel(
                      //   icon: iconPesananSelesai,
                      //   title: 'PESANAN SELESAI',
                      //   name: 'Shibuya Shabu',
                      //   image: shibuya,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Bangkok - Thailand',
                      //   iconBed: iconBed,
                      //   titleBed: 'Exclusive Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '1 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '26 April 2023 - 22 April 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                    ],
                  ),
                  ListView(
                    children: [
                      // CardCanceledHotel(
                      //   icon: iconCencel,
                      //   title: 'PESANAN DIBATALKAN',
                      //   name: 'Everyday',
                      //   image: everyday,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Jl. Soekarno Hatta, Malang',
                      //   iconBed: iconBed,
                      //   titleBed: 'Standard Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '2 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '05 Mei 2023 - 07 Mei 2023',
                      //   nomorPesanan: '53243434',
                      // ),
                      // CardCanceledHotel(
                      //   icon: iconCencel,
                      //   title: 'MELEWATI BATAS WAKTU PEMBAYARAN',
                      //   name: 'Shangri-La',
                      //   image: shibuya,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Jl. Mayjend Sungkono, Surabaya',
                      //   iconBed: iconBed,
                      //   titleBed: 'Exclusive Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '1 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '26 April 2023 - 22 April 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                    ],
                  ),
                  ListView(
                    children: [
                      // CardReturnProsesHotel(
                      //   icon: iconSchedule,
                      //   title: 'DALAM PROSES PENGEMBALIAN',
                      //   name: 'Everyday',
                      //   image: everyday,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Jl. Soekarno Hatta, Malang',
                      //   iconBed: iconBed,
                      //   titleBed: 'Standard Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '2 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '05 Mei 2023 - 07 Mei 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                      // CardReturnFinishHotel(
                      //   icon: iconCheck,
                      //   title: 'BERHASIL DIKEMBALIKAN',
                      //   name: 'Shangri-La',
                      //   image: shibuya,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Jl. Mayjend Sungkono, Surabaya',
                      //   iconBed: iconBed,
                      //   titleBed: 'Exclusive Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '1 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '26 April 2023 - 22 April 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                      // CardReturnCanceledHotel(
                      //   icon: iconCencel,
                      //   title: 'GAGAL DIKEMBALIKAN',
                      //   name: 'Shibuya Shabu',
                      //   image: shibuya,
                      //   iconLocation: iconLocation,
                      //   titleLocation: 'Bangkok - Thailand',
                      //   iconBed: iconBed,
                      //   titleBed: 'Exclusive Room',
                      //   iconBedTime: iconBedTime,
                      //   titleBedTime: '1 Night',
                      //   iconDate: iconDate,
                      //   titleDate: '26 April 2023 - 22 April 2023',
                      //   nomorPesanan: '60985827',
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
