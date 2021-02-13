//import 'package:ecommerce/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/product_grid.dart';
import '../providers/products_provider.dart';
import '../widget/badge.dart';
//import '../providers/cart.dart';
//import '../screen/cart_screen.dart';
import '../widget/app_drawer.dart';
import '../providers/auth.dart';

enum FilterOptions{
  Favorites,
  All,
}

class ProductsOverviewScreen  extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
  }


class _ProductsOverviewScreenState extends State<ProductsOverviewScreen>{
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); not working
    //Future.delayed(Duration.zero).then((_) {
     // Provider.of<Products>(context).fetchAndSetProducts();

  //  });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_){
      setState(() {
        _isLoading = false;
      });

      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
         actions: <Widget>[
           IconButton(
             icon: Icon(
               Icons.logout,
               color: Colors.white,
             ),
             onPressed: (){
               Provider.of<Auth>(context, listen: false).logout();
             },
           )
        //     PopupMenuButton(
        //       onSelected: (FilterOptions selectedValue) {
        //         setState(() {if (selectedValue == FilterOptions.Favorites){
        //           _showOnlyFavorites = true;
        //
        //         } else {
        //           _showOnlyFavorites = false;
        //         }
        //         });
        //       },
        //       icon: Icon(
        //         Icons.more_vert,
        //       ),
        //       itemBuilder: (_) => [
        //        PopupMenuItem(child: Text('Only Favorites'),
        //            value: FilterOptions.Favorites
        //        ),
        //         PopupMenuItem(child: Text(' Show All'),
        //             value: FilterOptions.All
        //         ),
        //     ],
        //     ),
            // Consumer <Cart>(
            //   builder: (_, cart, ch ) =>  Badge(
            //           child: ch,
            //           value: cart.itemCount.toString(),
            //       ),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.shopping_cart,
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(CartScreen.routeName);
            //     },
            //   ),
            // ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center (child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavorites),


    );
  }
}

