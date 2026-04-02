import 'package:stock_flow/app/data/db/database_helper.dart';
import 'package:stock_flow/app/data/models/brand_model.dart';
import 'package:stock_flow/app/data/models/response/failure.dart';
import 'package:dartz/dartz.dart';

class BrandRepository {
  final db = DatabaseHelper();

  Future<Either<Failure, int>> insertBrand(BrandModel data) async {
    try {
      final result = await db.insert('brand', data.toMap());
      return Right(result);
    } catch (e) {
      return Left(Failure("Gagal insert brand: $e"));
    }
  }

  Future<Either<Failure, List<BrandModel>>> getBrands() async {
    try {
      final result = await db.getAll('brand');
      final data = result.map((e) => BrandModel.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      return Left(Failure("Gagal ambil data: $e"));
    }
  }

  Future<Either<Failure, void>> deleteBrand(int id) async {
    try {
      await db.delete('brand', id);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Gagal delete: $e"));
    }
  }

  Future<Either<Failure, bool>> updateBrand(int id, BrandModel brand) async {
    try {
      final db = await DatabaseHelper.db;
      final updated = await db.update(
        "brand",
        brand.toMapUpdate(),
        where: "id = ?",
        whereArgs: [brand.id],
      );
      return Right(updated > 0);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
