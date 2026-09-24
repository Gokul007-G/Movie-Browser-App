import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/additional_Info.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/adult_badge.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/error_view.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/genre_list.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/home_page_button.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/movie_meta_section.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/poster.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/rating_section.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/selection_title.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return ErrorView(
            message: controller.errorMessage.value,
            onRetry: controller.fetchMovieDetail,
          );
        }

        final movie = controller.movie.value;

        if (movie == null) {
          return const Center(
            child: Text(
              'Movie details not available',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            _buildHeader(movie),
            SliverToBoxAdapter(child: _buildMovieContent(movie)),
          ],
        );
      }),
    );
  }

  SliverAppBar _buildHeader(MovieDetails movie) {
    return SliverAppBar(
      expandedHeight: 390,
      pinned: true,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,

      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
        ),
      ),

      actions: [
        Obx(
          () => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: controller.toggleFavorite,
              icon: Icon(
                controller.isFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: controller.isFavorite.value
                    ? AppColors.primary
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,

        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: '${ApiConstants.imageBaseUrl}${movie.backdropPath}',
              fit: BoxFit.cover,

              placeholder: (_, __) {
                return Container(
                  color: AppColors.surface,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              },

              errorWidget: (_, __, ___) {
                return Container(
                  color: AppColors.surface,
                  child: const Icon(
                    Icons.movie_outlined,
                    color: AppColors.textMuted,
                    size: 60,
                  ),
                );
              },
            ),

            // Dark overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.35),
                    AppColors.background.withOpacity(0.98),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),

            if (movie.adult)
              Positioned(top: 110, right: 16, child: AdultBadge()),

            // Poster
            Positioned(left: 16, bottom: 24, child: Poster(movie)),

            // Movie title beside poster
            Positioned(
              left: 145,
              right: 16,
              bottom: 30,
              child: Text(
                movie.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieContent(MovieDetails movie) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movie.tagline.isNotEmpty) ...[
            Text(
              movie.tagline,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 18),
          ],

          RatingSection(movie: movie),

          const SizedBox(height: 20),

          MovieMetaSection(movie: movie),

          const SizedBox(height: 24),

          if (movie.genres.isNotEmpty) ...[
            const SectionTitle(title: 'Genres'),
            const SizedBox(height: 10),
            GenreList(genres: movie.genres),
            const SizedBox(height: 24),
          ],

          const SectionTitle(title: 'About the Movie'),

          const SizedBox(height: 10),

          Text(
            movie.overview,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          AdditionalInfo(movie: movie),

          const SizedBox(height: 24),

          if (movie.homepage.isNotEmpty) HomePageButton(url: movie.homepage),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
