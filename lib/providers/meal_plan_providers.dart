import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedMealsNotifier extends StateNotifier<List<Map<String, String>>> {
  SelectedMealsNotifier() : super([]);

  void addMeal(String imageUrl, String title, String calories) {
    final exists = state.any((m) => m['title'] == title);
    if (!exists) {
      state = [
        ...state,
        {'image': imageUrl, 'title': title, 'calories': calories},
      ];
    }
  }

  Map<String, String>? removeMeal(int index) {
    if (index >= 0 && index < state.length) {
      final removed = state[index];
      state = [...state]..removeAt(index);
      return removed;
    }
    return null;
  }

  void undoRemove(int index, Map<String, String> meal) {
    state = [...state]..insert(index, meal);
  }
}

final selectedMealsProvider =
    StateNotifierProvider<SelectedMealsNotifier, List<Map<String, String>>>(
      (ref) => SelectedMealsNotifier(),
    );

final carouselIndexProvider = StateProvider<int>((ref) => 0);

class SelectedDaysNotifier extends StateNotifier<Set<int>> {
  SelectedDaysNotifier() : super({});

  void toggleDay(int index) {
    if (state.contains(index)) {
      state = {...state}..remove(index);
    } else {
      state = {...state}..add(index);
    }
  }
}

final selectedDaysProvider =
    StateNotifierProvider<SelectedDaysNotifier, Set<int>>(
      (ref) => SelectedDaysNotifier(),
    );

final lastRemovedProvider = StateProvider<Map<String, String>?>((ref) => null);

final lastRemovedIndexProvider = StateProvider<int?>((ref) => null);

final listKeyProvider = StateProvider<GlobalKey<AnimatedListState>>(
  (ref) => GlobalKey<AnimatedListState>(),
);
