import 'package:flutter/material.dart';
import 'package:myshop/ui/products/edit_product_screen.dart';
import 'ui/screens.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProducsManager()
          ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager()
        )
      ],
      child: MaterialApp(
        // return MaterialApp(
            title: 'My Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
              ).copyWith(
                secondary: Colors.deepOrange,
              ),
            ),
            home: const ProductsOverviewScreen(),
            routes: {
              CartScreen.routeName: 
                (ctx) => const CartScreen(),
              OrdersScreen.routeName: 
                (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName: 
                (ctx) => const UserProductsScreen(),
              },
              onGenerateRoute: (setting) {
                if (setting.name == EditProductScreen.routeName) {
                  final productId = setting.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditProductScreen(
                        productId != null
                        ? ctx.read<ProducsManager>().findById(productId)
                        : null,
                      );
                    },
                  );
                }


                // if (setting.name == ProductDetailScreen.routeName) {
                //   final productId = setting.arguments as String;
                // return MaterialPageRoute(
                //   builder: (ctx) {
                //     return ProductDetailScreen(
                //       ProducsManager().findById(productId)!,
                //       );
                //     },
                //   );
                // }
                  return null;
              },
          ),
      );
  }

}

