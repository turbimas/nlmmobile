import 'package:flutter/material.dart';
import 'package:nlmmobile/product/constants/navigation_constants.dart';
import 'package:nlmmobile/view/auth/login/login_view.dart';
import 'package:nlmmobile/view/auth/register/register_view.dart';
import 'package:nlmmobile/view/main/main_view.dart';
import 'package:nlmmobile/view/main/search/search_view.dart';
import 'package:nlmmobile/view/user/user_addresses/user_addresses_view.dart';
import 'package:nlmmobile/view/user/user_cards/user_cards_view.dart';
import 'package:nlmmobile/view/user/user_orders/user_orders_view.dart';
import 'package:nlmmobile/view/user/user_promotions/promotions_view.dart';
import 'package:nlmmobile/view/user/user_questions/user_questions_view.dart';
import 'package:nlmmobile/view/user/user_ratings/user_ratings_view.dart';
import 'package:nlmmobile/view/user/user_settings/user_settings_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Map<String, Widget Function(BuildContext)> routes = {
    NavigationConstants.mainView: (context) => const MainView(),
    NavigationConstants.login: (BuildContext context) => const LoginView(),
    NavigationConstants.register: (BuildContext context) =>
        const RegisterView(),
    NavigationConstants.userOrders: (BuildContext context) =>
        const UserOrdersView(),
    NavigationConstants.search: (BuildContext context) => const SearchView(),
    NavigationConstants.userPromotions: (BuildContext context) =>
        const UserPromotionsView(),
    NavigationConstants.userSettings: (BuildContext context) =>
        const UserSettingsView(),
    NavigationConstants.userCards: (BuildContext context) =>
        const UserCardsView(),
    NavigationConstants.userAddresses: (BuildContext context) =>
        const UserAddressesView(),
    NavigationConstants.userRatings: (BuildContext context) =>
        const UserRatingsView(),
    NavigationConstants.userQuestions: (BuildContext context) =>
        const UserQuestionsView(),
  };
}
