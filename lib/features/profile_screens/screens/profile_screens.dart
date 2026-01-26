import 'package:danielabake/core/common/shimmer/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          final user = _profileController.userInfo.value;

          if (user == null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ShimmerWidgets.profileHeader(),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: SingleChildScrollView(
              key: const ValueKey('profile-content'),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileCard(
                  name: user.fullName,
                  imagePath: user.avatarUrl,
                  orders: user.totalOrders.toString(),
                  favorites: user.totalFavorites.toString(),
                  onEdit: () {
                    print('Edit clicked');
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
