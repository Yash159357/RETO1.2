import 'package:shared_preferences/shared_preferences.dart';
import 'package:reto_app/models/cart_models.dart';
import 'package:reto_app/models/favorite_models.dart';
import 'dart:convert';

class SharedPreferenceController {
  static const String _cartKey = 'cartData';
  static const String _favoriteKey = 'favoriteData';

  final SharedPreferences _prefs;

  SharedPreferenceController(this._prefs);

  Future<void> saveCartData(Map<String, CartModel> cartData) async {
    try {
      final cartJsonList = cartData.values.map((item) => jsonEncode(item.toJson())).toList();
      await _prefs.setStringList(_cartKey, cartJsonList);
    } catch (e) {
      print('Error saving cart data: $e');
    }
  }

  Map<String, CartModel> loadCartData() {
    try {
      final cartJsonList = _prefs.getStringList(_cartKey) ?? [];
      return cartJsonList.fold({}, (map, jsonString) {
        final item = CartModel.fromJson(jsonDecode(jsonString));
        return {...map, item.productId: item};
      });
    } catch (e) {
      print('Error loading cart data: $e');
      return {};
    }
  }
  // Favorite methods
  Future<void> saveFavoriteData(Map<String, FavoriteModel> favoriteData) async {
    try {
      final favoriteJsonList = favoriteData.values.map((item) => jsonEncode(item.toJson())).toList();
      await _prefs.setStringList(_favoriteKey, favoriteJsonList);
    } catch (e) {
      print('Error saving favorite data: $e');
    }
  }

  Map<String, FavoriteModel> loadFavoriteData() {
    try {
      final favoriteJsonList = _prefs.getStringList(_favoriteKey) ?? [];
      return favoriteJsonList.fold({}, (map, jsonString) {
        final item = FavoriteModel.fromJson(jsonDecode(jsonString));
        return {...map, item.productId: item};
      });
    } catch (e) {
      print('Error loading favorite data: $e');
      return {};
    }
  }
}