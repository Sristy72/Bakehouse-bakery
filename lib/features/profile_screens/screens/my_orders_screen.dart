import 'package:danielabake/core/common/shimmer/shimmer_loader.dart';
import 'package:danielabake/core/common/shimmer/shimmer_widgets.dart';
import 'package:danielabake/core/common/widgets/app_scaffold.dart';
import 'package:danielabake/features/Order_screen/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Order_screen/models/response/get_order_by_id_response_model.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final orderController = Get.find<OrderController>();
  // final ratingController = Get.find<RatingController>();
  //
  // // Review UI Controller (for stars & text field)
  // final reviewController = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    orderController.refreshOrders();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      removePadding: true,
      backgroundColor: const Color(0xffFFF8E8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFF8E8),
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFF7F3615)),
            insets: EdgeInsets.symmetric(horizontal: 40),
          ),
          labelColor: const Color(0xFF7F3615),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: "Ongoing"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [_ongoingList(), _completedList()],
      ),
    );
  }

  Widget _ongoingList() {
    return _orderList(
      orderController.ongoingOrder,
      emptyMessage: "No ongoing orders",
    );
  }

  Widget _completedList() {
    return _orderList(
      orderController.completedOrder,
      emptyMessage: "No completed orders yet",
      isCompleted: true,
    );
  }

  Widget _orderList(
    Rxn<GetOrderByIdResponseModel> source, {
    required String emptyMessage,
    bool isCompleted = false,
  }) {
    return Obx(() {
      final loading = orderController.isFetchingOrders.value;
      final data = source.value;

      if (loading || data == null) {
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: 3,
          itemBuilder: (_, __) => ShimmerWidgets.orderCard(),
        );
      }

      if (data.orders.isEmpty) {
        return Center(child: Text(emptyMessage));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: data.orders.length,
        itemBuilder: (context, index) {
          final order = data.orders[index];
          return _buildOrderCard(order, isCompleted: isCompleted);
        },
      );
    });
  }

  Widget _buildOrderCard(Order order, {bool isCompleted = false}) {
    final statusColor = order.status == "Delivered"
        ? Colors.green.shade700
        : const Color(0xFF7F3615);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF4E8), Color(0xFFFFE2C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id: #${order.id.substring(order.id.length - 6)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...order.items.map<Widget>((orderItem) {
            final item = orderItem.item;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.image,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.fastfood, size: 32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Qty: ${orderItem.quantity}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          if (isCompleted) ...[
                            const SizedBox(height: 6),
                          ],
                        ],
                      ),
                    ),
                    Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          const Divider(color: Color(0xFFAD653F), thickness: 1, height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "(${order.items.length} items)",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                "Total: \$${order.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: _buildReorderButton(order),
          ),
        ],
      ),
    );
  }

  Widget _buildReorderButton(Order order) {
    return Obx(() {
      final isReordering = orderController.reorderingOrders.contains(order.id);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B76FF), Color(0xFF1153FA)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1B76FF).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: isReordering ? null : () => orderController.reorderOrder(order),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh_rounded, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  if (isReordering)
                    ShimmerLoader(
                      isLoading: true,
                      baseColor: Colors.white.withOpacity(0.35),
                      highlightColor: Colors.white,
                      child: Container(
                        width: 70,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  else
                    const Text(
                      "Reorder",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // // Rating Dialog
  // void _showRatingDialog(dynamic order, dynamic orderItem) {
  //   final item = orderItem.item;
  //   final int quantity = orderItem.quantity;
  //   final double itemTotal = item.price * quantity;
  //
  //   // Reset every time dialog opens
  //   reviewController.selectedRating.value = 0;
  //   reviewController.feedbackController.clear();
  //
  //   Get.dialog(
  //     barrierDismissible: true,
  //     Dialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //       backgroundColor: Colors.transparent,
  //       child: Container(
  //         padding: const EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           color: const Color(0xffFFF3E0),
  //           borderRadius: BorderRadius.circular(24),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.15),
  //               blurRadius: 20,
  //               offset: const Offset(0, 10),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Close Button
  //             Align(
  //               alignment: Alignment.topRight,
  //               child: GestureDetector(
  //                 onTap: () => Get.back(),
  //                 child: Container(
  //                   padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                     color: const Color(0xffFFE0B2),
  //                     shape: BoxShape.circle,
  //                     border: Border.all(color: const Color(0xFFAD653F)),
  //                   ),
  //                   child: const Icon(Icons.close, size: 20, color: Color(0xFF7F3615)),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //
  //             const Text("Rate this item", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
  //             const SizedBox(height: 20),
  //
  //             // Item Preview Card
  //             Container(
  //               width: double.infinity,
  //               padding: const EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFFFE8CC),
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Row(
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(12),
  //                     child: Image.network(
  //                       item.image,
  //                       height: 80,
  //                       width: 80,
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (_, __, ___) => Container(
  //                         color: Colors.grey[300],
  //                         child: const Icon(Icons.fastfood),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           item.name,
  //                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         const SizedBox(height: 8),
  //                         Text(
  //                           "\$${itemTotal.toStringAsFixed(2)}  •  $quantity item${quantity > 1 ? 's' : ''}",
  //                           style: TextStyle(color: Colors.grey[700]),
  //                         ),
  //                         const SizedBox(height: 8),
  //                         const Text("Order delivered", style: TextStyle(fontWeight: FontWeight.w600)),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             const SizedBox(height: 30),
  //
  //             // Rating Stars + Feedback
  //             Obx(() => Container(
  //               padding: const EdgeInsets.all(20),
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFFFE8CC),
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Column(
  //                 children: [
  //                   const Text("How was your experience?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
  //                   const SizedBox(height: 20),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: List.generate(5, (i) => GestureDetector(
  //                       onTap: () => reviewController.setRating(i + 1),
  //                       child: Container(
  //                         margin: const EdgeInsets.symmetric(horizontal: 8),
  //                         child: Icon(
  //                           i < reviewController.selectedRating.value ? Icons.star : Icons.star_border,
  //                           color: const Color(0xFF7F3615),
  //                           size: 40,
  //                         ),
  //                       ),
  //                     )),
  //                   ),
  //                   const SizedBox(height: 24),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end, // Align word count to the right
  //                     children: [
  //                       TextField(
  //                         controller: reviewController.feedbackController,
  //                         maxLines: 4,
  //                         inputFormatters: [
  //                           MaxWordsInputFormatter(), // The formatter from previous response
  //                         ],
  //                         decoration: InputDecoration(
  //                           hintText: "Share your thoughts (optional)...",
  //                           hintStyle: const TextStyle(color: Colors.grey),
  //                           filled: true,
  //                           fillColor: const Color(0xFFFFEFD5),
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                             borderSide: const BorderSide(color: Color(0xFF7F3615)),
  //                           ),
  //                           enabledBorder: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                             borderSide: const BorderSide(color: Color(0xFF7F3615)),
  //                           ),
  //                           // Optional: Show word limit in the counter area inside the field
  //                           counterText: "",
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8), // Space between TextField and counter
  //                       ValueListenableBuilder<TextEditingValue>(
  //                         valueListenable: reviewController.feedbackController,
  //                         builder: (context, value, child) {
  //                           // Calculate word count
  //                           final text = value.text;
  //                           final words = text.trim().split(RegExp(r'\s+'));
  //                           final wordCount = text.isEmpty ? 0 : words.where((w) => w.isNotEmpty).length;
  //
  //                           // Optional: Change color when approaching or hitting the limit
  //                           final color = wordCount > 80
  //                               ? Colors.red
  //                               : wordCount > 70
  //                               ? Colors.orange
  //                               : Colors.grey;
  //
  //                           return Text(
  //                             "$wordCount/30 words",
  //                             style: TextStyle(
  //                               color: color,
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             )),
  //
  //             const SizedBox(height: 30),
  //
  //             // Submit Button
  //             SizedBox(
  //               width: double.infinity,
  //               child: PrimaryButton(
  //                 onApiPressed: () async => _submitRating(order, orderItem),
  //                 text: "Submit",
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Submit Review
  // Future<void> _submitRating(dynamic order, dynamic orderItem) async {
  //   if (reviewController.selectedRating.value == 0) {
  //     Get.snackbar(
  //       "Missing Rating",
  //       "Please select at least 1 star",
  //       backgroundColor: Colors.red.withOpacity(0.2),
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }
  //
  //   final int rating = reviewController.selectedRating.value;
  //   final String comment = reviewController.feedbackController.text.trim();
  //   final String orderId = order.id;                    // Correct: from parent order
  //   final String itemId = orderItem.item.id;            // Correct: from item
  //
  //   // Call API
  //   await ratingController.addReview(orderId, itemId, comment, rating);
  //
  //   // Note: Success snackbar + Get.back() is already handled inside RatingController
  //   // So we don't need to do it again here unless you want extra control
  // }
}
