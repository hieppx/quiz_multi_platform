import 'package:flutter/material.dart';

class RankContainer extends StatelessWidget {
  const RankContainer({super.key, required this.rank, required this.isSmall});
  final int? rank;
  final bool? isSmall;

  @override
  Widget build(BuildContext context) {
    return rank == 3
        ? _buildRank3(context)
        : rank == 1
            ? _buildRank1(context)
            : _buildRank2(context);
  }

  Widget _buildRank3(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 25,
              width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffb9924d),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 25,
              width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffb9924d),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRank1(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffeab33c),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffeab33c),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffeab33c),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffeab33c),
          ),
        ),
      ],
    );
  }

  Widget _buildRank2(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffa9a9a9),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffa9a9a9),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 25,
          width: isSmall == true ? isSmall == true ? 105 : 180 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffa9a9a9),
          ),
        ),
      ],
    );
  }
}
