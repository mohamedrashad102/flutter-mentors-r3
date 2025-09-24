import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.isSelected,
    required this.planType,
    required this.onTap,
  });

  final bool isSelected;
  final String planType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isMonthly = planType == 'Monthly';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkColor : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.filesAndFolders),
            const Gap(22),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planType,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text.rich(
                        TextSpan(
                          text: isMonthly ? '\$5 USD' : '\$50 USD',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : AppColors.darkColor,
                          ),
                          children: [
                            TextSpan(
                              text: isMonthly ? ' /Month' : ' /Year',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA49AD8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      const Text(
                        'Include Family Sharing',
                        style: TextStyle(
                          color: Color(0xFFA49AD8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.darkColor,
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
