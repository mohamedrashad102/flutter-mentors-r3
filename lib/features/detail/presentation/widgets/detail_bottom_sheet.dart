import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_transaction.dart';
import '../../../plan/presentation/views/plan_view.dart';

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
              _buildButton(context, AppImages.stopwatchIcon, 'preview', false),
              const Gap(16),
              _buildButton(context, AppImages.eyeIcon, 'Watch Now'),
            ],
          ),
        );
      },
    );
  }

  _buildButton(
    BuildContext context,
    String iconPath,
    String text, [
    bool isPrimary = true,
  ]) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          AppTransitions.slideFromBottom(context, const PlanView());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37),
            color: isPrimary
                ? AppColors.primaryColor
                : const Color(0xff899866).withValues(alpha: 0.40),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
