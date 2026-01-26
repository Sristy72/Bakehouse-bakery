import 'package:danielabake/core/network/services/auth_storage_service.dart';
import 'package:danielabake/navigation_menu.dart';
import 'package:flutter/material.dart';
import '../../features/splash_screen/screens/first_screen.dart';
import 'core/common/shimmer/shimmer_loader.dart';
import 'core/common/shimmer/shimmer_placeholders.dart';

class RootWrapper extends StatelessWidget {
  RootWrapper({super.key});

  final AuthStorageService _authStorageService = AuthStorageService();

  Future<bool> _checkToken() async {
    final token = await _authStorageService.getRefreshToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFF8E8),
            body: Center(
              child: ShimmerLoader(
                isLoading: true,
                baseColor: Colors.orange.shade100,
                highlightColor: Colors.white,
                duration: const Duration(milliseconds: 1400),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE7C2), Color(0xFFFFD7A4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerPlaceholders.circle(diameter: 76),
                      const SizedBox(height: 14),
                      ShimmerPlaceholders.textLine(
                        width: 180,
                        height: 16,
                        borderRadius: 12,
                      ),
                      const SizedBox(height: 8),
                      ShimmerPlaceholders.textLine(
                        width: 140,
                        height: 12,
                        borderRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        /// If refresh token exists → go to navigation menu
        if (snapshot.data == true) {
          return const NavigationMenu();
        }

        /// Otherwise → go to splash screen
        return const FirstScreen();
      },
    );
  }
}
