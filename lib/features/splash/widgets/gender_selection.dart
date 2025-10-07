import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/theme_extension.dart';
import '../../../core/utils/app_colors.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool isManSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
          context,
          'Woman',
          !isManSelected,
          () => setState(() => isManSelected = false),
        ),
        const Gap(10),
        _buildButton(
          context,
          'Man',
          isManSelected,
          () => setState(() => isManSelected = true),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 60,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: isActive ? AppColors.primaryLight : const Color(0xFFF5F6FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive
                  ? context.theme.primaryTextColor
                  : AppColors.secondaryText,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.10,
            ),
          ),
        ),
      ),
    );
  }
}
