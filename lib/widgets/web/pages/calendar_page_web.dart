import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/universal/cards/calendar_card.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

class CalendarPageWeb extends StatelessWidget {
  final months = [
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  CalendarPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            height: 10.0,
            repeat: ImageRepeat.repeatX,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Stack(
              children: [
                const Text(
                  "Libatkan Dirimu\nDalam Kemeriahan\nBulan Ini!",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 275.0,
                  child: SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: Image.asset('assets/images/eol_cal.png'),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 500.0,
                  child: CircleButton(
                    color: kPurpleColor,
                    text: const Text(
                      "CeK Tanggal",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/border1.png',
                repeat: ImageRepeat.repeatX,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: months.length,
            itemBuilder: (context, index) {
              return CalendarCard(
                month: months[index],
                image: Image.asset(
                  'assets/images/${months[index].toLowerCase()}.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Stack(
                    children: [
                      Image.asset(
                        'assets/images/placeholder_months.png',
                        color: _placeholderColor(index),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Text(
                            "Belum Ada Event\nCek Lagi Lain\nWaktu!",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}

Color _placeholderColor(index) {
  final colors = [
    kPurpleColor,
    kPinkColor,
    kYellowColor,
    const Color(0xFF00BBF9),
    const Color(0xFF00F5D4),
  ];
  return colors[index % 5];
}
