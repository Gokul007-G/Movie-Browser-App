import 'package:get/get.dart';
import 'package:moviebrowserapp/core/network/dio_client.dart';
import 'package:moviebrowserapp/data/datasources/movie_remote_datasource.dart';
import 'package:moviebrowserapp/data/local/favorite_movie_service.dart';
import 'package:moviebrowserapp/data/repositories/movie_repository_impl.dart';
import 'package:moviebrowserapp/domain/usecases/get_movie_detail.dart';
import 'package:moviebrowserapp/presentation/movie_details/controllers/movie_detail_controller.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    final dio = DioClient.create();

    final dataSource = MovieRemoteDatasource(dio: dio);

    final repository = MovieRepositoryImpl(movieRemoteDatasource: dataSource);

    final useCase = GetMovieDetail(repository: repository);

    Get.lazyPut<MovieDetailController>(
      () => MovieDetailController(
        getMovieDetail: useCase,
        favoriteMovieService: Get.find<FavoriteMovieService>(),
      ),
    );
  }
}
