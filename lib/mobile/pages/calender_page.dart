import 'package:flutter/material.dart';
import 'package:jatimtour/multi/buttons/mp_button.dart';
import 'package:jatimtour/multi/cards/calender_card.dart';

class CalenderPage extends StatelessWidget {
  final List<String> months = [
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

  CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/leading.png',
          repeat: ImageRepeat.repeatX,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Stack(
            children: [
              const Text(
                "Libatkan Dirimu\nDalam Kemeriahan\nBulan Ini!",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Positioned(
                bottom: 4.0,
                left: 140.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Image.asset('assets/images/eol_cal.png'),
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 190.0,
                child: MPButton(
                  color: const Color(0xFF9B5DE5),
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
            return CalenderCard(
              month: months[index],
              image: Image.asset(
                'assets/images/${months[index].toLowerCase()}.png',
                errorBuilder: (context, error, stackTrace) => Stack(
                  children: [
                    Image.asset(
                      'assets/images/placeholder_months.png',
                      color: placeholderColor(index),
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
    );
  }

  Color placeholderColor(index) {
    final List<Color> colors = [
      const Color(0xFF9B5DE5),
      const Color(0xFFF15BB5),
      const Color(0xFFFEE440),
      const Color(0xFF00BBF9),
      const Color(0xFF00F5D4),
    ];
    return colors[index % 5];
  }
}