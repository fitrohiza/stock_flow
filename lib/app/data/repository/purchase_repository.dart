import 'package:stock_flow/app/data/db/database_helper.dart';
import 'package:stock_flow/app/data/models/purchase_model.dart';
import 'package:stock_flow/app/data/models/response/failure.dart';
import 'package:dartz/dartz.dart';

class PurchaseRepository {
  final db = DatabaseHelper();

  Future<Either<Failure, int>> insertPurchase(PurchaseModel data) async {
    try {
      final result = await db.insert('purchase', data.toMap());
      return Right(result);
    } catch (e) {
      return Left(Failure("Gagal insert purchase: $e"));
    }
  }

  Future<Either<Failure, List<PurchaseModel>>> getPurchases() async {
    try {
      final result = await db.getAll('purchase');
      final data = result.map((e) => PurchaseModel.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      return Left(Failure("Gagal ambil data: $e"));
    }
  }

  Future<Either<Failure, void>> deletePurchase(int id) async {
    try {
      await db.delete('purchase', id);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Gagal delete: $e"));
    }
  }

  Future<Either<Failure, bool>> updateProduct(PurchaseModel purchase) async {
    try {
      final db = await DatabaseHelper.db;
      final updated = await db.update(
        "purchase",
        purchase.toMap(),
        where: "id = ?",
        whereArgs: [purchase.id],
      );
      return Right(updated > 0);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
