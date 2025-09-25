import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class DetailBottomSheet extends StatelessWidget {
  const DetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 0,
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          color: const Color(0xff16103C),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildButton(AppImages.stopwatchIcon, 'preview', false),
              const Gap(16),
              _buildButton(AppImages.eyeIcon, 'Watch Now'),
            ],
          ),
        );
      },
    );
  }

  _buildButton(String iconPath, String text, [bool isPrimary = true]) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37),
          color: isPrimary
              ? AppColors.primaryColor
              : const Color(0xff899866).withValues(alpha: 0.40),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(iconPath),
            const Gap(7),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
