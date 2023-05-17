import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastCartRepository implements LocalCartRepository {

  SembastCartRepository(this.db);
  final Database db;

  static Future<Database> createDB(String fileName) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return databaseFactoryIo.openDatabase('${appDocDir.path}/$fileName}');
  }

  static Future<SembastCartRepository> makeDefault() async {
    return SembastCartRepository(await createDB('default.db'));
  }

  @override
  Future<Cart> fetchCart() {
    // TODO: implement fetchCart
    throw UnimplementedError();
  }

  @override
  Future<void> setCart(Cart cart) {
    // TODO: implement setCart
    throw UnimplementedError();
  }

  @override
  Stream<Cart> watchCart() {
    // TODO: implement watchCart
    throw UnimplementedError();
  }

}