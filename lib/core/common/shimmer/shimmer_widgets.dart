import 'package:flutter/material.dart';

import 'shimmer_loader.dart';
import 'shimmer_placeholders.dart';

class ShimmerWidgets {
  const ShimmerWidgets._();

  static Widget foodGridCard({double height = 240}) {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF4E3), Color(0xFFFFE5C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ShimmerPlaceholders.rectangle(height: 130),
            ),
            const SizedBox(height: 12),
            ShimmerPlaceholders.textLine(width: 140, height: 16, borderRadius: 10),
            const SizedBox(height: 8),
            ShimmerPlaceholders.textLine(width: 110, height: 12, borderRadius: 10),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerPlaceholders.textLine(width: 70, height: 16, borderRadius: 8),
                ShimmerPlaceholders.circle(diameter: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget categoryPill({double width = 140, double height = 150}) {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFFFAF3FF), Color(0xFFE9F4FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerPlaceholders.textLine(width: 100, height: 16, borderRadius: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ShimmerPlaceholders.rectangle(
                width: 70,
                height: 60,
                borderRadius: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget weeklyMenuCard() {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerPlaceholders.textLine(width: 120, height: 18, borderRadius: 10),
            const SizedBox(height: 12),
            ...List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: index == 3 ? 0 : 8),
                child: Row(
                  children: [
                    ShimmerPlaceholders.circle(diameter: 8),
                    const SizedBox(width: 10),
                    ShimmerPlaceholders.textLine(width: 200, height: 12, borderRadius: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget profileHeader() {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            ShimmerPlaceholders.circle(diameter: 78),
            const SizedBox(height: 14),
            ShimmerPlaceholders.textLine(width: 140, height: 16, borderRadius: 10),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerPlaceholders.textLine(width: 70, height: 14, borderRadius: 8),
                const SizedBox(width: 16),
                ShimmerPlaceholders.textLine(width: 70, height: 14, borderRadius: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget chatTile() {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          ShimmerPlaceholders.circle(diameter: 54),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerPlaceholders.textLine(width: 160, height: 16, borderRadius: 10),
                const SizedBox(height: 6),
                ShimmerPlaceholders.textLine(width: 120, height: 12, borderRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget orderCard() {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerPlaceholders.textLine(width: 120, height: 14, borderRadius: 8),
                ShimmerPlaceholders.textLine(width: 70, height: 14, borderRadius: 8),
              ],
            ),
            const SizedBox(height: 14),
            ...List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    ShimmerPlaceholders.rectangle(width: 60, height: 60, borderRadius: 14),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerPlaceholders.textLine(width: 160, height: 14, borderRadius: 8),
                          const SizedBox(height: 6),
                          ShimmerPlaceholders.textLine(width: 80, height: 12, borderRadius: 8),
                        ],
                      ),
                    ),
                    ShimmerPlaceholders.textLine(width: 40, height: 14, borderRadius: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerPlaceholders.textLine(width: 90, height: 14, borderRadius: 8),
                ShimmerPlaceholders.textLine(width: 70, height: 16, borderRadius: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget buttonLoader({double height = 48}) {
    return ShimmerLoader(
      isLoading: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [Color(0xFF237EF4), Color(0xFF1153FA)],
          ),
        ),
      ),
    );
  }
}
