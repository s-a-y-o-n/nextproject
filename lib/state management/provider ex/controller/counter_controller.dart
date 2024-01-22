import 'package:flutter/material.dart';
import 'package:nextproject/state%20management/provider%20ex/model/count.dart';

class CounterProvider extends ChangeNotifier {
  Count _inccounter = Count(0);
  Count get counter_value => _inccounter;
  void increment_count() {
    _inccounter.value++;
    notifyListeners();
  }
}
