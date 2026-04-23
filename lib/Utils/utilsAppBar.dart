import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Views/Drawer/cusDrawer.dart';

//  for Login and Sign Up
AppBar formAppBar({required Widget title }){
  return AppBar(
    title: title,
    //leading: const Icon(Icons.menu),
    foregroundColor: Colors.white,
    backgroundColor: Colors.deepOrange,
    shadowColor: Colors.black,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
    ),
  );
}


// for MyHomepage

// lib/Views/Shared/appbar_custom.dart
// adjust to where your iconLogoutBtn exists


AppBar appBarCus({
  required BuildContext context,
  required bool isSearching,
  required TextEditingController searchController,
  required VoidCallback onFilterPressed,
  required VoidCallback onSearchPressed,
  required VoidCallback onClearSearch,
}) {
  return AppBar(
    title: isSearching
        ? TextField(

      controller: searchController,
      autofocus: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search by title...",
        hintStyle: const TextStyle(color: Colors.white70),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: onClearSearch,
        ),
      ),
      onChanged: (_) => onSearchPressed(),
    )
        : Text("My Tasks"),
    leading: IconButton(
        onPressed: (){

          cusDrawer(context);
        }, 
        icon: Icon(Icons.menu)),
    foregroundColor: Colors.white,
    backgroundColor: Colors.deepOrange,
    shadowColor: Colors.black,
    centerTitle: true,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),

    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: onSearchPressed,
      ),
      IconButton(
        icon: const Icon(Icons.filter_alt),
        onPressed: onFilterPressed,
      ),
    ],

    elevation: 10,
  );
}
