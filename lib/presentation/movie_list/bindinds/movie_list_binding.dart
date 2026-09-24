import 'package:get/instance_manager.dart';
import 'package:moviebrowserapp/core/network/dio_client.dart';
import 'package:moviebrowserapp/data/datasources/movie_remote_datasource.dart';
import 'package:moviebrowserapp/data/repositories/movie_repository_impl.dart';
import 'package:moviebrowserapp/domain/usecases/get_movies.dart';
import 'package:moviebrowserapp/presentation/movie_list/controllers/movie_list_controller.dart';

class MovieListBinding extends Bindings {
  @override
  void dependencies() {
    // Data layer
    final dio = DioClient.create();

    final dataSource = MovieRemoteDatasource(dio: dio);

    final repository = MovieRepositoryImpl(movieRemoteDatasource: dataSource);

    // Domain layer
    final useCase = GetMovies(repository: repository);

    // Presentation layer
    Get.lazyPut<MovieListController>(
      () => MovieListController(getMovies: useCase),
    );
  }
}
