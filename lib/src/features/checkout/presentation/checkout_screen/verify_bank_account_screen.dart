import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyBankAccountScreen extends StatefulWidget {
  VerifyBankAccountScreen({super.key});

  @override
  State<VerifyBankAccountScreen> createState() =>
      _VerifyBankAccountScreenState();
}

class _VerifyBankAccountScreenState extends State<VerifyBankAccountScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = 'Thanh toán'.hardcoded;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ngân hàng'),
                          Text('DP1'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Số tài khoản'),
                          SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                    hintText: 'Nhập số thẻ',
                                    border: InputBorder.none),
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                controller: controller,
                                onChanged: (_) {
                                  setState(() {
                                    controller.text;
                                  });
                                },
                              )),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text(
                          'Sau khi bấm “Xác nhận” bạn sẽ nhận được thông báo yêu cầu xác nhận thanh toán từ ứng dụng DP1.\n\nĐiều kiện trước khi thanh toán\nĐã đăng ký dịch vụ Thanh toán trực tuyến. Bạn có thể đăng ký trực tuyến trên ứng dụng DP1 Mobile hoặc liên hệ tổng đài DP1 để được nhân viên hỗ trợ đăng ký\nSố dư tài khoản Ngân hàng tối thiểu là 50.000 VNĐ\n\nNgân hàng sẽ kiểm tra\nSố điện thoại và CCCD đăng ký trên TPP1 phải trùng với thông tin đã đăng ký với Ngân hàng'),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                text: 'Xác nhận',
                onPressed: controller.value.text.isNotEmpty
                    ? () => context.pushNamed(AppRoute.result.name)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
