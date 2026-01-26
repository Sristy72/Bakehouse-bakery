import 'package:danielabake/core/common/shimmer/shimmer_widgets.dart';
import 'package:danielabake/features/chat_screen/controller/message_controller.dart';
import 'package:danielabake/features/profile_screens/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/widgets/app_scaffold.dart';
import '../../profile_screens/widgets/chat_list_tile.dart';
import '../widgets/profile.dart';
import 'messaging_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _profileController = Get.find<ProfileController>();
  final _msgController = Get.find<MessageController>();


  String conversationId = "";

  @override
  void initState() {
    super.initState();
    initChat();
  }

  Future<void> initChat() async {
    // Fetch admin
    await _msgController.getAdmin(); // Make sure getAdmin() is async and returns after fetching admin
    // Once admin is fetched, create conversation if needed
    final admin = _msgController.admin.value;
    if (admin != null) {
     conversationId = await _msgController.getConversationId(admin.id);
    }

    _msgController.socketInitChat();
  }

  // Future<void> getConversationId(String adminId) async {
  //   conversationId = await _secureStoreServices.retrieveData(KeyConstants.conversationId) ?? '';
  //
  //   if (conversationId.isEmpty) {
  //     _msgController.createConversation(adminId);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // optional padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile
            Obx(() {
              final user = _profileController.userInfo.value;
              if (user == null) {
                return ShimmerWidgets.profileHeader();
              }

              return Profile(
                name: user.fullName,
                imagePath: user.avatarUrl,
              );
            }),

            const SizedBox(height: 30),

            // Chat with admin
            Obx(() {
              final admin = _msgController.admin.value;
              if (admin == null) {
                return ShimmerWidgets.chatTile();
              }

              return GestureDetector(
                onTap: () {
                  Get.to(() => MessagingScreen(
                    adminId: admin.id,
                    conversationId: conversationId,
                  ));
                },
                child: ChatListTile(
                  name: admin.name,
                  avatarUrl: admin.avatar,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

}

