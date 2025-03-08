// //Almost similar to our 'cart_provider' page
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reto_app/models/favorite_models.dart';
// import 'package:reto_app/views/screens/nav_screens/favourite_screen.dart';
//
//
// final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Map <String,FavoriteModel>> ( //This will make our 'FavoriteNotifier' class generally accessible throughout our entire app.
//       (ref) {
//     return FavoriteNotifier();
//   },
// );
//
//
// class FavoriteNotifier extends StateNotifier<Map <String,FavoriteModel>> {
//   FavoriteNotifier(): super({});
//
//   //Function to Add Products to Favorite
//   void addProductToFavorite({
//     required String productName,  //Parameters which has to be passed compulsorily for adding to Favorite (Wishlist) Page.
//     required String productId,
//     required List imageUrl,
//     required int productPrice,
//   }) {
//     state[productId] = FavoriteModel(
//         productName: productName,
//         productPrice: productPrice,
//         imageUrl: imageUrl,
//         productId: productId);
//
//     //Notify listeners that the state has changed
//     state = {...state};
//   }
//
//   //Function to Remove all Products from Favorite
//   void removeAllItem(){
//     state.clear();
//
//     //Notify listeners that the state has changed
//     state = {...state};
//   }
//
//   //Function to Remove a particular Product from Favorite
//   void removeItem(String productId){
//     state.remove(productId);
//
//     //Notify listeners that the state has changed
//     state = {...state};
//   }
//
//   //Retrieve Value from the state object
//   Map<String, FavoriteModel> get getFavoriteItem => state;
//
// }

//Almost similar to our 'cart_provider' page

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_app/models/favorite_models.dart';
import 'package:reto_app/provider/shared_preference_provider.dart';
import 'package:reto_app/controllers/shared_preference_controller.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModel>>((ref) {
      // Use the controller provider directly
      final controller = ref.watch(sharedPreferenceControllerProvider);
      return FavoriteNotifier(controller);
    });

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModel>> {
  final SharedPreferenceController _prefsController;

  FavoriteNotifier(this._prefsController)
    : super(_prefsController.loadFavoriteData());

  void _saveState() {
    _prefsController.saveFavoriteData(state);
  }

  //Function to Add Products to Favorite
  void addProductToFavorite({
    required String
    productName, //Parameters which has to be passed compulsorily for adding to Favorite (Wishlist) Page.
    required String productId,
    required List imageUrl,
    required int productPrice,
  }) {
    state[productId] = FavoriteModel(
      productName: productName,
      productPrice: productPrice,
      imageUrl: imageUrl,
      productId: productId,
    );

    //Notify listeners that the state has changed
    state = {...state};
    _saveState();
  }

  //Function to Remove all Products from Favorite
  void removeAllItem() {
    state.clear();

    //Notify listeners that the state has changed
    state = {...state};
    _saveState();
  }

  //Function to Remove a particular Product from Favorite
  void removeItem(String productId) {
    state.remove(productId);

    //Notify listeners that the state has changed
    state = {...state};
    _saveState();
  }

  void removeProductFromFavorite(String productId) {
    state = {...state..remove(productId)};
    _saveState();
  }

  //Retrieve Value from the state object
  Map<String, FavoriteModel> get getFavoriteItem => state;
}
