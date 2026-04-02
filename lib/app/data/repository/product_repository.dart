import 'package:stock_flow/app/data/db/database_helper.dart';
import 'package:stock_flow/app/data/models/product_model.dart';
import 'package:stock_flow/app/data/models/response/failure.dart';
import 'package:dartz/dartz.dart';

class ProductRepository {
  final db = DatabaseHelper();

  Future<Either<Failure, int>> insertProduct(ProductModel data) async {
    try {
      final result = await db.insert('product', data.toMap());
      return Right(result);
    } catch (e) {
      return Left(Failure("Gagal insert product: $e"));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final result = await db.getAll('product');
      final data = result.map((e) => ProductModel.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      return Left(Failure("Gagal ambil data: $e"));
    }
  }

  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await db.delete('product', id);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Gagal delete: $e"));
    }
  }

  Future<Either<Failure, bool>> updateProduct(ProductModel customer) async {
    try {
      final db = await DatabaseHelper.db;
      final updated = await db.update(
        "product",
        customer.toMap(),
        where: "id = ?",
        whereArgs: [customer.id],
      );
      return Right(updated > 0);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
