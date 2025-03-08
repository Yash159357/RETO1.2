import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_app/models/cart_models.dart';
import 'package:reto_app/controllers/shared_preference_controller.dart';
import 'package:reto_app/provider/shared_preference_provider.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) {
      // Change this to use the controller provider
      final controller = ref.watch(sharedPreferenceControllerProvider);
      return CartNotifier(controller);
    });

//StateNotifier will help us to keep track of CartNotifier data,i.e., the products we are moving to cart, the products we are removing from cart,etc. It keeps track by updating the UI accordingly.
class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  //It will keep track of String data and the type of datas we mentioned in our 'cart_models' page.
  final SharedPreferenceController _prefsHelper;

  CartNotifier(this._prefsHelper) : super(_prefsHelper.loadCartData());

  void _saveState() {
    _prefsHelper.saveCartData(state);
  }
  //Function to add products to cart

  void addProductToCart({
    //Datas which we want to access and use while adding to cart. (Same datas we have mentioned in 'cart_models' page.
    required String productName,

    required double productPrice,

    required String categoryName,

    required List imageUrl,

    required int
    quantity, //Number of quantities of product the customer want to buy

    required int
    instock, //Number of quantities of product are in stock for sell

    required String productId,

    required String productSize,

    required int discount,

    required String description,

    required String vendorId,
  }) {
    if (state.containsKey(
      productId,
    )) //If there is a product in cart. ('state' refers Current State of our CartNotifier)
    {
      state = {
        ...state, //Here we are basically adding the product itself based on the product id (product Id because it is unique for all products). We will be accessing all details of that product to be added based on its product Id.
        productId: CartModel(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          categoryName: state[productId]!.categoryName,
          imageUrl: state[productId]!.imageUrl,
          quantity:
              state[productId]!.quantity +
              1, //This if section means the product is already added in cart and then again if we press the product then it will increment the quantity by 1.
          instock: state[productId]!.instock,
          productId: state[productId]!.productId,
          productSize: state[productId]!.productSize,
          discount: state[productId]!.discount,
          description: state[productId]!.description,
          vendorId: state[productId]!.vendorId,
        ),
      };
    } else //This else section means the product has not been added to the cart before then we want to add it in the cart.
    {
      state = {
        ...state,
        productId: CartModel(
          productName: productName,
          productPrice: productPrice,
          categoryName: categoryName,
          imageUrl: imageUrl,
          quantity: quantity,
          instock: instock,
          productId: productId,
          productSize: productSize,
          discount: discount,
          description: description,
          vendorId: vendorId,
        ),
      };
    }
    _saveState();
  }

  //Function to Remove Item from Cart
  void removeItem(String productId) {
    state.remove(productId); //This will remove the Item from the state

    state = {...state}; //Notify listeners that the state has changed
    _saveState();
  }

  //Function to Increment Item Quantity in Cart
  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
    }

    //Notify listeners that the state has changed
    state = {...state};
    _saveState();
  }

  //Function to Decrement Item Quantity in Cart
  void decrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
    }

    //Notify listeners that the state has changed
    state = {...state};
    _saveState();
  }

  //Function to Calculate the Total Amount of Item Quantity present in Cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;

    state.forEach((productId, cartItem) {
      totalAmount +=
          cartItem.quantity *
          cartItem
              .discount; //MAIN CHANGE: We are actually considering Discount Price but in Cart Screen and Product Detail Screen we have shown the Original Product Price, we need to change it there to our Discount Price.
    });

    return totalAmount;
  }

  //NOT USING IT AS WE USED '.clear' option in 'checkOutScreen' page in Cash On Delivery Section inside '.whenComplete()' function.
  // //Function to Clear the Cart once the Order has been placed.
  // void clearCartData() {
  //   state.clear();
  //
  //   //Notify listeners that the state has changed
  //   state = {...state};
  // }

  Map<String, CartModel> get getCartItem => state;
}
