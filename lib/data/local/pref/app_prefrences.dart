// import 'dart:async' show Future;
import 'package:realorfake/ui/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? prefsInstance;

  AppPreferences._internal();

  static Future<SharedPreferences> init() async {
    prefsInstance = await SharedPreferences.getInstance();
    return prefsInstance!;
  }

  static Future<dynamic> get(String key, dynamic defValue) async {
    if (defValue is int) {
      return prefsInstance?.getInt(key) ?? defValue;
    } else if (defValue is double) {
      return prefsInstance?.getDouble(key) ?? defValue;
    } else if (defValue is bool) {
      return prefsInstance?.getBool(key) ?? defValue;
    } else {
      return prefsInstance?.getString(key) ?? defValue ?? "";
    }
  }

  static Future<bool> put(String key, dynamic value) async {
    var prefs = await init();
    if (value is int) {
      return prefs
          .setInt(key, value)
          .onError((error, stackTrace) => Future.value(false));
    } else if (value is bool) {
      return prefs
          .setBool(key, value)
          .onError((error, stackTrace) => Future.value(false));
    } else if (value is double) {
      return prefs
          .setDouble(key, value)
          .onError((error, stackTrace) => Future.value(false));
    } else {
      return prefs
          .setString(key, value.toString())
          .onError((error, stackTrace) => Future.value(false));
    }
  }

  // static Future<bool> isUserLogin() async {
  //   var isLogin =
  //       await get(AppStrings.instance.isUserLogin, false).then((value) {
  //     return value;
  //   }).onError((error, stackTrace) {
  //     return false;
  //   });
  //   return isLogin;
  // }

  // static Future<OTPModel?> getCustomerDetails() async {
  //   OTPModel? obj = OTPModel.fromJson(jsonDecode(
  //       await AppPreferences.get(AppStrings.instance.customerDetails, "")));
  //   return obj;
  // }

  // static Future<List<SearchModel>> getRecentSearch() async {
  //   String recent = await get("recentSearched", "");
  //   if (recent.isNotEmpty) {
  //     List<dynamic> jsonList = jsonDecode(recent);
  //     return jsonList.map((json) => SearchModel.fromJson(json)).toList();
  //   } else {
  //     return [];
  //   }
  // }

  // static Future<void> saveRecentSearch(SearchModel obj) async {
  //   try {
  //     List<SearchModel> mList = await AppPreferences.getRecentSearch();
  //     bool isExists = mList.any((objEle) => objEle.itemId == obj.itemId);
  //     if (!isExists) {
  //       mList.add(obj);
  //     }
  //     String productJson =
  //         jsonEncode(mList.map((product) => product.toJson()).toList());
  //     put('recentSearched', productJson);
  //   } catch (e) {
  //     safePrint(e);
  //   }
  // }

  // static Future<void> clearRecentSearch() async {
  //   try {
  //     put('recentSearched', "");
  //   } catch (e) {
  //     safePrint(e);
  //   }
  // }
}
