import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'plan_card.dart';

class PlanCardSection extends StatefulWidget {
  const PlanCardSection({super.key});

  @override
  State<PlanCardSection> createState() => _PlanCardSectionState();
}

class _PlanCardSectionState extends State<PlanCardSection> {
  bool isMonthlyPlan = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlanCard(
          isSelected: isMonthlyPlan,
          planType: 'Monthly',
          onTap: () => setState(() => isMonthlyPlan = true),
        ),
        const Gap(16),
        PlanCard(
          isSelected: !isMonthlyPlan,
          planType: 'Yearly',
          onTap: () => setState(() => isMonthlyPlan = false),
        ),
      ],
    );
  }
}
