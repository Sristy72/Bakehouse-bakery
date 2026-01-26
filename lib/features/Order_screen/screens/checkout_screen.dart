import 'package:danielabake/core/common/shimmer/shimmer_loader.dart';
import 'package:danielabake/core/common/shimmer/shimmer_widgets.dart';
import 'package:danielabake/core/common/widgets/app_scaffold.dart';
import 'package:danielabake/core/common/widgets/button_widgets.dart';
import 'package:danielabake/features/Order_screen/widget/checkout_card.dart';
import 'package:danielabake/features/Order_screen/widget/simmer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';
import 'checkout2.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final OrderController controller = Get.put(OrderController());


  @override
  void initState() {
    super.initState();
    controller.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      removePadding: true,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        final cart = controller.cart.value;

        if (cart == null) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerLoader(
                  isLoading: true,
                  baseColor: Colors.orange.shade100,
                  highlightColor: Colors.orange.shade50,
                  child: Container(
                    width: double.infinity,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShimmerWidgets.buttonLoader(height: 64),
              ],
            ),
          );
        }

        if (cart.items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: const BoxDecoration(
            color: Color(0x2EFFB972),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    Text("\$${cart.total.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                    text: 'Continue',
                    onSimplePressed: () => Get.to(() => Checkout2Screen())),
              ],
            ),
          ),
        );
      }),

      body: Column(
        children: [
          // Cart Items Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
          child: Obx(() {
                final cart = controller.cart.value;
                if (cart == null) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (_, __) => const ShimmerCartItemCard(),
                  );
                }

                final cartItems = cart.items;

                if (cartItems.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CheckoutCard(cartItem: item);
                  },
                );
              }),
            ),
          ),

          // Container(
          //   decoration: BoxDecoration(
          //     color: Color(0x2EFFB972), // soft peach color like Figma
          //
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          //             Text("\$${controller.category.value!.total.toStringAsFixed(2)}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //
          //         PrimaryButton(text: 'Continue', onSimplePressed: ()=> Get.to(() => Checkout2Screen())),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
