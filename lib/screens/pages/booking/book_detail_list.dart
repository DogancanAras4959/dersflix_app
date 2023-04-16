import 'package:dersflix_app/datas/booking.dart';
import 'package:dersflix_app/provider/booking_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../datas/bookingReq.dart';
import '../../../provider/booking_provider.dart';
import 'booking_request.dart';
import 'components/booking_item_list.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 60.0;
    double width = MediaQuery.of(context).size.width;

    final bookings = Provider.of<BookingProvider>(context);
    bookings.getBookings();

    List<Booking> bookingList = bookings.bookingList.cast<Booking>();
    bookingList.sort((a, b) => b.bookingTime.compareTo(a.bookingTime));

    final bookingRequests = Provider.of<BookingReqProvider>(context);
    bookingRequests.getBookingReqs();

    List<BookingReq> bookingRequestList =
        bookingRequests.bookingReqList.cast<BookingReq>();
    bookingRequestList.sort((a, b) => b.bookingTime.compareTo(a.bookingTime));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Yaklaşan",
              ),
              Tab(text: "Onay Bekleyen"),
            ],
          ),
          title: const Text(
            "Randevular",
          ),
          backgroundColor: const Color.fromARGB(250, 96, 40, 109),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingRequest()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(250, 96, 40, 109),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add_circle,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      Text(
                                        " Randevu Oluştur",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GridView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 8 / 2,
                          ),
                          children: bookingList
                              .map(
                                (items) => Column(
                                  children: [
                                    BookingItemList(
                                      type: "Yaklaşan",
                                      title: items.studyName,
                                      bookingTime:
                                          items.bookingTime as DateTime,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: GridView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 8 / 2,
                    ),
                    children: bookingRequestList
                        .map(
                          (items) => Column(
                            children: [
                              BookingItemList(
                                type: "Onay Bekleyen",
                                title: items.studyName,
                                bookingTime: DateTime.parse(items.bookingTime),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
