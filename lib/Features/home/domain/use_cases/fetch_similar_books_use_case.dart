import 'package:clean_arch_bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly_app/core/errors/failure.dart';
import 'package:clean_arch_bookly_app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchSimilarBooksUseCase extends UseCase<List<BookEntity>, int>{
  final HomeRepo homeRepo;

  FetchSimilarBooksUseCase(this.homeRepo);
  @override
  Future<Either<Failure,  List<BookEntity>>> call([int pageNumber = 0]) async {
    return await homeRepo.fetchSimilarBooks(pageNumber: pageNumber);
  }
}