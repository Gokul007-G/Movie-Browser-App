import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:moviebrowserapp/core/errors/failures.dart';
import 'package:moviebrowserapp/core/errors/logger.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/domain/entities/movie.dart';
import 'package:moviebrowserapp/domain/usecases/get_movies.dart';

class MovieListController extends GetxController {
  final GetMovies getMovies;

  MovieListController({required this.getMovies});

  //store the movies
  final movies = <Movie>[].obs;

  // Original movies from API
  final allMovies = <Movie>[].obs;

  //variables
  final isLoading = false.obs;
  final isFilter = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;

  int currentPage = 1;
  bool hasMore = true;

  final isSearch = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void setMovies(List<Movie> data) {
    allMovies.assignAll(data);
    movies.assignAll(data);
  }

  void searchMovies(String value) {
    final query = value.trim().toLowerCase();

    // Empty search → show all movies
    if (query.isEmpty) {
      movies.assignAll(allMovies);
      return;
    }

    final filteredMovies = allMovies.where((movie) {
      final title = movie.title.toLowerCase();

      return title.contains(query);
    }).toList();

    movies.assignAll(filteredMovies);
  }

  void filterByRating(double? minimumRating) {
    if (minimumRating == null) {
      assignAllMovies();
      return;
    }

    final filteredMovies = allMovies.where((movie) {
      return movie.voteAverage >= minimumRating;
    }).toList();

    movies.assignAll(filteredMovies);
    isFilter.value = true;
  }

  void assignAllMovies() {
    movies.assignAll(allMovies);
    isFilter.value = false;
  }

  void openSearch() {
    isSearch.value = true;
  }

  // Close search and restore previous movies
  void closeSearch() {
    searchController.clear();

    // Restore complete API movie list
    movies.assignAll(allMovies);

    isSearch.value = false;
  }

  // Clear search only
  void clearSearch() {
    searchController.clear();

    // Restore complete API movie list
    movies.assignAll(allMovies);
  }

  //fetch the movies list
  Future<void> fetchMovies() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      currentPage = 1;

      final result = await getMovies.call(page: currentPage);

      if (currentPage == 1) {
        setMovies(result);
      } else {
        allMovies.addAll(result);
        movies.addAll(result);
      }

      hasMore = result.isNotEmpty;
    } on Failures catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  // Load more movies
  Future<void> loadMore() async {
    // Prevent multiple API calls
    if (isLoading.value || isLoadingMore.value || !hasMore) {
      return;
    }

    try {
      isLoadingMore.value = true;

      final nextPage = currentPage + 1;

      final result = await getMovies(page: nextPage);

      if (result.isEmpty) {
        hasMore = false;

        Get.snackbar(
          'No More Movies',
          'There are no more movies to load.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.surface,
          colorText: AppColors.textPrimary,
          icon: const Icon(
            Icons.movie_outlined,
            color: AppColors.textSecondary,
          ),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
      } else {
        currentPage = nextPage;
        movies.addAll(result);
      }
    } on Failures catch (e) {
      Logger.e(e.message);
      Get.snackbar(
        'Connection Error',
        'Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.surface,
        colorText: AppColors.textPrimary,
        icon: const Icon(Icons.wifi_off_rounded, color: AppColors.error),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
    } finally {
      // Important: reset loading-more state
      isLoadingMore.value = false;
    }
  }

  //refersh the page
  Future<void> refreshMovies() async {
    await fetchMovies();
  }
}
