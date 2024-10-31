import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Thanh toán')),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 2.0,
              ), //B
            ],
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/products/success.png'),
            const Text(
              'Thanh toán Hóa đơn thành công',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              '50.000 VND',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              '10:10-01-10-2024',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200)),
              child: const Column(
                children: [
                  InfoItemWidget(info: 'Mã giao dịch', value: '121212121121'),
                  InfoItemWidget(info: 'Tài khoản nhận', value: '1234567890'),
                  InfoItemWidget(info: 'Chủ tài khoản', value: 'Phạm Xuân Lõ'),
                  InfoItemWidget(info: 'Ngân hàng nhận', value: 'DP1'),
                  InfoItemWidget(info: 'Dịch vụ', value: 'TPP1'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Về Trang chủ',
              onPressed: () => context.goNamed(AppRoute.home.name),
            )
          ],
        ),
      ),
    );
  }
}

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({super.key, required this.info, required this.value});

  final String info;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              info,
              style: const TextStyle(color: Color(0xFF82869E), fontSize: 12),
            ),
            Text(value, style: const TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 5),
        Divider(color: Colors.grey.shade200),
      ],
    );
  }
}
