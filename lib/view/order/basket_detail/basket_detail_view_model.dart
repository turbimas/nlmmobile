import 'package:flutter/material.dart';
import 'package:nlmmobile/product/models/order/basket_total_model.dart';

class BasketDetailViewModel extends ChangeNotifier {
  BasketTotalModel basketTotal;
  BasketDetailViewModel({required this.basketTotal});
}
