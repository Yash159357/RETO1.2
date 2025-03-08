import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:reto_app/views/screens/main_screen.dart';
import 'package:reto_app/provider/cart_provider.dart';

class RazorPayPage extends ConsumerStatefulWidget {
  const RazorPayPage({Key? key, required this.amount}) : super(key: key);
  final double amount;

  @override
  ConsumerState<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends ConsumerState<RazorPayPage> {
  late Razorpay _razorpay;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.amount.toStringAsFixed(2),
    );
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
  }

  void openCheckout() {
    final paymentAmount = (widget.amount * 100).toInt();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': paymentAmount,
      'name': "Trial Name",
      'prefill': {'contact': "9876543210", 'email': 'trial@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Error: ${e.toString()}')),
        );
      }
    }
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Successful: ${response.paymentId}'),
        duration: const Duration(seconds: 1),
      ),
    );
    // Clear the cart using your provider's method.
    ref.read(cartProvider).clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void paymentFailure(PaymentFailureResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Failed: ${response.message ?? 'Unknown error'}'),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void externalWallet(ExternalWalletResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wallet Selected: ${response.walletName}'),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Razorpay Payment",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(210, 248, 186, 94),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: TextFormField(
            controller: _amountController,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(210, 248, 186, 94),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(210, 248, 186, 94),
                  width: 2.0,
                ),
              ),
              hintText: "Amount",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
              prefixIcon: Icon(
                Icons.currency_rupee_rounded,
                color: Colors.grey.shade600,
                size: 30,
              ),
            ),
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: Colors.grey.shade500, indent: 8, endIndent: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  if (widget.amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid amount provided')),
                    );
                    return;
                  }
                  openCheckout();
                },
                child: Container(
                  height: screenHeight * 0.065,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 12, top: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(210, 248, 186, 94),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(25),
                      right: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Pay ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          Icons.currency_rupee_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                        Text(
                          widget.amount.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
