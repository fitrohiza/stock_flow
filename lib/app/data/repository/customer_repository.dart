import 'package:stock_flow/app/data/db/database_helper.dart';
import 'package:stock_flow/app/data/models/customer_model.dart';
import 'package:stock_flow/app/data/models/response/failure.dart';
import 'package:dartz/dartz.dart';

class CustomerRepository {
  final DatabaseHelper db = DatabaseHelper();

  Future<Either<Failure, int>> insertCustomer(CustomerModel data) async {
    try {
      final result = await db.insert('customer', data.toMap());
      return Right(result);
    } catch (e) {
      return Left(Failure("Gagal insert customer: $e"));
    }
  }

  Future<Either<Failure, List<CustomerModel>>> getCustomers() async {
    try {
      final result = await db.getAll('customer');
      final data = result.map((e) => CustomerModel.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      return Left(Failure("Gagal ambil data: $e"));
    }
  }

  Future<Either<Failure, void>> deleteCustomer(int id) async {
    try {
      await db.delete('customer', id);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Gagal delete: $e"));
    }
  }

  Future<Either<Failure, bool>> updateCustomer(CustomerModel customer) async {
    try {
      final db = await DatabaseHelper.db;
      final updated = await db.update(
        "customer",
        customer.toMapUpdate(),
        where: "id = ?",
        whereArgs: [customer.id],
      );
      return Right(updated > 0);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
