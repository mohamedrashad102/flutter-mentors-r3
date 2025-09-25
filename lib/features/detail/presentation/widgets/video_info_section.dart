import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_images.dart';

class VideoInfoSection extends StatelessWidget {
  const VideoInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xff2C1E51)),
      child: Stack(
        alignment: Alignment.center,
        children: [_topOval(), _bottomOval(), _blurEffect(), _content()],
      ),
    );
  }

  Padding _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          const Gap(60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              _opacityButton('Dark Fantasy'),
              _opacityButton('Action'),
              _opacityButton('Adventure'),
            ],
          ),
          const Gap(20),
          _buildDivider(),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconText(AppImages.eyeIcon, '2.3M', 'Views'),
              _buildIconText(AppImages.handIcon, '2K', 'Clap'),
              _buildIconText(AppImages.movieIcon, '4', 'Seasons'),
            ],
          ),
          const Gap(10),
          _buildDivider(),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.fireIcon),
              const Gap(7),
              const Expanded(
                child: Text(
                  'Demon Slayer: Kimetsu no Yaiba follows Tanjiro, a kind-hearted boy who becomes a demon slayer after his family is slaughtered and his sister is turned into a demon. Experience breathtaking battles, stunning animation, and an emotional journey of courage and hope.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
        ],
      ),
    );
  }

  SizedBox _blurEffect() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 21, // horizontal blur intensity
          sigmaY: 21, // vertical blur intensity
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff2C1E51).withValues(alpha: 0.45),
          ),
        ),
      ),
    );
  }

  Positioned _bottomOval() {
    return Positioned(
      bottom: 30,
      left: -17,
      child: Image.asset(AppImages.bottomOval),
    );
  }

  Positioned _topOval() {
    return Positioned(
      top: -23,
      right: -17,
      child: Image.asset(AppImages.topOval),
    );
  }

  _opacityButton(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color(0xffD9D9D9).withValues(alpha: 0.24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _buildDivider() {
    return Divider(
      color: const Color(0xff747272).withValues(alpha: 0.42),
      thickness: 1,
    );
  }

  _buildIconText(String iconPath, String value, String type) {
    return Row(
      children: [
        Image.asset(iconPath),
        const Gap(7),
        Text.rich(
          TextSpan(
            text: value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: ' $type',
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
