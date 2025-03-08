//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:reto_app/views/screens/inner_screens/shipping_address_screen.dart';
// import 'package:reto_app/views/screens/main_screen.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_app/provider/cart_provider.dart';
//
// class checkoutScreen extends ConsumerStatefulWidget {
//   const checkoutScreen({super.key});
//
//   @override
//   _checkoutScreenState createState() => _checkoutScreenState();
// }
//
// class _checkoutScreenState extends ConsumerState<checkoutScreen> {
//
//   String _selectedPaymentMethod = 'stripe'; //ONE OF THE MOST IMPORTANT VARIABLE. Default payment method, we can change it later.
//
//   bool isLoading = false;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   //Variables to get only these datas of current user from Firebase
//   String state = '';
//   String city = '';
//   String locality = '';
//   String pinCode = '';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getUserData();
//     super.initState();
//   }
//
//   //FUNCTION to get current user details
//   void getUserData() { //'DocumentSnapshot' because we are accessing only 1 document (Document of current user). If we are accessing multiple documents then we will use 'QuerySnapshot'.
//     Stream<DocumentSnapshot> userDataStream = _firestore.collection('customers').doc(_auth.currentUser!.uid).snapshots();
//
//     //Listen to the Stream and update the data
//     userDataStream.listen((DocumentSnapshot userData) {
//       if(userData.exists) {
//         setState(() {
//           state = userData.get('state');
//           city = userData.get('city');
//           locality = userData.get('locality');
//           pinCode = userData.get('pinCode');
//         });
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final cartProviderData = ref.read(cartProvider);
//
//
//     return Scaffold(
//
//
//       //PLACE YOUR ORDER BUTTON SECTION
//
//       appBar: AppBar(
//         title: Text(
//             'CheckOut'
//         ),
//       ),
//
//       //END OF PLACE YOUR ORDER BUTTON SECTION
//
//
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//
//               //Shipping Address Section
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return ShippingAddressScreen();
//                   }));
//                 },
//
//                 child: SizedBox(
//                   width: 335,
//                   height: 74,
//
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                           top: 0,
//                           left: 0,
//                           child: Container(
//                             width: 335,
//                             height: 74,
//                             clipBehavior: Clip.hardEdge,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Color(0xFFEFF0F2,),),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                       ),
//
//                       Positioned(
//                           left: 70,
//                           top: 17,
//                           child: SizedBox(
//                             width: 215,
//                             height: 41,
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Positioned(
//                                     left: -1,
//                                     top: -1,
//                                     child: SizedBox(
//                                       width: 219,
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Text(
//                                               'Add Address',
//                                               style: GoogleFonts.lato(
//                                                 fontSize: 14,
//                                                 // letterSpacing: 1,
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w600,
//                                                 height: 1.4,
//                                               ),
//                                             ),
//                                           ),
//
//                                           const SizedBox(height: 5,),
//
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Text(
//                                               'Enter City',
//                                               style: GoogleFonts.lato(
//                                                 fontSize: 12,
//                                                 // letterSpacing: 1,
//                                                 color: Color(0xFF7F808C),
//                                                 fontWeight: FontWeight.w600,
//                                                 height: 1.4,
//                                               ),
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ),
//
//                       Positioned(
//                           left: 16,
//                           top: 16,
//                           child: SizedBox.square(
//                             dimension: 42, //Length of each side of the Square Sized Box
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 43,
//                                       height: 43,
//                                       clipBehavior: Clip.hardEdge,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xFFFBF7F5),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Stack(
//                                         clipBehavior: Clip.hardEdge,
//                                         children: [
//                                           Positioned(
//                                               left: 11,
//                                               top: 11,
//                                               child: Image.asset('assets/icons/location.png', //LOCATION ICON
//                                                 width: 20,
//                                                 height: 20,
//                                               ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ),
//
//                       Positioned(
//                           left: 305,
//                           top: 25,
//                           child: Image.asset('assets/icons/edit2.png', //EDIT ICON
//                             width: 20,
//                             height: 20,
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//
//
//               const SizedBox(height: 15,),
//
//
//               const Text(
//                 'Your Item(s)',
//                 style: TextStyle(
//                   fontSize: 18,
//                   // letterSpacing: 1,
//                   // color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//
//               const SizedBox(height: 15,),
//
//
//               //START OF SECTION WHERE OUR ITEMS WILL BE DISPLAYED FOR CHECKOUT.
//               Flexible( //It will make the Item Flexible according to the space available to it.
//                 child: ListView.builder(
//                     itemCount: cartProviderData.length,
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//
//                     itemBuilder: (context, index) {
//                       final cartItem = cartProviderData.values.toList()[index];
//
//                       return InkWell(
//                         onTap: () {},
//
//                         child: Container(
//                           width: 336,
//                           height: 91,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: Color(0xFFEFF0F2,),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Positioned(
//                                   left: 6,
//                                   top: 6,
//                                   child: SizedBox(
//                                     width: 311,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: 78,
//                                           height: 78,
//                                           clipBehavior: Clip.hardEdge,
//                                           decoration: const BoxDecoration(
//                                             color: Color(0xFFBCC5FF,),
//                                           ),
//
//                                           //Item Image
//                                           child: Image.network(
//                                             cartItem.imageUrl[0],
//                                           ),
//
//                                         ),
//
//                                         //Giving Space Horizontally
//                                         const SizedBox(width: 11,),
//
//                                         Expanded(child: Container(
//                                           height: 78,
//                                           alignment: const Alignment(0, -0.51),
//
//                                           child: SizedBox(
//                                             width: double.infinity,
//                                             child: Column(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               mainAxisSize: MainAxisSize.min,
//
//                                               children: [
//                                                 SizedBox(
//                                                   width: double.infinity,
//
//                                                   //Name of Item Text
//                                                   child: Text(
//                                                     cartItem.productName,
//                                                     style: GoogleFonts.lato(
//                                                       // fontSize: 18,
//                                                       // letterSpacing: 1,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.w500,
//                                                       height: 1.4,
//                                                     ),
//                                                   ),
//                                                 ),
//
//                                                 //Giving Space Horizontally
//                                                 const SizedBox(width: 4,),
//
//                                                 Align(
//                                                   alignment: Alignment.centerLeft,
//
//                                                   //Category of Item Text
//                                                   child: Text(
//                                                     cartItem.categoryName,
//                                                     style: const TextStyle(
//                                                       fontSize: 12,
//                                                       // letterSpacing: 1,
//                                                       color: Colors.blueGrey,
//                                                       fontWeight: FontWeight.w400,
//                                                       // height: 1.4,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//
//                                         ),
//                                       ),
//
//                                         //Giving Space Horizontally
//                                         const SizedBox(width: 16,),
//
//                                         //Price of Item Text
//                                         Text(
//                                           '\₹${cartItem.discount.toStringAsFixed(2,)}',
//                                           style: GoogleFonts.lato(
//                                             fontSize: 14,
//                                             // letterSpacing: 1,
//                                             color: Colors.pink,
//                                             fontWeight: FontWeight.bold,
//                                             height: 1.4,
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                 ),
//               ),
//
//               const SizedBox(height: 30,),
//
//
//
//               //
//               //PAYMENT OPTION SECTION
//               //
//               const Text(
//                 'Choose Payment Method',
//                 style: TextStyle(
//                   fontSize: 18,
//                   // letterSpacing: 1,
//                   // color: Colors.pink,
//                   fontWeight: FontWeight.bold,
//                   // height: 1.4,
//                 ),
//               ),
//
//
//               //Radio List Tile will enable us to make and choose options.
//               //Option to choose Stripe that is Online Payment as an Option
//               RadioListTile<String>(
//                   title: const Text('Stripe'),
//                   value: 'stripe',      //On default it is selected as Stripe as in the beginning at the top we made '_selectedPaymentMethod' as 'stripe' only when we defined it.
//                   groupValue: _selectedPaymentMethod,
//                   onChanged: (String? value) {
//                     setState(() {
//                       _selectedPaymentMethod = value!;
//                     });
//                   },
//               ),
//
//               //Option to choose Cash on Delivery as an Option.
//               RadioListTile<String>(
//                 title: const Text('Cash on Delivery'),
//                 value: 'cashOnDelivery',
//                 groupValue: _selectedPaymentMethod,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedPaymentMethod = value!;
//                   });
//                 },
//               ),
//
//               //
//               //END OF PAYMENT OPTION SECTION
//               //
//
//
//
//             ],
//           ),
//         ),
//       ),
//
//
//       //PLACE YOUR ORDER BUTTON SECTION
//       bottomSheet: state == "" ? Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: TextButton( //'state' means the Address State where our Customer lives in. This line will basically check whether the user has added address or not by checking the 'state' value in the Firebase (we can check 'city','locality' or 'pinCode' as well). If it is empty then the user will run the Text Button Widget where he/she will have to add the address before checking out.
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const ShippingAddressScreen();
//               }));
//             },
//             child: const Text('Add Address'),),
//       )
//           : Padding( //This means the customer has added his/her address and can move forward to checking out
//         padding: const EdgeInsets.all(25.0),
//         child: InkWell(
//
//           onTap: () async{
//             if(_selectedPaymentMethod == 'stripe') //If our Payment Method is 'stripe' i.e., Online Payment
//               {
//                 //Pay With Stripe
//
//               }
//             else //This else part simply means our Payment Method is Cash on Delivery
//               {
//
//                 setState(() { //Starting the Loading part till our function is not completed
//                   isLoading = true; //DESIGN OF OUR LOADING IS DONE AT THE 'PLACE YOUR ORDER' TEXT SECTION
//                 });
//
//                 for(var item in ref.read(cartProvider.notifier).getCartItem.values)
//                   {
//
//                     //Accessing the details of the current logged in user
//                     DocumentSnapshot userDoc = await _firestore.collection('customers').doc(_auth.currentUser!.uid).get();
//
//
//                     //Creating a collection in our Firebase where the order details will be stored.
//                     CollectionReference orderRefer = _firestore.collection('orders');
//
//                     final orderId = const Uuid().v4(); //This will create an unique id for each created order.
//                     await orderRefer.doc(orderId).set({ //Here we will create the fields which will be stored in our Firebase.
//                       'orderId' : orderId,
//                       'productName' : item.productName,
//                       'productId' : item.productId,
//                       'size' : item.productSize,
//                       'quantity' : item.quantity,
//                       'price' : item.quantity * item.discount, //Here 'discount' is mentioned because that discounted price is the price that the customer will pay for the product.
//                       'category' : item.categoryName,
//                       'productImage' : item.imageUrl[0], //Saving only the first image of the product.
//                       'name' : (userDoc.data() as Map<String, dynamic>)['name'], //Name of the Customer
//                       'email' : (userDoc.data() as Map<String, dynamic>)['email'], //Email of the Customer
//                       'number' : (userDoc.data() as Map<String, dynamic>)['number'], //Contact Number of the Customer
//                       // 'customerId' : (userDoc.data() as Map<String, dynamic>)['uid'], //Customer Id of the Customer
//                       'customerId' : _auth.currentUser!.uid, //By this also we can get the Customer Id of the Customer
//                       'state' : (userDoc.data() as Map<String, dynamic>)['state'], //Name of the State where our Customer is from
//                       'city' : (userDoc.data() as Map<String, dynamic>)['city'],
//                       'locality' : (userDoc.data() as Map<String, dynamic>)['locality'],
//                       'pinCode' : (userDoc.data() as Map<String, dynamic>)['pinCode'],
//                       'deliveredCount' : 0,
//                       'delivered' : false, //Current status which denotes whether the item has been delivered or not.
//                       'processing' : true,  //Whether the order is in Processing or not.
//                       'vendorId' : item.vendorId,
//                     }).whenComplete((){ //What will happen when our the above function is completed and this basically means that the ORDER HAS BEEN PLACED
//
//                       cartProviderData.clear(); //'whenComplete' simply means our order has been placed and hence when the order has been placed we are clearing the entire cart.
//
//                       //'Navigator.push' means we can go back to the previous screen but 'Navigator.pushReplacement' means we cannot go back to the previous screen and we are doing this because once our order has been placed we are redirected to Home Screen and we don't want to go back to our Checkout Screen.
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//                         return MainScreen();
//                       }));
//
//                       setState(() {
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                           backgroundColor: Colors.grey, //Background color of our SnackBar
//                           content: Text('Order Have Been Placed',),),);
//
//
//                         isLoading = false;  //Stopping our Loading when our function is completed
//                       });
//                     });
//                   }
//               } //END OF CASH ON DELIVERY SECTION
//           },
//
//
//           child: Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width -50,
//
//             decoration: BoxDecoration(
//               color: const Color(0xFF1532E7),
//               borderRadius: BorderRadius.circular(15),
//             ),
//
//             child: Center(
//               child: isLoading ? const CircularProgressIndicator(color: Colors.white,) //If our 'isLoading' is true then starting our Circular Progress Bar and if false then showing the Text
//                   : const Text(
//                 'PLACE YOUR ORDER',
//                 style: TextStyle(
//                   fontSize: 17,
//                   // letterSpacing: 1,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//
//           ),
//         ),
//
//       ), //END OF PLACE YOUR ORDER BUTTON SECTION
//
//     );
//   }
// }

//
//1st CODE
//

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:reto_app/views/screens/inner_screens/shipping_address_screen.dart';
// import 'package:reto_app/views/screens/main_screen.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_app/provider/cart_provider.dart';
//
// class checkoutScreen extends ConsumerStatefulWidget {
//   const checkoutScreen({super.key});
//
//   @override
//   _checkoutScreenState createState() => _checkoutScreenState();
// }
//
// class _checkoutScreenState extends ConsumerState<checkoutScreen> {
//   String _selectedPaymentMethod =
//       'stripe'; //ONE OF THE MOST IMPORTANT VARIABLE. Default payment method, we can change it later.
//
//   bool isLoading = false;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   //Variables to get only these datas of current user from Firebase
//   String state = '';
//   String city = '';
//   String locality = '';
//   String pinCode = '';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getUserData();
//     super.initState();
//   }
//
//   //FUNCTION to get current user details
//   void getUserData() {
//     //'DocumentSnapshot' because we are accessing only 1 document (Document of current user). If we are accessing multiple documents then we will use 'QuerySnapshot'.
//     Stream<DocumentSnapshot> userDataStream =
//     _firestore
//         .collection('customers')
//         .doc(_auth.currentUser!.uid)
//         .snapshots();
//
//     //Listen to the Stream and update the data
//     userDataStream.listen((DocumentSnapshot userData) {
//       if (userData.exists) {
//         setState(() {
//           state = userData.get('state');
//           city = userData.get('city');
//           locality = userData.get('locality');
//           pinCode = userData.get('pinCode');
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProviderData = ref.read(cartProvider);
//
//     return Scaffold(
//       //PLACE YOUR ORDER BUTTON SECTION
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         title: Text(
//           'CheckOut',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, size: 28, weight: 1000),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 250, 225, 188),
//       //END OF PLACE YOUR ORDER BUTTON SECTION
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //Shipping Address Section
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return ShippingAddressScreen();
//                       },
//                     ),
//                   );
//                 },
//
//                 child: SizedBox(
//                   width: 335,
//                   height: 74,
//
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Container(
//                           width: 335,
//                           height: 74,
//                           clipBehavior: Clip.hardEdge,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 255, 246, 233),
//                             border: Border.all(color: Color(0xFFEFF0F2)),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         left: 70,
//                         top: 17,
//                         child: SizedBox(
//                           width: 215,
//                           height: 41,
//                           child: Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Positioned(
//                                 left: -1,
//                                 top: -1,
//                                 child: SizedBox(
//                                   width: 219,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           'Add Address',
//                                           style: GoogleFonts.lato(
//                                             fontSize: 14,
//                                             // letterSpacing: 1,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.w600,
//                                             height: 1.4,
//                                           ),
//                                         ),
//                                       ),
//
//                                       const SizedBox(height: 5),
//
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           'Enter City',
//                                           style: GoogleFonts.lato(
//                                             fontSize: 12,
//                                             // letterSpacing: 1,
//                                             color: Color(0xFF7F808C),
//                                             fontWeight: FontWeight.w600,
//                                             height: 1.4,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         left: 16,
//                         top: 16,
//                         child: SizedBox.square(
//                           dimension:
//                           42, //Length of each side of the Square Sized Box
//                           child: Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Positioned(
//                                 left: 0,
//                                 top: 0,
//                                 child: Container(
//                                   width: 43,
//                                   height: 43,
//                                   clipBehavior: Clip.hardEdge,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFFBF7F5),
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   child: Stack(
//                                     clipBehavior: Clip.hardEdge,
//                                     children: [
//                                       Positioned(
//                                         left: 11,
//                                         top: 11,
//                                         child: Image.asset(
//                                           'assets/icons/location.png', //LOCATION ICON
//                                           width: 20,
//                                           height: 20,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         left: 305,
//                         top: 25,
//                         child: Image.asset(
//                           'assets/icons/edit2.png', //EDIT ICON
//                           width: 20,
//                           height: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 15),
//
//               const Text(
//                 'Your Item(s)',
//                 style: TextStyle(
//                   fontSize: 20,
//                   // letterSpacing: 1,
//                   // color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//
//               const SizedBox(height: 15),
//
//               //START OF SECTION WHERE OUR ITEMS WILL BE DISPLAYED FOR CHECKOUT.
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.withAlpha(150)),
//                   borderRadius: BorderRadius.circular(20),
//                   color: Color.fromARGB(255, 255, 246, 233),
//                 ),
//                 padding: EdgeInsets.all(8),
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   itemBuilder: (context, index) {
//
//                     final cartItem = cartProviderData.values.toList()[index];
//
//                     return InkWell(
//                       onTap: () {},
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Container(
//                                 width: 70,
//                                 height: 70,
//                                 clipBehavior: Clip.hardEdge,
//                                 decoration: const BoxDecoration(
//                                   color: Color(0xFFBCC5FF),
//                                 ),
//                                 //Item Image
//                                 child: Image.network(
//                                   cartItem.imageUrl[0],
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 6),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Spacer(),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   cartItem.productName,
//                                   style: TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//
//                                 Text(
//                                   cartItem.categoryName,
//                                   style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ), // Spacer(flex: 2),
//                               ],
//                             ),
//                             Spacer(),
//                             Column(
//                               children: [
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "₹${cartItem.discount.toStringAsFixed(2)}",
//                                   style: TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       color: Colors.grey.shade300,
//                       indent: 5,
//                       endIndent: 5,
//                     );
//                   },
//                   itemCount: cartProviderData.length,
//                 ),
//               ),
//
//               // Flexible(
//               //It will make the Item Flexible according to the space available to it.
//               //   child: ListView.builder(
//               //     itemCount: cartProviderData.length,
//               //     shrinkWrap: true,
//               //     physics: ScrollPhysics(),
//
//               //     itemBuilder: (context, index) {
//               //       final cartItem = cartProviderData.values.toList()[index];
//
//               //       return InkWell(
//               //         onTap: () {},
//
//               //         child: Container(
//               //           width: 336,
//               //           height: 91,
//               //           decoration: BoxDecoration(
//               //             color: Colors.white,
//               //             border: Border.all(color: Color(0xFFEFF0F2)),
//               //             borderRadius: BorderRadius.circular(12),
//               //           ),
//               //           child: Stack(
//               //             clipBehavior: Clip.none,
//               //             children: [
//               //               Positioned(
//               //                 left: 6,
//               //                 top: 6,
//               //                 child: SizedBox(
//               //                   width: 311,
//               //                   child: Row(
//               //                     mainAxisAlignment:
//               //                         MainAxisAlignment.spaceBetween,
//               //                     children: [
//               //                       ClipRRect(
//               //                         borderRadius: BorderRadius.circular(8),
//               //                         child: Container(
//               //                           width: 78,
//               //                           height: 78,
//               //                           clipBehavior: Clip.hardEdge,
//               //                           decoration: const BoxDecoration(
//               //                             color: Color(0xFFBCC5FF),
//               //                           ),
//
//               //                           //Item Image
//               //                           child: Image.network(
//               //                             cartItem.imageUrl[0],
//               //                           ),
//               //                         ),
//               //                       ),
//
//               //                       //Giving Space Horizontally
//               //                       const SizedBox(width: 11),
//
//               //                       Expanded(
//               //                         child: Container(
//               //                           height: 78,
//               //                           alignment: const Alignment(0, -0.51),
//
//               //                           child: SizedBox(
//               //                             width: double.infinity,
//               //                             child: Column(
//               //                               mainAxisAlignment:
//               //                                   MainAxisAlignment.spaceBetween,
//               //                               mainAxisSize: MainAxisSize.min,
//
//               //                               children: [
//               //                                 SizedBox(
//               //                                   width: double.infinity,
//
//               //                                   //Name of Item Text
//               //                                   child: Text(
//               //                                     cartItem.productName,
//               //                                     style: GoogleFonts.lato(
//               //                                       // fontSize: 18,
//               //                                       // letterSpacing: 1,
//               //                                       color: Colors.black,
//               //                                       fontWeight: FontWeight.w500,
//               //                                       height: 1.4,
//               //                                     ),
//               //                                   ),
//               //                                 ),
//
//               //                                 //Giving Space Horizontally
//               //                                 const SizedBox(width: 4),
//
//               //                                 Align(
//               //                                   alignment: Alignment.centerLeft,
//
//               //                                   //Category of Item Text
//               //                                   child: Text(
//               //                                     cartItem.categoryName,
//               //                                     style: const TextStyle(
//               //                                       fontSize: 12,
//               //                                       // letterSpacing: 1,
//               //                                       color: Colors.blueGrey,
//               //                                       fontWeight: FontWeight.w400,
//               //                                       // height: 1.4,
//               //                                     ),
//               //                                   ),
//               //                                 ),
//               //                               ],
//               //                             ),
//               //                           ),
//               //                         ),
//               //                       ),
//
//               //                       //Giving Space Horizontally
//               //                       const SizedBox(width: 16),
//
//               //                       //Price of Item Text
//               //                       Text(
//               //                         '\₹${cartItem.discount.toStringAsFixed(2)}',
//               //                         style: GoogleFonts.lato(
//               //                           fontSize: 14,
//               //                           // letterSpacing: 1,
//               //                           color: Colors.pink,
//               //                           fontWeight: FontWeight.bold,
//               //                           height: 1.4,
//               //                         ),
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 ),
//               //               ),
//               //             ],
//               //           ),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),
//               const SizedBox(height: 30),
//
//               //
//               //PAYMENT OPTION SECTION
//               //
//               const Text(
//                 'Choose Payment Method',
//                 style: TextStyle(
//                   fontSize: 18,
//                   // letterSpacing: 1,
//                   // color: Colors.pink,
//                   fontWeight: FontWeight.bold,
//                   // height: 1.4,
//                 ),
//               ),
//
//               //Radio List Tile will enable us to make and choose options.
//               //Option to choose Stripe that is Online Payment as an Option
//               RadioListTile<String>(
//                 title: const Text('Stripe'),
//                 value:
//                 'stripe', //On default it is selected as Stripe as in the beginning at the top we made '_selectedPaymentMethod' as 'stripe' only when we defined it.
//                 groupValue: _selectedPaymentMethod,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedPaymentMethod = value!;
//                   });
//                 },
//               ),
//
//               //Option to choose Cash on Delivery as an Option.
//               RadioListTile<String>(
//                 title: const Text('Cash on Delivery'),
//                 value: 'cashOnDelivery',
//                 groupValue: _selectedPaymentMethod,
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedPaymentMethod = value!;
//                   });
//                 },
//               ),
//
//               //
//               //END OF PAYMENT OPTION SECTION
//               //
//             ],
//           ),
//         ),
//       ),
//
//       //PLACE YOUR ORDER BUTTON SECTION
//       bottomSheet:
//       state == ""
//           ? Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: TextButton(
//           //'state' means the Address State where our Customer lives in. This line will basically check whether the user has added address or not by checking the 'state' value in the Firebase (we can check 'city','locality' or 'pinCode' as well). If it is empty then the user will run the Text Button Widget where he/she will have to add the address before checking out.
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return const ShippingAddressScreen();
//                 },
//               ),
//             );
//           },
//           child: const Text('Add Address'),
//         ),
//       )
//           : Padding(
//         //This means the customer has added his/her address and can move forward to checking out
//         padding: const EdgeInsets.all(25.0),
//         child: InkWell(
//           onTap: () async {
//             if (_selectedPaymentMethod ==
//                 'stripe') //If our Payment Method is 'stripe' i.e., Online Payment
//                 {
//               //Pay With Stripe
//             } else //This else part simply means our Payment Method is Cash on Delivery
//                 {
//               setState(() {
//                 //Starting the Loading part till our function is not completed
//                 isLoading =
//                 true; //DESIGN OF OUR LOADING IS DONE AT THE 'PLACE YOUR ORDER' TEXT SECTION
//               });
//
//               for (var item
//               in ref
//                   .read(cartProvider.notifier)
//                   .getCartItem
//                   .values) {
//                 //Accessing the details of the current logged in user
//                 DocumentSnapshot userDoc =
//                 await _firestore
//                     .collection('customers')
//                     .doc(_auth.currentUser!.uid)
//                     .get();
//
//                 //Creating a collection in our Firebase where the order details will be stored.
//                 CollectionReference orderRefer = _firestore.collection(
//                   'orders',
//                 );
//
//                 final orderId =
//                 const Uuid()
//                     .v4(); //This will create an unique id for each created order.
//                 await orderRefer
//                     .doc(orderId)
//                     .set({
//                   //Here we will create the fields which will be stored in our Firebase.
//                   'orderId': orderId,
//                   'productName': item.productName,
//                   'productId': item.productId,
//                   'size': item.productSize,
//                   'quantity': item.quantity,
//                   'price':
//                   item.quantity *
//                       item.discount, //Here 'discount' is mentioned because that discounted price is the price that the customer will pay for the product.
//                   'category': item.categoryName,
//                   'productImage':
//                   item.imageUrl[0], //Saving only the first image of the product.
//                   'name':
//                   (userDoc.data()
//                   as Map<
//                       String,
//                       dynamic
//                   >)['name'], //Name of the Customer
//                   'email':
//                   (userDoc.data()
//                   as Map<
//                       String,
//                       dynamic
//                   >)['email'], //Email of the Customer
//                   'number':
//                   (userDoc.data()
//                   as Map<
//                       String,
//                       dynamic
//                   >)['number'], //Contact Number of the Customer
//                   // 'customerId' : (userDoc.data() as Map<String, dynamic>)['uid'], //Customer Id of the Customer
//                   'customerId':
//                   _auth
//                       .currentUser!
//                       .uid, //By this also we can get the Customer Id of the Customer
//                   'state':
//                   (userDoc.data()
//                   as Map<
//                       String,
//                       dynamic
//                   >)['state'], //Name of the State where our Customer is from
//                   'city':
//                   (userDoc.data()
//                   as Map<String, dynamic>)['city'],
//                   'locality':
//                   (userDoc.data()
//                   as Map<String, dynamic>)['locality'],
//                   'pinCode':
//                   (userDoc.data()
//                   as Map<String, dynamic>)['pinCode'],
//                   'deliveredCount': 0,
//                   'delivered':
//                   false, //Current status which denotes whether the item has been delivered or not.
//                   'processing':
//                   true, //Whether the order is in Processing or not.
//                   'vendorId': item.vendorId,
//                 })
//                     .whenComplete(() {
//                   //What will happen when our the above function is completed and this basically means that the ORDER HAS BEEN PLACED
//
//                   cartProviderData
//                       .clear(); //'whenComplete' simply means our order has been placed and hence when the order has been placed we are clearing the entire cart.
//
//                   //'Navigator.push' means we can go back to the previous screen but 'Navigator.pushReplacement' means we cannot go back to the previous screen and we are doing this because once our order has been placed we are redirected to Home Screen and we don't want to go back to our Checkout Screen.
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return MainScreen();
//                       },
//                     ),
//                   );
//
//                   setState(() {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         backgroundColor:
//                         Colors
//                             .grey, //Background color of our SnackBar
//                         content: Text('Order Have Been Placed'),
//                       ),
//                     );
//
//                     isLoading =
//                     false; //Stopping our Loading when our function is completed
//                   });
//                 });
//               }
//             } //END OF CASH ON DELIVERY SECTION
//           },
//
//           child: Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width - 50,
//
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(210, 248, 186, 94),
//               borderRadius: BorderRadius.circular(15),
//             ),
//
//             child: Center(
//               child:
//               isLoading
//                   ? const CircularProgressIndicator(
//                 color: Colors.white,
//               ) //If our 'isLoading' is true then starting our Circular Progress Bar and if false then showing the Text
//                   : const Text(
//                 'PLACE YOUR ORDER',
//                 style: TextStyle(
//                   fontSize: 17,
//                   // letterSpacing: 1,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ), //END OF PLACE YOUR ORDER BUTTON SECTION
//     );
//   }
// }

//
//NEW CODE
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_app/provider/cart_provider.dart';
import 'package:reto_app/views/screens/inner_screens/payement_screen.dart';
import 'package:reto_app/views/screens/inner_screens/shipping_address_screen.dart';
import 'package:reto_app/views/screens/main_screen.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'stripe';
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String state = '';
  String city = '';
  String locality = '';
  String pinCode = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    Stream<DocumentSnapshot> userDataStream =
        _firestore
            .collection('customers')
            .doc(_auth.currentUser!.uid)
            .snapshots();

    userDataStream.listen((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          state = userData.get('state');
          city = userData.get('city');
          locality = userData.get('locality');
          pinCode = userData.get('pinCode');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'CheckOut',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 28, weight: 1000),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 225, 188),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Shipping Address Section
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShippingAddressScreen(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 335,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 335,
                          height: 74,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 246, 233),
                            border: Border.all(color: const Color(0xFFEFF0F2)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                top: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Add Address',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Enter City',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xFF7F808C),
                                            fontWeight: FontWeight.w600,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBF7F5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.asset(
                                          'assets/icons/location.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 25,
                        child: Image.asset(
                          'assets/icons/edit2.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Your Item(s)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 15),
              // Items List Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withAlpha(150)),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 246, 233),
                ),
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cartItem = cartProviderData.values.toList()[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 70,
                                height: 70,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBCC5FF),
                                ),
                                child: Image.network(
                                  cartItem.imageUrl[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  cartItem.productName,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  cartItem.categoryName,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "₹${cartItem.discount.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.shade300,
                      indent: 5,
                      endIndent: 5,
                    );
                  },
                  itemCount: cartProviderData.length,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Price: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${widget.totalPrice.toString()}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Payment Options Section
              Divider(color: Colors.black12),
              const SizedBox(height: 12),

              const Text(
                'Choose Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              RadioListTile<String>(
                title: const Text('Stripe'),
                value: 'stripe',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Cash on Delivery'),
                value: 'cashOnDelivery',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      // Place Order Button Section
      bottomSheet:
          state == ""
              ? Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen(),
                      ),
                    );
                  },
                  child: const Text('Add Address'),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(25.0),
                child: InkWell(
                  onTap: () async {
                    if (_selectedPaymentMethod == 'stripe') {
                      // Pay With Stripe
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RazorPayPage(amount: widget.totalPrice);
                          },
                        ),
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });

                      final cartItems =
                          ref
                              .read(cartProvider.notifier)
                              .getCartItem
                              .values
                              .toList();
                      final userDoc =
                          await _firestore
                              .collection('customers')
                              .doc(_auth.currentUser!.uid)
                              .get();

                      final CollectionReference orderRefer = _firestore
                          .collection('orders');
                      final batch = _firestore.batch();

                      for (var item in cartItems) {
                        final orderId = const Uuid().v4();
                        final orderRef = orderRefer.doc(orderId);

                        batch.set(orderRef, {
                          'orderId': orderId,
                          'productName': item.productName,
                          'productId': item.productId,
                          'size': item.productSize,
                          'quantity': item.quantity,
                          'price': item.quantity * item.discount,
                          'category': item.categoryName,
                          'productImage': item.imageUrl[0],
                          'name': userDoc.get('name'),
                          'email': userDoc.get('email'),
                          'number': userDoc.get('number'),
                          'customerId': _auth.currentUser!.uid,
                          'state': userDoc.get('state'),
                          'city': userDoc.get('city'),
                          'locality': userDoc.get('locality'),
                          'pinCode': userDoc.get('pinCode'),
                          'deliveredCount': 0,
                          'delivered': false,
                          'processing': true,
                          'vendorId': item.vendorId,
                        });
                      }

                      await batch.commit().whenComplete(() {
                        ref.read(cartProvider.notifier).getCartItem.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );

                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.grey,
                              content: Text('Order Has Been Placed'),
                            ),
                          );
                          isLoading = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(210, 248, 186, 94),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'PLACE YOUR ORDER',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
    );
  }
}
